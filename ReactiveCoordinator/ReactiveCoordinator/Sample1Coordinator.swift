//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import Foundation
import UIKit
import ReactiveCocoa
import enum Result.NoError
import Rex

final class Sample1Coordinator: BaseCoordinator<Sample1ViewController> {
	weak var window: UIWindow?
	lazy var sample2Coordinator: Sample2Coordinator = Sample2Coordinator(parent: self)
	
	init(window: UIWindow){
		self.window = window
		
		super.init(identifier: "Sample1")
		
		isActive.observeNext{ [weak self] _ in
			self?.window?.rootViewController = self?.viewController
			self?.window?.makeKeyAndVisible()
			
			let present: Action<UIButton, (), NoError> = Action{ _ in
				self?.sample2Coordinator.active = true
				return .empty
			}
			self?.viewController.button.rex_pressed.value = present.unsafeCocoaAction
		}
	}
}