//
//  BooksViewController.swift
//  book-review
//
//  Created by Danny Dong on 4/16/22.
//

import UIKit


class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var books = Books.books
    var searchTerm = "Harry+Potter"
    @IBOutlet weak var tableView: UITableView!
    
//    let searchController = UISearchController(searchResultsController: ResultsTableViewController())
    
    @IBOutlet weak var userSearchInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        userSearchInput.delegate = self
        searchForBooks(searchTerm)
        
        
//        navigationItem.searchController = searchController
//        searchController.obscuresBackgroundDuringPresentation = true
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.placeholder = "Find a book"
//        searchController.searchBar.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = userSearchInput.text {
            print(text)
            searchForBooks(cleanString(text))
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("hi hi hi")
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

        cell.titleLabel.text = title
        cell.authorLabel.text = author

        return cell
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
        if searchTerm.count == 0 {
            return
        }
        
        if let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(searchTerm)&key=AIzaSyDn5fVmCB5yXnu27xzMckoY_r05bCmGe88") {
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: url) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    if let bookList = self.parseJSON(data) {
                        self.books.bookList = bookList                }
                  
                    // print(self.books.bookList)

                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
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
