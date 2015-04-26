//
//  JMPlaylistViewController.swift
//  Jari Martens
//
//  Created by Jari Martens on 20-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit
import AVFoundation

final class JMPlaylistViewController: JMViewController, UITableViewDataSource, UITableViewDelegate, SPTAudioStreamingPlaybackDelegate {
    
    //MARK: - Lazy Variables
    //###########################################################
    
    private lazy var player: SPTAudioStreamingController = {
        let auth = SPTAuth.defaultInstance()
        let player = SPTAudioStreamingController(clientId: auth.clientID)
        player.playbackDelegate = self
        player.diskCache = SPTDiskCache(capacity: 1024 * 1024 * 64)
        player.loginWithSession(auth.session) { (error: NSError?) in
            if error != nil { println("\(error?.localizedDescription)") }
        }
        return player
    }()
    
    private lazy var tableView: JMTableView = {
        [unowned self] in
        
        let tempFrame = CGRectMake(0, self.signOutButton.frame.origin.y + self.signOutButton.frame.height, self.view.frame.width, self.view.frame.height-self.toolbar.frame.height-(self.tabBarController?.tabBar.frame.height ?? 0)-(self.signOutButton.frame.origin.y + self.signOutButton.frame.height))
        let tableView = JMTableView(frame: tempFrame)
        tableView.registerClass(JMTrackTableViewCell.self, forCellReuseIdentifier: "reuseID")
        return tableView
        }()
    
    //###########################################################
    
    
    
    //MARK: - IBOutlets
    //###########################################################
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songProgress: UISlider!
    @IBOutlet weak var albumImageView: JMImageView!
    @IBOutlet weak var signOutButton: UIButton!
    
    //###########################################################

    
    //MARK: - Other Variables
    //###########################################################

    var tracks: [SPTPlaylistTrack] = []
    private var timer = NSTimer()
    
    //###########################################################

    
    //MARK: - Overriding Functions
    //###########################################################
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        songName.adjustsFontSizeToFitWidth = true
        artistName.adjustsFontSizeToFitWidth = true
        view.addSubview(tableView)
        requestPlaylist()
    }
    
    //###########################################################

    
    //MARK: - User Interactions with Player
    //###########################################################

    @IBAction func signOut() {
        player.logout(nil)
        navigationController?.popViewControllerAnimated(false)
    }
    
    @IBAction func playPause(sender:UIBarButtonItem) {
        if player.isPlaying {
            player.setIsPlaying(false, callback: nil)
        }
        else {
            player.setIsPlaying(true, callback: nil)
        }
    }
    
    @IBAction func skipForward() {
        if Int(player.currentTrackIndex) < tracks.count - 1 {
            player.skipNext() { (error: NSError?) in
                if error != nil { println("\(error!.localizedDescription)") }
            }
        }
        else if Int(player.currentTrackIndex)  == tracks.count - 1 && tracks.count > 0{
            playFromIndex(0)
        }
    }
    
    @IBAction func skipBackward() {
        if Int(player.currentTrackIndex) > 0 {
            player.skipPrevious() { (error: NSError?) in
                if error != nil { println("\(error!.localizedDescription)") }
            }
        }
        else if Int(player.currentTrackIndex) == 0 && tracks.count > 0{
            playFromIndex(tracks.count-1)
        }
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        let newValue = player.currentTrackDuration * NSTimeInterval(sender.value)
        currentTimeLabel.text = NSTimeInterval.stringForTimeInterval(newValue)
        
        player.seekToOffset(newValue) { (error: NSError?) in
            if error != nil { println("\(error?.localizedDescription)") }
        }
    }
    
    //###########################################################
    
    
    //MARK: - Timer function
    
    func timerChanged(){
        currentTimeLabel.text = NSTimeInterval.stringForTimeInterval(player.currentPlaybackPosition)
        songProgress.value = Float(player.currentPlaybackPosition/player.currentTrackDuration)
    }

    
    //###########################################################

    
    //MARK: - Private Helper Functions
    
    private func requestPlaylist(){
        let auth = SPTAuth.defaultInstance()
        
        SPTPlaylistSnapshot.playlistWithURI(NSURL(string: "spotify:user:11154702334:playlist:3CJ1MTjkBnFja9Kkr7t7Cg")!, session: auth.session) { (error, playlistObject) -> Void in
            if let playlist = playlistObject as? SPTPlaylistSnapshot {
                if let tracks = playlist.tracksForPlayback() as? [SPTPlaylistTrack]{
                    self.tracks = tracks
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func playFromIndex(index: Int) {
        if tracks.count > 0 {
            var URIs: [AnyObject] = []
            for t in tracks {
                URIs.append(t.uri)
            }
            let callBack: SPTErrorableOperationCallback = { (error: NSError?) in
                if error != nil { println("\(error?.localizedDescription)") }
            }
            if !player.loggedIn {
                player.loginWithSession(SPTAuth.defaultInstance().session) { (error: NSError?) in
                    if error != nil { println("\(error?.localizedDescription)") }
                    else { self.player.playURIs(URIs, fromIndex: Int32(index), callback: callBack) }
                }
            }
            else {
                player.playURIs(URIs, fromIndex: Int32(index), callback: callBack)
            }
        }
    }
    
    private func updateUI(track possibleTrack: SPTTrack? = nil){
        if possibleTrack == nil {
            SPTTrack.trackWithURI(player.currentTrackURI, session: SPTAuth.defaultInstance().session, callback: { (error, data) in
                if let track = data as? SPTTrack {
                    //Check if data is still relevant
                    if track.uri == self.player.currentTrackURI {
                        self.updateUI(track: track)
                    }
                }
                else { println("updateUI Error: \(error?.localizedDescription)") }
            })
        }
        else {
            timer.invalidate()
            let track = possibleTrack!
            songName.text = track.name
            artistName.text = (track.artists.first! as! SPTPartialArtist).name
            let imageURL = (track.album.covers.first! as! SPTImage).imageURL
            albumImageView.image = UIImage(data: NSData(contentsOfURL: imageURL)!)
            songProgress.value = 0
            currentTimeLabel.text = "0:00"
            totalTimeLabel.text = NSTimeInterval.stringForTimeInterval(track.duration)
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerChanged", userInfo: nil, repeats: true)
        }
        
    }
    
    //###########################################################

    
    //MARK: - TableView DataSource & Delegate
    //###########################################################

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //updateUI(track: tracks[indexPath.row])
        playFromIndex(indexPath.row)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseID", forIndexPath: indexPath) as! JMTrackTableViewCell
        
        cell.representingTrack = tracks[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    //###########################################################
    
    
    //MARK: - AudioStreamingPlaybackDelegate
    //###########################################################
    
    //WARNING: SPTAudioStreamingControllerDelegate is very unreliable!!!
    func audioStreaming(audioStreaming: SPTAudioStreamingController!, didChangeToTrack trackMetadata: [NSObject : AnyObject]!) {
        println("test: \(trackMetadata[SPTAudioStreamingMetadataTrackURI])")
        updateUI()
    }
    
    func audioStreaming(audioStreaming: SPTAudioStreamingController!, didChangePlaybackStatus isPlaying: Bool) {
        if isPlaying {
            self.toolbar.items![2] = UIBarButtonItem(barButtonSystemItem: .Pause, target: self, action: "playPause:")
        }
        else {
            self.toolbar.items![2] = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "playPause:")
        }
    }
    
    //###########################################################
}
