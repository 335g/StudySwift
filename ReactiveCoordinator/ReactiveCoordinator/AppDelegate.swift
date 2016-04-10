//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	private var coordinator: Sample1Coordinator?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		let w = UIWindow(frame: UIScreen.mainScreen().bounds)
		window = w
		coordinator = Sample1Coordinator(window: w)
		coordinator?.active = true
		
		return true
	}
}

