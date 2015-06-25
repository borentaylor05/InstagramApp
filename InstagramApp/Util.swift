//
//  Util.swift
//  InstagramApp
//
//  Created by Taylor Boren on 6/24/15.
//  Copyright (c) 2015 Taylor Boren. All rights reserved.
//

import UIKit

class Util {
    
    func addSpinner(view: UIView?) -> UIActivityIndicatorView{
        //instantiate a gray Activity Indicator View
        var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        //add the activity to the ViewController's view
        view!.addSubview(activityIndicatorView)
        //position the Activity Indicator View in the center of the view
        activityIndicatorView.center = view!.center
        //tell the Activity Indicator View to begin animating
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    func removeSpinner(indicator:UIActivityIndicatorView){
        indicator.removeFromSuperview()
    }
    
}