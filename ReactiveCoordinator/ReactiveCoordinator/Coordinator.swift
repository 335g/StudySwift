//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import Foundation
import UIKit
import ReactiveCocoa
import enum Result.NoError

protocol CoordinatorType: class {
	associatedtype ViewController: ViewControllerType
	
	var viewController: ViewController { get }
	var viewModel: ViewController.ViewModel { get }
	
	var active: Bool { get set }
	var isActive: Signal<Bool, NoError> { get }
}

class Coordinator<VC: ViewControllerType>: CoordinatorType {
	let viewModel: VC.ViewModel
	let viewController: VC
	
	let _active: MutableProperty<Bool> = MutableProperty(false)
	var active: Bool {
		get{ return _active.value }
		set(x){
			if x != _active.value {
				_active.value = x
			}
		}
	}
	
	let willDeallocSignal: Signal<(), NoError>
	private let willDeallocObserver: Observer<(), NoError>
	
	var isActive: Signal<Bool, NoError> {
		return _active.signal
			.takeUntil(willDeallocSignal)
			.observeOn(UIScheduler())
	}
	
	init(identifier: String){
		var vc = UIStoryboard(name: identifier, bundle: nil).instantiateInitialViewController() as! VC
		let vm = VC.ViewModel()
		vc.viewModel = vm
		
		viewController = vc
		viewModel = vm
		
		(willDeallocSignal, willDeallocObserver) = Signal.pipe()
	}
	
	deinit {
		willDeallocObserver.sendNext()
	}
}

class BaseCoordinator<VC: ViewControllerType>: Coordinator<VC> {
	override var isActive: Signal<Bool, NoError> {
		return super.isActive
			.filter{ $0 }
			.take(1)
	}
	
	override init(identifier: String) {
		super.init(identifier: identifier)
	}
}
