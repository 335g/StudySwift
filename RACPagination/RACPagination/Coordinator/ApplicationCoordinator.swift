//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import UIKit

class ApplicationCoordinator: Coordinator {
	
	let window: UIWindow
	let viewController: UINavigationController = UIStoryboard(name: "SearchRepositories", bundle: nil).instantiateInitialViewController() as! UINavigationController
	
	init(window: UIWindow){
		self.window = window
	}
	
	func start() {
		window.rootViewController = viewController
		window.makeKeyAndVisible()
	}
}