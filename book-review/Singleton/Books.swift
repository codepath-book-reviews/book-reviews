//
//  Books.swift
//  book-review
//
//  Created by Danny Dong on 4/20/22.
//

import Foundation

// Singleton class
// All data for books in this app will be stored here for easy access
class Books {
    static let books = Books()
    var chosenBook: BookModel?
    var bookList = [BookModel]()
    // This prevents others from using the default '()' initializer for this class.
    private init() {}
}
