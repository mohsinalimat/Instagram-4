//
//   DatabaseReference+Location.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/14/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

// Router Folder

import Foundation
import FirebaseDatabase

extension DatabaseReference {
    enum MGLocation {
        // insert cases to read/write to locations in Firebase
        case root
        case posts(uid: String)
        func asDatabaseReference() -> DatabaseReference {
            let root = Database.database().reference()
            
            switch self {
            case .root:
                return root
            case .posts(let uid):
                return root.child("posts").child(uid)
        }
        }
        static func toLocation(_ location: MGLocation) -> DatabaseReference {
            return location.asDatabaseReference()
        }

    }
}
