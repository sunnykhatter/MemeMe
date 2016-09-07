//
//  MemeTableViewController.swift
//  Memerr
//
//  Created by Lakshay Khatter on 9/3/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var memeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    override func viewWillAppear(animated: Bool) {
        memeTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let memes = getMemes()
        return memes.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        cell.imageView?.image = appDelegate.memes[indexPath.row].memedImage
        cell.textLabel!.text = appDelegate.memes[indexPath.row].topText + " " + appDelegate.memes[indexPath.row].bottomText as String
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier! == "toMemeView") {
            if let viewController: MemeViewController = segue.destinationViewController as? MemeViewController {
                let index = memeTableView.indexPathForSelectedRow?.row
                viewController.image = appDelegate.memes[index!].memedImage
            }
        }
    }
    
    
    func  getMemes() -> [Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
        
    }

}
