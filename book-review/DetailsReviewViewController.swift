//
//  DetailsReviewViewController.swift
//  book-review
//
//  Created by Juan Martinez on 4/22/22.
//

import UIKit

class DetailsReviewViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    var review = "" //: [String:Any]!
    var Title = "" //: [String:Any]!
    var author = "" //: [String:Any]!

    //var title = "" //[String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = title //review["Title"] as? String
        reviewLabel.text = review //review["Review"] as? String
        //let author = review["Author"] as! PFUser
        authorLabel.text = author
        //authorLabel.text = review["Author"] as? String
        

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
