//
//  Favorites.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/9/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

//
//  Favorites.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import JGProgressHUD

class Favorites: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listFavorite: [ObFavorite] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        configUI()
    }
    func configUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(FavoriteCell.className)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        StorageFavorite.sharedInstance.loadFavorites(success: { (listFavorite) in
            self.listFavorite = listFavorite
            self.collectionView.reloadData()
            hud.dismiss()
        }) {
            self.listFavorite = []
            self.collectionView.reloadData()
            hud.dismiss()
        }
        
        
        
        
        //        let lbNavTitle = UILabel (frame: CGRect(x: 0, y: 40, width: 320, height: 40))
        //        lbNavTitle.center = CGPoint(x: 160, y: 285)
        //        lbNavTitle.textAlignment = .left
        //        lbNavTitle.text = "Favorite"
        //        self.navigationItem.titleView = lbNavTitle
        //
        //        let titleAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font: AppFonts.Verdana(50)]
        //
        //        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
}

extension Favorites: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listFavorite.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.className, for: indexPath) as! FavoriteCell
        cell.configCell(item: listFavorite[indexPath.row])
        cell.addShadow()
        cell.remove = {[weak self]()in
            StorageFavorite.sharedInstance.loadFavorites(success: { (listFavorite) in
                
                var listFavorites = listFavorite
                
                let alert = UIAlertController(title: "Do you want to delete it from your favorite list?", message: "", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (ok) in
                    listFavorites.remove(at: indexPath.row)
                    StorageFavorite.sharedInstance.saveFavorites(listFavorites: listFavorites)
                    self?.listFavorite = listFavorites
                    self?.showToast(position: .bottom, message: "Success")
                    self?.collectionView.reloadData()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                
                
                
            }) {
                return
            }
        }
        return cell
    }
    
    
}

extension Favorites: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //         player = YTSwiftyPlayer(
        //             frame: CGRect(x: 0, y: 0, width: 640, height: 480),
        //             playerVars: [.videoID(self.listFavorite[indexPath.row].key ?? "")])
        //         player.autoplay = true
        //         view = player
        //         player.delegate = self
        //         player.loadPlayer()
        
        let playVideo = PlayerVideoVC.loadFromNib()
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        self.hidesBottomBarWhenPushed  = true
        playVideo.key = self.listFavorite[indexPath.row].key
        topVC.navigationController?.present(playVideo, animated: true, completion: nil)
        self.hidesBottomBarWhenPushed = false
 
    }
    
    
}

extension Favorites: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 163)
    }
}

