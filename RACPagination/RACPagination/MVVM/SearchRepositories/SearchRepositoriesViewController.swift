//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import UIKit
import ReactiveCocoa

class SearchRepositoriesViewController: UITableViewController {
	
	let viewModel = SearchRepositoriesViewModel()
	@IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

		viewModel.loading.signal.observeNext{ [weak self] isLoading in
			switch isLoading {
			case true:
				self?.indicator.startAnimating()
			case false:
				self?.indicator.stopAnimating()
			}
		}
		
		viewModel.elements.signal.observeNext{ [weak self] _ in
			self?.tableView.reloadData()
		}
		
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		viewModel.refreshTrigger.sendNext()
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1;
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return viewModel.elements.value.count
			
		default:
			return 0
		}
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCellWithIdentifier("Cell") else {
			fatalError()
		}
		
		let repository = viewModel.elements.value[indexPath.item] as Repository
		cell.textLabel?.text = repository.fullName
		cell.detailTextLabel?.text = "🌟\(repository.stargazersCount)"
		
		return cell
	}
    
	// MARK: - UIScrollViewDelegate
	
	override func scrollViewDidScroll(scrollView: UIScrollView) {
		let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
		let y = scrollView.contentOffset.y + scrollView.contentInset.top
		let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
		
		if y > threshold {
			viewModel.loadNextPageTrigger.sendNext()
		}
	}
}
