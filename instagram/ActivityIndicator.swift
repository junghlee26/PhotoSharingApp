//
//  activityIndicator.swift
//  instagram
//
//  Created by Junghoon Lee on 8/8/18.
//  Copyright © 2018 Junghoon Lee. All rights reserved.
//

import UIKit

class ActivityIndicator: NSObject {
    var activityIndicator:UIActivityIndicatorView!
    
    func startActivityIndicator(uiView: UIViewController) {
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        self.activityIndicator.center = uiView.view.center
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        uiView.view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator(uiView: UIViewController) {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    
}
