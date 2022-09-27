//
//  ViewController.swift
//  SampleAppSwift
//
//  Created by Pallab Maiti on 26/09/22.
//

import UIKit
import SnowplowTracker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let trackerConfig = TrackerConfiguration()
        trackerConfig.lifecycleAutotracking = true
        
    }


}

