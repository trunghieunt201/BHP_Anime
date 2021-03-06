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
    case getAnime(sort_by : String,with_genres: String, page: String)

    case getDetailAnime(id: String)
}

extension AnimeServices: TargetType {
    
    var baseURL: URL {

        switch self {
            
        case .getAnime(_):
            return URL.init(string: "https://api.themoviedb.org/3/discover/movie")!
        case .getDetailAnime(_):
            return URL.init(string: "https://api.themoviedb.org/3/movie/")!
            
        }
        
    }
    
    var path: String {
        switch self {
        case .getAnime(_):
            return ""
        case .getDetailAnime(let id):
            return id
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
        case .getAnime(let sort_by,let with_genres, let page):
            var param = Parameters()

            param["api_key"] = "647f1b2b2772a876099da5b545b40246"
            param["language"] = "en-US"
            param["sort_by"] = sort_by
            param["with_genres"] = with_genres
            param["page"] = page
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .getDetailAnime(_):
            var param = Parameters()
            param["api_key"] = "647f1b2b2772a876099da5b545b40246"
            param["language"] = "en-US"
            param["append_to_response"] = "videos,credits,recommendations,reviews"
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}


