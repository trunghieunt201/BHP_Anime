//
//  DetailAnimeVC.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/5/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import Cosmos
import JGProgressHUD



class DetailAnimeVC: UIViewController {
    
    
    @IBOutlet weak var navTitle: UILabel!
    
    @IBOutlet weak var viewTime: UIView!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var imgPoster: UIImageView!
    
    @IBOutlet weak var viewAddList: UIView!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var lblViewer: UILabel!
    
    @IBOutlet weak var lblOverview: UILabel!
    
    @IBOutlet weak var outletPlayNow: UIButton!
    
    @IBOutlet weak var viewRating: CosmosView!
    
    
    
    var id : String?
    var item: DetailItems?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailItems()
        // Do any additional setup after loading the view.
    }
    func configUI() {
        navTitle.text = item?.title
        
        viewTime.layer.cornerRadius = 12
        lblTime.text = "Released " + (item?.releaseDate ?? "")
        
        imgPoster.layer.cornerRadius = 16
        //        imgPoster.addShadow(offset: CGSize(width: 0, height: 6), color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.15), radius: 16, opacity: 1)
        
        
        if let strUrl = item?.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/" + strUrl)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                if let data = data{
                    DispatchQueue.main.async {
                        self.imgPoster.image = UIImage(data: data)
                    }
                }
            }
        }
        
        
        viewAddList.layer.cornerRadius = 4
        
        
        
        if let genres = item?.genres{
            var arrayNameGenres : [String] = []
            for genre in genres{
                arrayNameGenres.append(genre.name ?? "")
            }
            lblCategory.text = arrayNameGenres.joined(separator: ", ")
        }
        
        
        viewRating.rating = Double((item?.voteAverage ?? 10)/10.0)*5
        viewRating.settings.fillMode = .precise
        lblRating.text = String(item?.voteAverage ?? 0)
        lblViewer.text = "(\(String(item?.voteCount ?? 0)))"
        lblOverview.text = item?.overview
        
        outletPlayNow.layer.cornerRadius = 6
        outletPlayNow.addShadow(offset: CGSize(width: -1, height: 2), color: .black, radius: 6, opacity: 0.25)
        
    }
    
    
    func getDetailItems() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        AnimeAPIManager.sharedInstance.getDetailItems(id: self.id ?? "0", success: { (detailItems) in
            self.item = detailItems
            hud.dismiss()
            self.configUI()
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true) {}
        
    }
    
    @IBAction func actionPlay(_ sender: Any) {
        playVideo()
    }
    
    @IBAction func actionAddList(_ sender: Any) {
        if self.item?.videos?.results?.count != 0{
            StorageFavorite.sharedInstance.loadFavorites(success: { (listFavorite) in
                let item = ObFavorite.init(id: String(self.item?.id ?? 0), key: self.item?.videos?.results?[0].key ?? "", posterPath: self.item?.posterPath ?? "")
                var listFavorites = listFavorite
                let results = listFavorites.filter { $0.id == String(self.item?.id ?? 0)}
                if results.isEmpty == false{
                    
                    self.showToastAtBottom(message: "The movie already exists in favorites")
                }else{
                    
                    listFavorites.append(item)
                    StorageFavorite.sharedInstance.saveFavorites(listFavorites: listFavorites)
                    self.showToast(position: .bottom, message: "Success")
                }
            }) {
                var listFavorite :[ObFavorite]  = []
                let item = ObFavorite.init(id: String(self.item?.id ?? 0), key: self.item?.videos?.results?[0].key ?? "", posterPath: self.item?.posterPath ?? "")
                listFavorite.append(item)
                StorageFavorite.sharedInstance.saveFavorites(listFavorites: listFavorite)
                self.showToast(position: .bottom, message: "Success")
            }
        }
        
    }
    
    @IBAction func actionPlayNow(_ sender: Any) {
        playVideo()
    }
    
    func playVideo() {
        //        let url = "https://www.youtube.com/watch?v=" + (item?.videos?.results?[0].id ?? "")
        if item?.videos?.results?.count != 0{
            //            player = YTSwiftyPlayer(
            //                        frame: CGRect(x: 0, y: 0, width: 640, height: 480),
            //                        playerVars: [.videoID((item?.videos?.results?[0].key ?? ""))])
            //
            //            player.autoplay = true
            //            view = player
            //            player.delegate = self
            //            player.loadPlayer()
            
            let playVideo = PlayerVideoVC.loadFromNib()
            
            playVideo.key = item?.videos?.results?[0].key
            
            self.present(playVideo, animated: true, completion: {
                return
            })
        }else{
            self.showToastAtBottom(message: "Video does not exist")
        }
        
        
    }
}


