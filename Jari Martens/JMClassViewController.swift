//
//  JMClassViewController.swift
//  Jari Martens
//
//  Created by Jari Martens on 16-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

final class JMClassViewController: JMViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    private lazy var tableView: JMTableView = {
        [unowned self] in
        
        let tempFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-(self.tabBarController?.tabBar.frame.height ?? 0))
        let tableView = JMTableView(frame: tempFrame)
        tableView.registerClass(JMClassTableViewCell.self, forCellReuseIdentifier: "reuseID")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JMClasses.all_values.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseID", forIndexPath: indexPath) as! JMClassTableViewCell
    
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        cell.backgroundColor = UIColor.clearColor()
        cell.representingClass = JMClasses.all_values[indexPath.row]
        
        return cell
    }
    
    /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return max(tableView.frame.height/CGFloat(JMClasses.all_values.count), 35)
    }*/

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        performSegueWithIdentifier("showDescription", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDescription", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch JMClasses.all_values[indexPath.row] {
        case .IB, .MO, .PE, .RE:
            return 70
        default:
            return 35//super.tableView(tableView: tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My curriculum"
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "showDescription" {
                let cell = sender as! JMClassTableViewCell
                if let tvc = segue.destinationViewController as? JMClassDescriptionViewController {
                    tvc.text = "\(cell.representingClass.description)"
                    if let ppc = tvc.popoverPresentationController {
                        ppc.sourceRect = cell.superview!.convertRect(cell.frame, toView: view)
                        ppc.delegate = self
                    }
                    
                }
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
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
