//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import UIKit

protocol ViewControllerType {
	associatedtype Myself: UIViewController = Self
	associatedtype ViewModel: ViewModelType
	
	var viewModel: ViewModel! { get set }
}

protocol ViewModelType {
	init()
}
