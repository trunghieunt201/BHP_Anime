//
//  PlayerVideoVC.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import YouTubePlayer

class PlayerVideoVC: UIViewController {
    
@IBOutlet var videoPlayer: YouTubePlayerView!
    
    
//    private var player: YTSwiftyPlayer!
    var key: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
//        self.title = "Youtube"
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        playerVideo = YTSwiftyPlayer(
//            frame: CGRect(x: 0, y: 0, width: 640, height: 480),
//            playerVars: [.videoID((key ?? ""))])

        videoPlayer.loadVideoID(key ?? "")
        videoPlayer.play()
        
//        playerVideo.loadVideo(videoID: key ?? "")
//        playerVideo.autoplay = true
//        
//        playerVideo.delegate = self
//        playerVideo.loadPlayer()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actiondismiss(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    
}
