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
    
    @IBOutlet weak var viewPoster: UIView!
    
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
    
    @IBOutlet weak var lblAddList: UILabel!
    
    @IBOutlet weak var imgAddList: UIImageView!
    
    @IBOutlet weak var collectionViewGallery: UICollectionView!
    
    @IBOutlet weak var viewGallery: UIView!
    
    @IBOutlet weak var viewCast: UIView!
    
    @IBOutlet weak var viewCrew: UIView!
    
    @IBOutlet weak var collectionViewCast: UICollectionView!
    
    @IBOutlet weak var collectionViewCrew: UICollectionView!
    
    var id : String?
    var item: DetailItems?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    func configUI() {
        navTitle.text = item?.title
        viewTime.layer.cornerRadius = 12
        lblTime.text = "Released " + (item?.releaseDate ?? "")
        viewPoster.layer.cornerRadius = 16
        imgPoster.layer.cornerRadius = 16
        viewPoster.addShadow(offset: CGSize(width: 2, height: 6), color: .black, radius: 12, opacity: 0.5)
        collectionViewGallery.backgroundColor = .groupTableViewBackground
        collectionViewCrew.backgroundColor = .groupTableViewBackground
        collectionViewCast.backgroundColor = .groupTableViewBackground
        viewGallery.backgroundColor = .groupTableViewBackground
        viewCast.backgroundColor = .groupTableViewBackground
        viewCrew.backgroundColor = .groupTableViewBackground
        viewGallery.layer.cornerRadius = 8
        viewCast.layer.cornerRadius = 8
        viewCrew.layer.cornerRadius = 8
        viewGallery.addShadow(offset: CGSize(width: 0, height: 0), color: UIColor.black, radius:  4, opacity:  0.25)
         viewCast.addShadow(offset: CGSize(width: 0, height: 0), color: UIColor.black, radius:  4, opacity:  0.25)
         viewCrew.addShadow(offset: CGSize(width: 0, height: 0), color: UIColor.black, radius:  4, opacity:  0.25)
        
        configCollectionView()
        
        
        checkListFavorite()
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
    
    func configCollectionView() {
        self.collectionViewGallery.dataSource = self
        self.collectionViewGallery.delegate = self
        self.collectionViewGallery.registerCell(GalleryCell.className)
        
        self.collectionViewCast.dataSource = self
        self.collectionViewCast.delegate = self
        self.collectionViewCast.registerCell(ProfileCell.className)
        
        
        self.collectionViewCrew.dataSource = self
        self.collectionViewCrew.delegate = self
        self.collectionViewCrew.registerCell(ProfileCell.className)
        
        
        if self.item?.images?.backdrops?.count == 0{
            self.viewGallery.isHidden = true
        }
        if self.item?.credits?.cast?.count == 0{
             self.viewCast.isHidden = true
        }
        if self.item?.credits?.crew?.count == 0{
             self.viewCrew.isHidden = true
        }
    }
    
    
    func getDetailItems() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        AnimeAPIManager.sharedInstance.getDetailItems(id: self.id ?? "0", success: { (detailItems) in
            self.item = detailItems
            hud.dismiss()
            self.collectionViewGallery.reloadData()
            self.configUI()
        }) { (error) in
            print(error)
        }
    }
    func checkListFavorite() {
        if self.item?.videos?.results?.count != 0{
            StorageFavorite.sharedInstance.loadFavorites(success: { (listFavorite) in
                let listFavorites = listFavorite
                let results = listFavorites.filter { $0.id == String(self.item?.id ?? 0)}
                if results.isEmpty == false{
                    self.lblAddList.text = "Added To My List"
                    self.viewAddList.backgroundColor = UIColor(red:0.36, green:0.55, blue:0.96, alpha:0.6)
                    self.imgAddList.image = UIImage(named: "ic_tick-1")
                }else{
                    self.lblAddList.text = "Add To My List"
                    self.viewAddList.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.3)
                    self.imgAddList.image = UIImage(named: "ic_plus-1")
                }
            }) {
                self.lblAddList.text = "Add To My List"
                self.viewAddList.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.3)
                self.imgAddList.image = UIImage(named: "ic_plus-1")
            }
        }
    }
    @IBAction func actionBack(_ sender: Any) {
        self.hidesBottomBarWhenPushed = false
        self.popViewController()
        
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
                    let row = listFavorite.firstIndex{$0.id == String(self.item?.id ?? 0)}
                    listFavorites.remove(at: row ?? 10000)
                    StorageFavorite.sharedInstance.saveFavorites(listFavorites: listFavorites)
                    self.lblAddList.text = "Add To My List"
                    self.viewAddList.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.3)
                    self.imgAddList.image = UIImage(named: "ic_plus-1")
                }else{
                    
                    listFavorites.append(item)
                    StorageFavorite.sharedInstance.saveFavorites(listFavorites: listFavorites)
                    //                    self.showToast(position: .bottom, message: "Success")
                    self.lblAddList.text = "Added To My List"
                    self.viewAddList.backgroundColor = UIColor(red:0.36, green:0.55, blue:0.96, alpha:0.6)
                    self.imgAddList.image = UIImage(named: "ic_tick-1")
                }
            }) {
                var listFavorite :[ObFavorite]  = []
                let item = ObFavorite.init(id: String(self.item?.id ?? 0), key: self.item?.videos?.results?[0].key ?? "", posterPath: self.item?.posterPath ?? "")
                listFavorite.append(item)
                StorageFavorite.sharedInstance.saveFavorites(listFavorites: listFavorite)
            }
        }
        
    }
    
    @IBAction func actionPlayNow(_ sender: Any) {

        let soundTrackVC = SoundTrackVC.loadFromNib()
        soundTrackVC.name = self.item?.title
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(soundTrackVC, animated: true)
        
    }
    
    func playVideo() {
        if item?.videos?.results?.count != 0{
            
            let playVideo = PlayerVideoVC.loadFromNib()
            playVideo.nameVideo = item?.title
            playVideo.key = item?.videos?.results?[0].key
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(playVideo, animated: true)
            
        }else{
            self.showToastAtBottom(message: "Video does not exist")
        }
        
        
    }
}


extension DetailAnimeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewGallery{
            return self.item?.images?.backdrops?.count ?? 0
        }else if collectionView == self.collectionViewCast{
            return self.item?.credits?.cast?.count ?? 0
        }else {
            return self.item?.credits?.crew?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewGallery{
            let cell = collectionViewGallery.dequeueReusableCell(withReuseIdentifier: GalleryCell.className, for: indexPath) as! GalleryCell
            let url = URL(string: "https://image.tmdb.org/t/p/w500/" + (self.item?.images?.backdrops?[indexPath.row].filePath ?? "/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg"))
            cell.img.kf.setImage(with: url)
            
            return cell
        }else if collectionView == self.collectionViewCast{
            let cell = collectionViewCast.dequeueReusableCell(withReuseIdentifier: ProfileCell.className, for: indexPath) as! ProfileCell
            if let strUrl =  self.item?.credits?.cast?[indexPath.row].profilePath{
                let url = URL(string: "https://image.tmdb.org/t/p/w500/" + strUrl)
                cell.img.kf.setImage(with: url)
            }else{
                cell.img.image = UIImage(named: "account")
            }
            cell.name.text = self.item?.credits?.cast?[indexPath.row].name
            return cell
        }else{
            let cell = collectionViewCrew.dequeueReusableCell(withReuseIdentifier: ProfileCell.className, for: indexPath) as! ProfileCell
            if let strUrl =  self.item?.credits?.crew?[indexPath.row].profilePath{
                let url = URL(string: "https://image.tmdb.org/t/p/w500/" + strUrl)
                cell.img.kf.setImage(with: url)
            }else{
                cell.img.image = UIImage(named: "account")
            }
            
            cell.name.text = self.item?.credits?.crew?[indexPath.row].name
            return cell
        }
        
        
    }
    
    
}

extension DetailAnimeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewGallery{
            return CGSize(width: 190, height: 106.88)
        }else if collectionView == self.collectionViewCast{
            return CGSize(width: 120, height: 240)
        }else {
            return CGSize(width: 120, height: 240)
        }
        
    }
}
