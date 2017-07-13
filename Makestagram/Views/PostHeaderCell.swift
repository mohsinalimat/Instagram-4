//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/13/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//


import UIKit

class PostHeaderCell: UITableViewCell {

    static let height: CGFloat = 54
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("options button tapped")
    }
    
    
}
