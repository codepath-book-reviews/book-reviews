//
//  BooksViewController.swift
//  book-review
//
//  Created by Danny Dong on 4/16/22.
//

import UIKit
import AlamofireImage
import Parse

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var books = Books.books
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchForBooks("Harry+Potter")
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let input = searchBar.text {
  
            searchForBooks(cleanString(input))
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as! BookCell
        
        let book = books.bookList[indexPath.row]
        let bookDetails = book.volumeInfo

        let title = bookDetails.title
        let author = bookDetails.authors[0]
        let thumbnail = bookDetails.imageLinks.thumbnail
        
        let thumbnailURL = URL(string: thumbnail)!
        
        cell.titleLabel.text = title
        cell.authorLabel.text = author
        cell.coverImage.af.setImage(withURL: thumbnailURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        books.chosenBook = books.bookList[indexPath.row]
    }
    
    func parseJSON(_ bookList: Data) -> [BookModel]? {
        let decoder = JSONDecoder()

        do {

            let decodedBookList = try decoder.decode(BookList.self, from: bookList)
 
            return decodedBookList.items
        } catch {
            return nil
        }
    }

    func searchForBooks(_ searchTerm: String) {
        print(searchTerm)
        if searchTerm.count == 0 {
            return
        }
        
        if let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(searchTerm)&key=AIzaSyDn5fVmCB5yXnu27xzMckoY_r05bCmGe88&maxResults=15") {
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: url) { (data, response, error) in

                let dataString = String(data: data!, encoding: String.Encoding.utf8)! as String
                print(dataString)
//                 This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    if let bookList = self.parseJSON(data) {
    
                        self.books.bookList = bookList                }

                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
    }
    
    @IBAction func onLogOutPress(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
    }
        // trims the input string and returns it with all spaces (" ") replace by "+"
    func cleanString(_ str: String) -> String {
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString.split(separator: " ").joined(separator: "+")
        
    }

}

//MARK: - Updating search result
//extension BooksViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//
//        searchForBooks(text)
//    }
//}
