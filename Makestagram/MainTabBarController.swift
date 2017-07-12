//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/12/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Properties
    
    let photoHelper = MGPhotoHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHelper.completionHandler = { image in // closure
            print("handle image")
        }
        // 1 First we set the MainTabBarController as the delegate of its tab bar
        delegate = self
        // 2 We set the tab bar's unselectedItemTintColor from the default of gray to black
        tabBar.unselectedItemTintColor = .black
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            photoHelper.presentActionSheet(from: self)
            return false
        }
        return true
    }
}
