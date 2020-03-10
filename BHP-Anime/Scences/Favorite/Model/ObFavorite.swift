//
//  ObFavorite.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation

class ObFavorite: NSObject, NSCoding {
    var id : String?
    var key : String?
    var posterPath : String?
    
    init(id: String, key : String,posterPath: String) {
        self.id = id
        self.key = key
        self.posterPath = posterPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        self.key = aDecoder.decodeObject(forKey: "key") as? String ?? ""
        self.posterPath = aDecoder.decodeObject(forKey: "posterPath") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(key, forKey: "key")
        aCoder.encode(posterPath, forKey: "posterPath")
    }
}
