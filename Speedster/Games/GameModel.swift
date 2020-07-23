//
//  GameModel.swift
//  Speedster
//
//  Created by Agron Gemajli on 7/8/20.
//  Copyright © 2020 Agron Gemajli. All rights reserved.
//

import Foundation

struct Game: Decodable, Identifiable {
    var id: String
    var names: GameNames
    var platforms: [String]?
    var weblink: String
    var releaseDate: String
    var assets: GameAssets
//    var publishers: [String]
//    var links: [GameLink]
    
    enum CodingKeys: String, CodingKey {
        case id
        case names
        case platforms
        case weblink
        case releaseDate = "release-date"
        case assets
//        case names, platforms, weblink
//        case releaseDate = "release-date"
//        case assets, publishers, links
    }
}

struct GameAPIResponse: Decodable {
    var data: [Game]
}


struct GameNames: Decodable {
    var international: String?
    var japanese: String?
    var twitch: String?
}

struct GameAssets: Decodable{
    
    var logo: GameAssetDetail?
    var coverTiny: GameAssetDetail?
    var coverSmall: GameAssetDetail?
    var coverMedium: GameAssetDetail?
    var coverLarge: GameAssetDetail?
    var icon: GameAssetDetail?
    var trophyFirst: GameAssetDetail?
    var trophySecond: GameAssetDetail?
    var trophyThird: GameAssetDetail?
    var trophyFourth: GameAssetDetail?
    var background: GameAssetDetail?
    var foreground: GameAssetDetail?
    
    enum CodingKeys: String, CodingKey {
        case logo
        case coverTiny = "cover-tiny"
        case coverSmall = "cover-small"
        case coverMedium = "cover-medium"
        case coverLarge = "cover-large"
        case icon
        case trophyFirst = "trophy-1st"
        case trophySecond = "trophy-2nd"
        case trophyThird = "trophy-3rd"
        case trophyFourth = "trophy-4th"
        case background, foreground
    }
}

struct GameAssetDetail: Decodable {
    var uri: String
    var width: Int
    var height: Int
}

struct GameLink: Decodable {
    var rel: String
    var uri: String
}
