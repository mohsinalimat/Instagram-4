//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/10/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

// seperates user from Firebase's user
typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
            // 1
            guard let authUI = FUIAuth.defaultAuthUI()
                else { return }

            // 2
            authUI.delegate = self
            
            // 3
            let authViewController = authUI.authViewController()
            present(authViewController, animated: true)
    }
}
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
        }
        
        // 1 First we check that the FIRUser returned from authentication is not nil by unwrapping it. 
        guard let user = user
            else { return }
        
        // 2 We construct a relative path to the reference of the user's information in our database.
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        // 3 We read from the path we created and pass an event closure to handle the data (snapshot) that is passed back from the database.
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            //1 
            if let user = User(snapshot: snapshot) {
                print("Welcome back, \(user.username).")
            } else {
                print("New user!")
            }
            // 4 retrieve user data from snapshot
        })
    }
}
