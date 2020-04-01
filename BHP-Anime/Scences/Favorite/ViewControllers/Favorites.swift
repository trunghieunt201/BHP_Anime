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
        self.title = "Favorites"
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
        
        let detailAnimeVC = DetailAnimeVC.loadFromNib()
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        self.hidesBottomBarWhenPushed  = true
        detailAnimeVC.id = listFavorite[indexPath.row].id
        topVC.navigationController?.pushViewController(detailAnimeVC, animated: true)
        self.hidesBottomBarWhenPushed = false
 
    }
    
    
}

extension Favorites: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 163)
    }
}

