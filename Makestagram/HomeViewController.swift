//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/12/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Kingfisher // url to picture ez

class HomeViewController: UIViewController {
 
    
    // MARK: - Properties
    
    var posts = [Post]()
    
    let timestampFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    }()
    //MARK: - Subviews
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func configureTableView() {
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        // remove separators from cells
        tableView.separatorStyle = .none
    }

    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // username, image, likes layer
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostHeaderCell") as! PostHeaderCell
            cell.usernameLabel.text = User.current.username
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell") as! PostImageCell
            let imageURL = URL(string: post.imageURL)
            cell.postImageView.kf.setImage(with: imageURL)
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostActionCell") as! PostActionCell
            cell.delegate = self
            configureCell(cell, with: post)
            return cell
            
        default:
            fatalError("Error: unexpected indexPath.")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count // number of pictures
    }
    func configureCell(_ cell: PostActionCell, with post: Post) {
        cell.timeStamp.text = timestampFormatter.string(from: post.creationDate)
        cell.likeButton.isSelected = post.isLiked
        cell.likesCount.text = "\(post.likeCount) likes"
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return PostHeaderCell.height
            
        case 1:
            let post = posts[indexPath.section]
            return post.imageHeight
            
        case 2:
            return PostActionCell.height
            
        default:
            fatalError()
        }
    }
}
extension HomeViewController: PostActionCellDelegate {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell) {
        // 1 First we make sure that an index path exists for the the given cell. We'll need the index path of the cell later on to reference the correct post.
        guard let indexPath = tableView.indexPath(for: cell)
            else { return }
        
        // 2 Set the isUserInteractionEnabled property of the UIButton to false so the user doesn't accidentally send multiple requests by tapping too quickly.
        likeButton.isUserInteractionEnabled = false
        // 3 Reference the correct post corresponding with the PostActionCell that the user tapped.
        let post = posts[indexPath.section]
        
        // 4 Use our LikeService to like or unlike the post based on the isLiked property.
        LikeService.setIsLiked(!post.isLiked, for: post) { (success) in
            // 5 Use defer to set isUserInteractionEnabled to true whenever the closure returns.
            defer {
                likeButton.isUserInteractionEnabled = true
            }
            
            // 6 Basic error handling if something goes wrong with our network request.
            guard success else { return }
            
            // 7 Change the likeCount and isLiked properties of our post if our network request was successful.
            post.likeCount += !post.isLiked ? 1 : -1
            post.isLiked = !post.isLiked
            
            // 8 Get a reference to the current cell.
            guard let cell = self.tableView.cellForRow(at: indexPath) as? PostActionCell
                else { return }
            
            // 9 Update the UI of the cell on the main thread. Remember that all UI updates must happen on the main thread.
            DispatchQueue.main.async {
                self.configureCell(cell, with: post)
            }
        }
    }
}
