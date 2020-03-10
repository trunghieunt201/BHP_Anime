//
//  DetailItems.swift
//
//  Created by Nguyen Trung Hieu on 3/7/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DetailItems: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let posterPath = "poster_path"
    static let overview = "overview"
    static let status = "status"
    static let runtime = "runtime"
    static let releaseDate = "release_date"
    static let id = "id"
    static let revenue = "revenue"
    static let video = "video"
    static let genres = "genres"
    static let videos = "videos"
    static let voteAverage = "vote_average"
    static let title = "title"
    static let voteCount = "vote_count"
  }

  // MARK: Properties
  public var posterPath: String?
  public var overview: String?
  public var status: String?
  public var runtime: Int?
  public var releaseDate: String?
  public var id: Int?
  public var revenue: Int?
  public var video: Bool? = false
  public var genres: [Genres]?
  public var videos: Videos?
  public var voteAverage: Double?
  public var title: String?
  public var voteCount: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    posterPath = json[SerializationKeys.posterPath].string
    overview = json[SerializationKeys.overview].string
    status = json[SerializationKeys.status].string
    runtime = json[SerializationKeys.runtime].int
    releaseDate = json[SerializationKeys.releaseDate].string
    id = json[SerializationKeys.id].int
    revenue = json[SerializationKeys.revenue].int
    video = json[SerializationKeys.video].boolValue
    if let items = json[SerializationKeys.genres].array { genres = items.map { Genres(json: $0) } }
    videos = Videos(json: json[SerializationKeys.videos])
    voteAverage = json[SerializationKeys.voteAverage].double
    title = json[SerializationKeys.title].string
    voteCount = json[SerializationKeys.voteCount].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = posterPath { dictionary[SerializationKeys.posterPath] = value }
    if let value = overview { dictionary[SerializationKeys.overview] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = runtime { dictionary[SerializationKeys.runtime] = value }
    if let value = releaseDate { dictionary[SerializationKeys.releaseDate] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = revenue { dictionary[SerializationKeys.revenue] = value }
    dictionary[SerializationKeys.video] = video
    if let value = genres { dictionary[SerializationKeys.genres] = value.map { $0.dictionaryRepresentation() } }
    if let value = videos { dictionary[SerializationKeys.videos] = value.dictionaryRepresentation() }
    if let value = voteAverage { dictionary[SerializationKeys.voteAverage] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.overview = aDecoder.decodeObject(forKey: SerializationKeys.overview) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.runtime = aDecoder.decodeObject(forKey: SerializationKeys.runtime) as? Int
    self.releaseDate = aDecoder.decodeObject(forKey: SerializationKeys.releaseDate) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.revenue = aDecoder.decodeObject(forKey: SerializationKeys.revenue) as? Int
    self.video = aDecoder.decodeBool(forKey: SerializationKeys.video)
    self.genres = aDecoder.decodeObject(forKey: SerializationKeys.genres) as? [Genres]
    self.videos = aDecoder.decodeObject(forKey: SerializationKeys.videos) as? Videos
    self.voteAverage = aDecoder.decodeObject(forKey: SerializationKeys.voteAverage) as? Double
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.voteCount = aDecoder.decodeObject(forKey: SerializationKeys.voteCount) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(posterPath, forKey: SerializationKeys.posterPath)
    aCoder.encode(overview, forKey: SerializationKeys.overview)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(runtime, forKey: SerializationKeys.runtime)
    aCoder.encode(releaseDate, forKey: SerializationKeys.releaseDate)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(revenue, forKey: SerializationKeys.revenue)
    aCoder.encode(video, forKey: SerializationKeys.video)
    aCoder.encode(genres, forKey: SerializationKeys.genres)
    aCoder.encode(videos, forKey: SerializationKeys.videos)
    aCoder.encode(voteAverage, forKey: SerializationKeys.voteAverage)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(voteCount, forKey: SerializationKeys.voteCount)
  }

}
