//
//  PopularServices.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//


import Foundation
import Alamofire
import Moya


enum AnimeServices {
    case getAnime(sort_by : Int,with_genres: String, page: String)

    case getDetailAnime(id: String)
    
    case getSoundtrack(name: String)
}

extension AnimeServices: TargetType {
    
    var baseURL: URL {

        switch self {
            
        case .getAnime(_):
            return URL.init(string: "https://api.themoviedb.org/3/")!
        case .getDetailAnime(_):
            return URL.init(string: "https://api.themoviedb.org/3/tv/")!
            
        case .getSoundtrack(_):
            return URL.init(string: "https://itunes.apple.com/search")!
        }
        
    }
    
    var path: String {
        switch self {
        case .getAnime(let sort_by, let _, let _):
            if sort_by == 1{
                return "discover/tv"
            }else if sort_by == 2{
                return "tv/top_rated"
            }else{
                return "tv/on_the_air"
            }
        case .getDetailAnime(let id):
            return id
        case .getSoundtrack(_):
            return ""
            
        }

    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Moya.Data {
        return Moya.Data.init()
    }
    
    var task: Task {
        switch self {
        case .getAnime(let page):
            var param = Parameters()

            param["api_key"] = "647f1b2b2772a876099da5b545b40246"
            param["with_original_language"] = "ja"
//            param["sort_by"] = sort_by
            param["with_genres"] = 16
            param["page"] = page
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .getDetailAnime(_):
            var param = Parameters()
            param["api_key"] = "647f1b2b2772a876099da5b545b40246"
            param["append_to_response"] = "credits,images,videos"
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .getSoundtrack(let name):
            var param = Parameters()
            param["entity"] = "album"
            param["media"] = "music"
            param["term"] = name
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}


