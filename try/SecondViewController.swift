//
//  SecondViewController.swift
//  openPost
//
//  Created by Alyssa McDevitt on 4/20/15.
//  Copyright (c) 2015 Alyssa McDevitt. All rights reserved.
//

import UIKit
import Parse

class SecondViewController: UIViewController, UITextViewDelegate {

   
    @IBOutlet var submit: UIButton!
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate=self
        // Do any additional setup after loading the view, typically from a nib.
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    func textViewDidBeginEditing(textView: UITextView){
        textView.text=""
    }
    
    @IBAction func submitPressed(sender: AnyObject) {
        println("button")
        var textString = textView.text
        var length = count(textString)
        println(length)
        if(length>200){
            let alertController = UIAlertController(title: "Too many characters!", message:"Fix up your post to make it shorter", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            var postObject = PFObject(className:"posts")
            postObject["text"] = textView.text
            postObject["post"] = "true"
            postObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                
                println("Object has been saved.")
            }
            
            self.tabBarController?.selectedIndex = 0
        }
        
        
      
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

    

  

}

