//
//  MainViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/2/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func storyboardInstance() -> MainViewController {
        let storyboard = UIStoryboard(name: String(describing: MainViewController.self), bundle: nil)
        
        let mainViewController = storyboard.instantiateInitialViewController() as! MainViewController
        
        return mainViewController
    }

}
