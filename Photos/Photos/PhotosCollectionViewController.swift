//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos: [Photo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
//        self.collectionView?.backgroundColor = UIColor.yellowColor()
        
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotoCellController
        if ((photos) != nil) {
            dispatch_async(dispatch_get_main_queue()) {
                self.loadImageForCell(self.photos[indexPath.row], imageView: cell.image)
            }
        }

        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ((photos) != nil) {
            return photos.count
        } else {
            return 0
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//            let screen = UIScreen.mainScreen().bounds.size
//            return CGSizeMake(screen.width * 0.3, screen.height * 0.3)
//    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detailSeg", sender: indexPath)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "detailSeg") {
//            let indexPath = sender as! NSIndexPath
//            let detailView = segue.destinationViewController.view as! DetailView
//            if(photos != nil) {
//                loadImageForCell(photos[indexPath.row], imageView: detailView.photo)
//                let formatter = NSDateFormatter()
//                formatter.dateStyle = .MediumStyle
//                formatter.timeStyle = .MediumStyle
//                detailView.datePosted.text! += formatter.stringFromDate(photos[indexPath.row].datePosted)
//                detailView.username.text! += photos[indexPath.row].username
//                detailView.numLikes.text! += photos[indexPath.row].likes.description
//                detailView.img = photos[indexPath.row]
//                if(photos[indexPath.row].liked == false) {
//                    detailView.heart.text = "like"
//                } else {
//                    detailView.heart.text = "liked"
//                }
//            }
//        }
//    }
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage.
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: photo.url)!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                imageView.image = UIImage(data: data!)
            }
        }
        task.resume()
        
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

