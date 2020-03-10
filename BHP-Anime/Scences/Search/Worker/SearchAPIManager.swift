//
//  SearchAPIManager.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/7/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//


import Foundation
import Moya
import SwiftyJSON

struct SearchAPIManager {
    static let sharedInstance = SearchAPIManager()
    let provider = MoyaProvider<SearchServices>()
    func listPopular(query : String, page: String,success :  @escaping ([Popular]) -> Void,failed :  @escaping (String) -> Void) {
        var listPopular : [Popular] = []
        
        provider.request(.getAnime(query : query, page: page)) { (result) in
            
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
}
