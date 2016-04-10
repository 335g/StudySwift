//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import UIKit
import ReactiveCocoa

class Sample1ViewController: UIViewController, ViewControllerType {
	
	var viewModel: Sample1ViewModel!
	
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

		label.rex_text <~ viewModel.text.producer.map{ "\"" + $0 + "\"" }
		
		viewModel.text.signal.observeNext{ print($0) }
    }
}
