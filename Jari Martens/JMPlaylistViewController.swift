//
//  JMPlaylistViewController.swift
//  Jari Martens
//
//  Created by Jari Martens on 20-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit
import AVFoundation

final class JMPlaylistViewController: JMViewController {
    
    var player: SPTAudioStreamingController?
    var tracks: [SPTPlaylistTrack] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestPlaylist()
    }
    
    func requestPlaylist(){
        let auth = SPTAuth.defaultInstance()
        
        /*SPTPlaylistSnapshot.playlistWithURI(NSURL(string: "spotify:user:11154702334:playlist:3CJ1MTjkBnFja9Kkr7t7Cg"), session: auth.session, callback: { (error, playlistObject) in
            let playlist = playlistObject as SPTPlaylistSnapshot
        }*/
        SPTPlaylistSnapshot.playlistWithURI(NSURL(string: "spotify:user:11154702334:playlist:3CJ1MTjkBnFja9Kkr7t7Cg")!, session: auth.session) { (error, playlistObject) -> Void in
            let playlist = playlistObject as! SPTPlaylistSnapshot
            println("\(playlist.description)")
            if let tracks = playlist.tracksForPlayback() as? [SPTPlaylistTrack]{
                self.tracks = tracks
                
            }
        }
    }
}
