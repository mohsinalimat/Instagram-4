//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/7/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class CreateUsernameViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 6
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }




}
    
