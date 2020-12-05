//
//  DataModel.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import Foundation

var k_URL = URL(string: "https://api.rawg.io/api/genres?key=61748154188e4ee2bfb4e7abe7d15abd")

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

struct AllData: Codable {
    var results = [Genre]()
}
