//
//  User.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/11/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot // imports for snapshots of our data

// class for users
class User {
    // MARK: -Properties
    
    let uid: String
    let username: String
    
    // MARK: -Init
    
    init(uid:String, username: String) {
        self.uid = uid
        self.username = username
    }
    init?(snapshot: DataSnapshot){
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
    }
    
}
