//
//  MemeCollectionViewController.swift
//  Memerr
//
//  Created by Lakshay Khatter on 9/3/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit



private let reuseIdentifier = "Cell"

let object = UIApplication.sharedApplication().delegate
let appDelegate = object as! AppDelegate

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate {

    
    @IBOutlet weak var collView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2*space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.collView.reloadData()
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {


        if (segue.identifier! == "toMemeView") {
            if let viewController: MemeViewController = segue.destinationViewController as? MemeViewController {
               let cell = sender as! UICollectionViewCell
                let indexPath = collView.indexPathForCell(cell)
                    viewController.image = appDelegate.memes[indexPath!.row].memedImage
            }
        }
    }
 

    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return appDelegate.memes.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let imageView = UIImageView(image: appDelegate.memes[indexPath.row].memedImage)
        cell.backgroundView = imageView
        return cell
    }



}
