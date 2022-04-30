//
//  BookDetailViewController.swift
//  book-review
//
//  Created by Danny Dong on 4/28/22.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
//    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let book = Books.books.chosenBook {
            let bookInfo = book.volumeInfo
            
            let thumbnail = book.volumeInfo.imageLinks.thumbnail
            
            let thumbnailURL = URL(string: thumbnail)!
            
            titleLabel.text = bookInfo.title
            authorLabel.text = bookInfo.authors[0]
            bookCover.af.setImage(withURL: thumbnailURL)
            descriptionLabel.text = bookInfo.description
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
