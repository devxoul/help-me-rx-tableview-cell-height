//
//  AppDelegate.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/24/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import ManualLayout
import SnapKit
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds).then {
            $0.backgroundColor = .whiteColor()
            $0.makeKeyAndVisible()
            $0.rootViewController = UINavigationController(rootViewController: SimpleTableViewController(viewModel: SimpleTableViewModel()))
        }
        return true
    }

}
