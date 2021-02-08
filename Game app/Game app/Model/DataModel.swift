//
//  DataModel.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import Foundation

var k_URL = "https://api.rawg.io/api/genres?key="
var k_token = "61748154188e4ee2bfb4e7abe7d15abd"

struct Genre: Codable {
    var id: Int
    var name: String
    var slug: String
    var games_count: Int
    var image_background: String
    var games = [Game]()
}

struct Game: Codable {
    var id: Int
    var slug: String
    var name: String
    var added: Int
}

struct JSONdata: Codable {
    var results = [Genre]()
}

struct GameData: Codable {
    var name: String
    var description: String
    var released: String
    var background_image: String
}
