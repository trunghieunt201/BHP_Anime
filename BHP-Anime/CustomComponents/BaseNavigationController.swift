//
//  BaseNavigationController.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//


import UIKit

class BaseNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }

}
