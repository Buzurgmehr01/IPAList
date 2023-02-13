//
//  SearchResponse.swift
//  IPAList
//
//  Created by Temp on 06/02/23.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable  {
    var artistName: String
    var trackName: String
    var collectionCensoredName: String
    var artworkUrl60: String?
}
