//
//  DarkNavigationController.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/10/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class DarkNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }

}

