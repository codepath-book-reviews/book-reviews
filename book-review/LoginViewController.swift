//
//  ViewController.swift
//  book-review
//
//  Created by Danny Dong on 4/15/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
	@IBOutlet weak var usernameLabel: UITextField!
	
	@IBOutlet weak var passwordLabel: UITextField!
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


	@IBAction func onSignIn(_ sender: Any) {
		let username = usernameLabel.text!
		let password = passwordLabel.text!
		PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
			if user != nil {
				self.performSegue(withIdentifier: "loginSegue", sender: nil)
			} else {
				print("Error: \(error!.localizedDescription)")
			}
		}
	}
	
	@IBAction func onSignUp(_ sender: Any) {
		let user = PFUser()
		user.username = usernameLabel.text
		user.password = passwordLabel.text

		user.signUpInBackground{ (success, error) in
			if success {
				self.performSegue(withIdentifier: "loginSegue", sender: nil)
			} else {
				print("Error signing up: \(String(describing: error?.localizedDescription))")
			}
		}
	}
}

