//
//  SearchCell.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/6/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import Cosmos
class SearchCell: UITableViewCell {

    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleAnime: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = 6
        
        
    }
    func configCell(_ item : Popular){

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

        self.titleAnime.text = item.title
        self.time.text = item.releaseDate
        viewRating.rating = Double((item.voteAverage ?? 10)/10.0)*5
        viewRating.settings.fillMode = .precise
        lblRating.text = String(item.voteAverage ?? 0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
