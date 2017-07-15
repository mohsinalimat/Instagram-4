//
//  Constants.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/11/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        static let toCreateUsername = "toCreateUsername"
    }
    struct FirDB {
        static let username = "username"
        static let users = "users"
        static let posts = "posts"
        static let postLikes = "postLikes"
        static let posterUID = "poster_uid"
        static let timeline = "timeline"
        static let followers = "followers"
        
    }
    struct FirPost {
        static let likeCount = "like_count"
        static let poster = "poster"
        static let uid = "uid"

    }
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let username = "username"
    }
}
