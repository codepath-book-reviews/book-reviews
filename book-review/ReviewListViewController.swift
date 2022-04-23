//
//  ReviewListViewController.swift
//  book-review
//
//  Created by Sabrina Chen on 4/16/22.
//

import UIKit
import Parse

class ReviewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
//    var bookID: [String:Any]!
    var bookID = "ddkahfk"
        var reviews = [PFObject]()
        let reviewAmount = 20
        
        let myRefreshControl = UIRefreshControl()
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            let username = "test"
            let password = "Pass"
            PFUser.logInWithUsername(inBackground: username, password: password){(user, error) in
                if user != nil{
                    print("Logged in")
                }
            }
            tableView.delegate = self
            tableView.dataSource = self
            
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
