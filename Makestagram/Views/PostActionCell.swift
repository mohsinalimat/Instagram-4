//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/13/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class PostActionCell: UITableViewCell {

    static let height: CGFloat = 46
    
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        
    }
    
}
