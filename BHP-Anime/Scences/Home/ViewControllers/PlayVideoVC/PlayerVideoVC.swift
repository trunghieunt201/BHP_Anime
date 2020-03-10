//
//  PlayerVideoVC.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import YoutubeKit

class PlayerVideoVC: UIViewController {
    private var player: YTSwiftyPlayer!
    var key: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Youtube"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        player = YTSwiftyPlayer(
            frame: CGRect(x: 0, y: 0, width: 640, height: 480),
            playerVars: [.videoID((key ?? ""))])
        
        player.autoplay = true
        view = player
        player.delegate = self
        player.loadPlayer()
        player.goBack()
        // Do any additional setup after loading the view.
    }
    
    
    
}
extension PlayerVideoVC: YTSwiftyPlayerDelegate{
  
}
