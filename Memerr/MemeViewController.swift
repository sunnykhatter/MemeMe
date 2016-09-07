//
//  MemeViewController.swift
//  Memerr
//
//  Created by Lakshay Khatter on 9/6/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
