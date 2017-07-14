//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/13/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

protocol PostActionCellDelegate: class {
    
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell: UITableViewCell {

    // MARK: - Properties
    weak var delegate: PostActionCellDelegate?
    
    static let height: CGFloat = 46
    

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - IBActions
    
    @IBAction func likeClicked(_ sender: UIButton) {
        delegate?.didTapLikeButton(sender, on: self)
    }
}
