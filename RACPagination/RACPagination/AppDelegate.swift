//
//  AppDelegate.swift
//  RACPagination
//
//  Created by Yoshiki Kudo on 2016/03/05.
//  Copyright © 2016 Yoshiki Kudo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		ApplicationCoordinator(window: window!).start()
		
		return true
	}
}

