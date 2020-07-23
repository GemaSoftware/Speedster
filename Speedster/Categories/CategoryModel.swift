//
//  CategoryModel.swift
//  Speedster
//
//  Created by Agron Gemajli on 7/9/20.
//  Copyright © 2020 Agron Gemajli. All rights reserved.
//

import Foundation
import SwiftUI

struct GameCategory: Decodable {
    var id: String
    var name: String
    var type: String
}

struct GameAPICategory: Decodable {
    var data: [GameCategory]
}

struct GameAPICategoryRecord: Decodable {
    var data: [GameCategoryRecordData]
}

struct GameCategoryRecordData: Decodable {
    var runs: [GameCategoryRecord]
}


struct GameCategoryRecord: Decodable, Identifiable {
    let id = UUID()
    var place: Int
    var run: GameCategoryRecordRun
}

struct GameCategoryRecordRun: Decodable {
    var times: GameCategoryRecordRunTimes
    var videos: GameCategoryRecordRunVideos
    
}

struct GameCategoryRecordRunTimes: Decodable {
    var ptime: Float?
    
    
    
    enum CodingKeys: String, CodingKey{
        case ptime = "primary_t"
    }
}
struct GameCategoryRecordRunVideos: Decodable {
    var links: [GameCategoryRecordRunVideosURI]

}

struct GameCategoryRecordRunVideosURI: Decodable {
    var uri: String
}

/*
 "runs": [
        {
          "place": 1,
          "run": {
            "id": "z053r18m",
            "weblink": "https://www.speedrun.com/bfbb/run/z053r18m",
            "game": "m1mxx362",
            "level": null,
            "category": "9kvxg32g",
            "videos": {
              "links": [
                {
                  "uri": "https://www.twitch.tv/videos/588032684"
                }
              ]
            },
            "comment": "real",
            "status": {
              "status": "verified",
              "examiner": "v8lgq0vj",
              "verify-date": "2020-04-10T09:32:13Z"
            },
            "players": [
              {
                "rel": "user",
                "id": "18vk6oej",
 
 */
