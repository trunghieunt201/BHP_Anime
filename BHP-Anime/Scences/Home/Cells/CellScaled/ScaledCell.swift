//
//  ScaledCell.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout


class ScaledCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listItems : [Popular] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        
        setuplayout()
    }
    
    override func setSelected(_
        selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setuplayout()  {
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 220)
        layout.scrollDirection = .horizontal
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 17)
        collectionView.collectionViewLayout = layout
        collectionView.registerCell(ItemsCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    
}

extension ScaledCell: UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.className, for: indexPath) as! ItemsCell
        //          cell.bgImageView.image = UIImage.init(named: datas[indexPath.row])
        cell.configCell(listItems[indexPath.row])
        //        cell.layer.shadowPath = shadowPath0.cgPath
        
        cell.addShadow(offset: CGSize(width: 4, height: 4), color: .black, radius: 10, opacity: 0.4)
        cell.layer.cornerRadius = 16
        
        return cell
    }
    
    
}

extension ScaledCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailAnimeVC = DetailAnimeVC.loadFromNib()
        detailAnimeVC.id = String(listItems[indexPath.row].id ?? 0)
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        topVC.hidesBottomBarWhenPushed = true
        topVC.navigationController?.pushViewController(detailAnimeVC, animated: true)
        topVC.hidesBottomBarWhenPushed = false
    }
}
