//
//  BookList.swift
//  book-review
//
//  Created by Danny Dong on 4/16/22.
//

import Foundation

struct BookList: Codable {
    let items: [BookModel]
}

struct BookModel: Codable {
    let id: String
    let volumeInfo: BookDetail
}

struct BookDetail: Codable {
    let title: String
    let authors: [String]
    let averageRating: Double?
    let ratingCount: Int?
    let description: String?
}

