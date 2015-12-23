//
//  ViewController.swift
//  code13
//
//  Created by Ethan Sherr on 12/22/15.
//  Copyright © 2015 Ethan Sherr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addThingsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var data = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        (1..<500).forEach { (value) -> () in
            data.append(value)
        }
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell") as! Cell
        
        cell.model = data[indexPath.row]
        cell.deleteBlock = {
            [weak self] in
            guard let strongSelf = self else { return }
            
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                //Background Thread
//                NSThread.sleepForTimeInterval(0.1)
//                dispatch_async(dispatch_get_main_queue(), {
                    strongSelf.data.removeAtIndex(indexPath.row)
                    tableView.reloadData()
//                })
            })
            

            
        }
        
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    @IBAction func addThingsAction(sender: AnyObject) {
        data.removeAll()
        tableView.reloadData()
        
        (1..<80).forEach { (value) -> () in
            let randomSleep = Double.random(0, 1.3) + 3
            
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    NSThread.sleepForTimeInterval(randomSleep)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.data.append(value)
                        self.tableView.reloadData()
                    })
            })
        }
        
    }

}

public extension Double {
    /// SwiftRandom extension
    public static func random(lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}
