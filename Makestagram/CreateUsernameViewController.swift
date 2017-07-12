//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/11/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class CreateUsernameViewController: UIViewController {
   

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        // create user account here
        // 1 First we guard to check that a FIRUser is logged in
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
                
                // handle newly created user here
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {
                // handle error
                return
            }
            
            User.setCurrent(user, writeToUserDefaults: true)// sets it true for instant login/ store in UserDefaults
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
 
