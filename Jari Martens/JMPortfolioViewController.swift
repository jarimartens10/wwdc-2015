//
//  JMPortfolioViewController.swift
//  Jari Martens
//
//  Created by Jari Martens on 15-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

final class JMPortfolioViewController: JMViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableView: JMTableView = {
        [unowned self] in
        
        let tempFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-(self.tabBarController?.tabBar.frame.height ?? 0))
        let tableView = JMTableView(frame: tempFrame)
        tableView.registerClass(JMAppTableViewCell.self, forCellReuseIdentifier: "reuseID")
        tableView.scrollEnabled = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        view.addSubview(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Apps developed by me"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JMApps.all_values.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseID", forIndexPath: indexPath) as! JMAppTableViewCell
        
        cell.delegate = self
        cell.representingApp = JMApps.all_values[indexPath.row]
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? JMAppTableViewCell
        if cell?.representingApp.link != nil {
            UIApplication.sharedApplication().openURL(cell!.representingApp.link!)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height/2-10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 20))
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.clearColor()
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.boldSystemFontOfSize(18.0)
        return label
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
