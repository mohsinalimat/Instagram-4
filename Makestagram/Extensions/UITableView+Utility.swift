//
//  UITableView+Utility.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/14/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//
import UIKit

protocol CellIdentifiable {
    static var cellIdentifier: String { get }
}

// 1
extension CellIdentifiable where Self: UITableViewCell {
    // 2
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

// 3
extension UITableViewCell: CellIdentifiable {

}

extension UITableView {
    // 1 We define a generic function that extensions UITableView. Notice that we can add constraints to our generic type. In our function declaration we specific that T must be of type UITableViewCell and conform to CellIdentifiable. This allows us to guarentee that we can access the cellIdentifier that we added with our CellIdentifiable protocol.
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: CellIdentifiable {
        // 2 We unwrap the custom UITableViewCell based on it's cellIdentifier and make sure the type conforms to T. In this line, we remove the need to type out the cell identifier as a String and force casting the type explicitly.
        guard let cell = dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T else {
            // 3 If the identifier or casting fails, we crash the app but print a nice error message so we'll know which cell caused the issue.
            fatalError("Error dequeuing cell for identifier \(T.cellIdentifier)")
        }
        
        return cell
    }
}
