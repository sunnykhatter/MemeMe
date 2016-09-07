//
//  Meme.swift
//  Memerr
//
//  Created by Lakshay Khatter on 9/3/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var topText = ""
    var bottomText = ""
    var image = UIImage()
    var memedImage = UIImage()
    
    init (topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = originalImage
        self.memedImage = memedImage
    }
    
}
