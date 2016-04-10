//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import Foundation
import ReactiveCocoa

protocol TextReceivable {
	var text: MutableProperty<String> { get }
}

struct Sample1ViewModel: ViewModelType, TextReceivable {
	let text: MutableProperty<String> = MutableProperty("")
}