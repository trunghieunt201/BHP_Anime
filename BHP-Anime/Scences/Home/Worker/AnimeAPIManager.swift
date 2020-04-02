//
//  PopularManager.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//


import Foundation
import Moya
import SwiftyJSON

struct AnimeAPIManager {
    static let sharedInstance = AnimeAPIManager()
    let provider = MoyaProvider<AnimeServices>()
    
    func listPopular(sortBy : Int,withGenres: String, page: String,success :  @escaping ([Popular]) -> Void,failed :  @escaping (String) -> Void) {
        var listPopular : [Popular] = []
        
        provider.request(.getAnime(sort_by: sortBy, with_genres: withGenres, page: page)) { (result) in
            
            switch result{
            case .success(let value):
                do {
                    let json = try JSON.init(data: value.data)
                    let results = json["results"].arrayValue
                    for result in results{
                        let popular = Popular.init(json: result)
                        listPopular.append(popular)
                    }
                    success(listPopular)
                } catch(let error) {
                    failed(error.localizedDescription)
                }
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }

    func getSoundtrack(name: String,success :  @escaping ([Soundtrack]) -> Void,failed :  @escaping (String) -> Void) {
        provider.request(.getSoundtrack(name: name)) { (result) in
            switch result{
            case .success(let value):
                do{
                    var listSoundtrack : [Soundtrack] = []
                    let json = try JSON.init(data: value.data)
                    let results = json["results"].arrayValue
                    for result in results{
                        let soundtrack = Soundtrack.init(json: result)
                        listSoundtrack.append(soundtrack)
                    }
                    success(listSoundtrack)
                }catch(let error){
                failed(error.localizedDescription)
                }
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
    
    func getDetailItems(id: String,success :  @escaping (DetailItems) -> Void,failed :  @escaping (String) -> Void) {
        
        provider.request(.getDetailAnime(id: id)) { (result) in
            switch result{
            case .success(let value):
                do {
                    let json = try JSON.init(data: value.data)
                    
                    let detailItems = DetailItems.init(json: json)
//                    let results = json["results"].arrayValue
                    success(detailItems)
                    
//                    success(de)
                } catch(let error) {
                    failed(error.localizedDescription)
                }
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
}
