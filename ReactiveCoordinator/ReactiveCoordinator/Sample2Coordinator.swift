//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import Foundation
import UIKit
import ReactiveCocoa
import enum Result.NoError
import Rex

final class Sample2Coordinator: Coordinator<Sample2ViewController> {
	var textBindingDisposable: Disposable?
	
	init<C: CoordinatorType where C.ViewController.ViewModel: TextReceivable>(parent: C){
		super.init(identifier: "Sample2")
		
		weak var p = parent
		
		isActive.observeNext{ [weak self] in
			switch $0 {
			case true:
				guard let
					viewController = self?.viewController,
					parentText = p?.viewModel.text else {
						return
				}
				
				let nav = UINavigationController(rootViewController: viewController)
				let parentViewController = p?.viewController as? UIViewController
				parentViewController?.presentViewController(nav, animated: true, completion: {
					
					let dismiss: Action<UIBarButtonItem, (), NoError> = Action{ _ in
						self?.viewController.textView.resignFirstResponder()
						self?.active = false
						
						return .empty
					}
					self?.viewController.doneButton.rex_action.value = dismiss.unsafeCocoaAction
					
					if self?.textBindingDisposable?.disposed == false {
						self?.textBindingDisposable?.dispose()
					}
					self?.textBindingDisposable = parentText <~ viewController.textView.rex_textSignal
				})
				
			case false:
				self?.textBindingDisposable?.dispose()
				
				guard let
					parentViewController = p?.viewController as? UIViewController else {
						return
				}
				parentViewController.dismissViewControllerAnimated(true, completion: nil)
			}
		}
	}
}