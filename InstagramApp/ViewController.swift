//
//  ViewController.swift
//  InstagramApp
//
//  Created by Taylor Boren on 6/24/15.
//  Copyright (c) 2015 Taylor Boren. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImages("clararockmore")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        for subview in self.scrollView.subviews{
            subview.removeFromSuperview()
            searchBar.resignFirstResponder()
            var searchString = searchBar.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
            getImages(searchString)
        }
    }
    
    func getImages(tag:String){
        //var indicator = Util.addSpinner(view!)
        
        var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        view!.addSubview(activityIndicatorView)
        activityIndicatorView.center = view!.center
        activityIndicatorView.startAnimating()
        
        var imageUrls = [String]()
        let imageWidth = self.view.frame.width
        Alamofire.request(.GET, "https://api.instagram.com/v1/tags/\(tag)/media/recent?client_id=c20085ea9f36463fafe4ce5271743833")
            .responseJSON { (_, _, json, _) in
                let resp = JSON(json!)
                let numImages = resp["data"].count
                self.scrollView.contentSize = CGSizeMake(imageWidth, imageWidth * CGFloat(numImages))
                var urls = [String]()
                for (index: String, data: JSON) in resp["data"] {
                    if let url = data["images"]["standard_resolution"]["url"].string{
                        imageUrls.append(url)
                    }
                }
                var count = 0
                for url in imageUrls{
                    let imageData = NSData(contentsOfURL: NSURL(string: url)!)
                    if let imageDataUnwrapped = imageData{
                        let imageView = UIImageView(frame: CGRectMake(0, imageWidth*CGFloat(count), imageWidth, 320))
                        imageView.setImageWithUrl( NSURL(string: url)!)
                        self.scrollView.addSubview(imageView)
                    }
                    ++count
                }
                activityIndicatorView.removeFromSuperview()
        }
    }


}

