//
//  DetailViewController.swift
//  Photos
//
//  Created by Kelly Hong on 11/16/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class DetailView: UIView {

    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var datePosted: UILabel!
    @IBOutlet weak var numLikes: UILabel!
    @IBOutlet weak var heart: UILabel!
    var img: Photo?
    
    @IBAction func like(sender: AnyObject) {
        if (img?.liked == false) {
           heart.text = "liked"
        } else {
            heart.text = "like"
        }
        
    }
    
    
    
}
