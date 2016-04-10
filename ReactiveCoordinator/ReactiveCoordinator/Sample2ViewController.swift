//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import UIKit
import ReactiveCocoa

class Sample2ViewController: UIViewController, ViewControllerType {
	
	var viewModel: Sample2ViewModel!
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var doneButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = doneButton
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		textView.becomeFirstResponder()
	}
}
