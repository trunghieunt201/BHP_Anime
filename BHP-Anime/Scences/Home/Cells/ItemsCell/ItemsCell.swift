//
//  ItemsCell.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/5/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit




class ItemsCell: UICollectionViewCell{

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(_ item: Popular){

        
        if let strUrl = item.backdropPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/" + strUrl)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                if let data = data{
                    DispatchQueue.main.async {
                        self.img.image = UIImage(data: data)
                    }
                }
            }
        }else{
            self.img.image = UIImage(named: "test")
        }

    }

    
}
