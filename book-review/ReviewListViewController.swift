//
//  ReviewListViewController.swift
//  book-review
//
//  Created by Sabrina Chen on 4/16/22.
//

import UIKit
import Parse

class ReviewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var bookID = ""
        var reviews = [PFObject]()
        let reviewAmount = 20
        
        let myRefreshControl = UIRefreshControl()
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            
            if let book = Books.books.chosenBook {
                bookID = book.id
                let bookInfo = NSMutableAttributedString(string: book.volumeInfo.title,
                                                           attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                                                        NSAttributedString.Key.foregroundColor: UIColor.black]);

                bookInfo.append(NSMutableAttributedString(string: "\n" + book.volumeInfo.authors[0],
                                                            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                                                         NSAttributedString.Key.foregroundColor: UIColor.gray]));
                bookLabel.attributedText = bookInfo
                bookLabel.layer.addWaghaBorder(edge: .bottom, color: UIColor.lightGray, thickness: 1)
            }
            myRefreshControl.addTarget(self, action: #selector(loadReviews), for: .valueChanged)
            tableView.refreshControl = myRefreshControl
            tableView.keyboardDismissMode = .interactive

            // Do any additional setup after loading the view.
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            loadReviews()
        }
        @objc func loadReviews(){
            print("ID: ", bookID)
            let query = PFQuery(className: "Reviews")
            query.whereKey("BookID", equalTo:bookID as Any)
            query.includeKey("Author")
            query.limit = 20
            query.order(byDescending: "createdAt")
            query.findObjectsInBackground{(reviews, error) in
                if reviews != nil {
                    self.reviews = reviews!
                    self.tableView.reloadData()
                    self.myRefreshControl.endRefreshing()
                }
            }
        }
        func loadMoreReviews(){
            let query = PFQuery(className: "Reviews")
            query.whereKey("BookID", equalTo:bookID as Any)
            query.includeKey("Author")
            query.limit = reviewAmount + 20
            query.order(byDescending: "createdAt")
            query.findObjectsInBackground{(reviews, error) in
                if reviews != nil {
                    self.reviews = reviews!
                    self.tableView.reloadData()
                    self.myRefreshControl.endRefreshing()
                }
            }
        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row + 1 == reviews.count{
                loadMoreReviews()
            }
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return reviews.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
            let review = reviews[indexPath.row]
            let title = review["Title"] as! String
            let author = review["Author"] as! PFUser
            let Review = review["Review"] as! String
            
            
            cell.titleLabel.text = title
            cell.authorLabel.text = "-" + author.username!
            cell.reviewLabel.text = Review
            
            return cell
        }
    

    @IBAction func toAll(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toAdd") {
            print ("toAdd")
            let addReview = segue.destination as! AddReviewViewController
            addReview.bookID = bookID
        }
        else {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let review = reviews[indexPath.row]
            
            let showDetailsViewController = segue.destination as! DetailsReviewViewController
            showDetailsViewController.review = review["Review"] as! String
            showDetailsViewController.Title = review["Title"] as! String
            let author = review["Author"] as! PFUser
            showDetailsViewController.author = author.username!

            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

extension CALayer {
    func addWaghaBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        switch edge {
            case UIRectEdge.top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
                break
            case UIRectEdge.left:
                border.frame = CGRect(x: 0, y: 0, width: 1, height: self.frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect(x: self.frame.width - 1, y: 0, width: 1, height: self.frame.height)
                break
            default:
                break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
