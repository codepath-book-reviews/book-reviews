//
//  AddReviewViewController.swift
//  book-review
//
//  Created by Sabrina Chen on 4/16/22.
//

import UIKit
import Parse

class AddReviewViewController: UIViewController {


    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var reviewField: UITextView!
    let book = Books.books.chosenBook
    var bookID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.placeholder = "Title"
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func addReview(_ sender: Any) {
        if let book = Books.books.chosenBook {
            bookID = book.id
            print(bookID as Any)
            let review = PFObject(className: "Reviews")
            review["BookID"] = bookID
            review["Title"] = titleField.text!
            review["Review"] = reviewField.text!
            review["Author"] = PFUser.current()!
            
            review.saveInBackground { (success, error) in
                if success{
                    self.navigationController?.popViewController(animated: true)
                    print("saved!")
                }
                else{
                    print("error!")
                }
            }
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
