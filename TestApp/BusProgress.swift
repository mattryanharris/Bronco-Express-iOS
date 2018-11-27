//
//  BusProgress.swift
//  TestApp
//
//  Created by Matthew Harris on 11/26/18.
//  Copyright © 2018 Matthew Harris. All rights reserved.
//

import UIKit

class BusProgress: UIProgressView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var progress: UIProgressView!
    
    self.progress.transform = self.progress.transform.scaledBy(x: 1, y: 5)
    self.progress.trackTintColor = #colorLiteral(red: 0.8900991082, green: 0.8902519345, blue: 0.8900894523, alpha: 1)
    
    self.progress.progressTintColor = #colorLiteral(red: 0, green: 0.7798785567, blue: 0, alpha: 1)
    
    self.progress.layer.cornerRadius = 5
    self.progress.clipsToBounds = true

}
