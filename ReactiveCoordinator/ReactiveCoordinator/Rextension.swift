//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import Foundation
import UIKit
import Rex
import ReactiveCocoa
import enum Result.NoError

extension UITextView {
	var rex_textSignal: SignalProducer<String, NoError> {
		return NSNotificationCenter.defaultCenter()
			.rac_notifications(UITextViewTextDidChangeNotification, object: self)
			.filterMap{ ($0.object as? UITextView)?.text }
	}
}
