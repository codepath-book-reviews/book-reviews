//
//  BooksViewController.swift
//  book-review
//
//  Created by Danny Dong on 4/16/22.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var books = [BookModel]()

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=flowers+inauthor:keyes&key=AIzaSyDn5fVmCB5yXnu27xzMckoY_r05bCmGe88")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                if let bookList = self.parseJSON(data) {
                    self.books = bookList                }
              
                print(self.books)

                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as! BookCell
        
        let book = books[indexPath.row]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
