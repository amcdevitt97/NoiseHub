//
//  FirstViewController.swift
//  openPost
//
//  Created by Alyssa McDevitt on 4/20/15.
//  Copyright (c) 2015 Alyssa McDevitt. All rights reserved.
//

import UIKit
import Parse
import Bolts

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
 
    
    @IBOutlet var myTableView: UITableView!
    var myDataArray: [String] = ["Loading content..."]
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        var query = PFQuery(className:"posts")
        query.whereKey("post", equalTo: "true")
        query.findObjectsInBackgroundWithBlock(
            { (objects: [AnyObject]?, error: NSError?) -> Void in
                
                // check your incoming data and try to cast to array of "posts" objects.
                if let foundPosts = objects as? [PFObject]
                {
                    // iterate over posts and try to extract the attribute you're after
                    for post in foundPosts
                    {
                        println("here")

                        // this won't crash if the value is nil
                        if let foundString = post.objectForKey("text") as? String
                        {
                            // found a good data value and was able to cast to string, add it to your array!
                            self.myDataArray.insert(foundString, atIndex: 1)
                            println(foundString)
                        }
                    }
                
                };
            
            self.myDataArray = objects as! [String]
            self.myTableView.reloadData()
        })
        
        
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
 

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = myDataArray[row]
        
        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(row)
    }

}