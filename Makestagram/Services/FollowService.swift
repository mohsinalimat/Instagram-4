//
//  FollowService.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/14/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FollowService {
    
    private static func followUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        // 1 We create a dictionary to update multiple locations at the same time. We set the appropriate key-value for our followers and following.
        let currentUID = User.current.uid
        let followData = ["followers/\(user.uid)/\(currentUID)" : true,
                          "following/\(currentUID)/\(user.uid)" : true]
        
        // 2 We write our new relationship to Firebase.
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            // 3 We return whether the update was successful based on whether there was an error.
            success(error == nil)
        }
    }
    
    private static func unfollowUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let followData = ["followers/\(user.uid)/\(currentUID)" : false,
                          "following/\(currentUID)/\(user.uid)" : false]
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            // 3 We return whether the update was successful based on whether there was an error.
            success(error == nil)
        }

    }
    
    static func setIsFollowing(_ isFollowing: Bool, fromCurrentUserTo followee: User, success: @escaping (Bool) -> Void) {
        if isFollowing {
            followUser(followee, forCurrentUserWithSuccess: success)
        } else {
            unfollowUser(followee, forCurrentUserWithSuccess: success)
        }
    }
    
    static func isUserFollowed(_ user: User, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let ref = Database.database().reference().child("followers").child(user.uid)
        
        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
}
