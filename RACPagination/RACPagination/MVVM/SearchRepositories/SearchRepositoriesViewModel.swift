//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import ReactiveCocoa
import APIKit
import enum Result.NoError
import Himotoki

final class SearchRepositoriesViewModel {
	
	typealias Request = SearchRepositoriesRequest
	typealias Elements = [Request.Response.Element]
	
	private let _hasNextPage: MutableProperty<Bool> = MutableProperty(true)
	private let _loading: MutableProperty<Bool> = MutableProperty(false)
	private let _elements: MutableProperty<Elements> = MutableProperty([])
	private var _loadNextPage: SignalProducer<Elements, NoError>!
	private var request: SearchRepositoriesRequest = SearchRepositoriesRequest(query: "Swift")
	private let _refreshTriggerSignal: Signal<Void, NoError>
	private let _loadNextPageTriggerSignal: Signal<Void, NoError>
	
	let hasNextPage: AnyProperty<Bool>
	let loading: AnyProperty<Bool>
	let elements: AnyProperty<Elements>
	let refreshTrigger: Observer<Void, NoError>
	let loadNextPageTrigger: Observer<Void, NoError>
	
	init(){
		hasNextPage = AnyProperty(_hasNextPage)
		loading = AnyProperty(_loading)
		elements = AnyProperty(_elements)
		
		let (refreshTriggerSignal, observer1) = Signal<Void, NoError>.pipe()
		let (loadNextPageTriggerSignal, observer2) = Signal<Void, NoError>.pipe()
		
		refreshTrigger = observer1
		loadNextPageTrigger = observer2
		_refreshTriggerSignal = refreshTriggerSignal
		_loadNextPageTriggerSignal = loadNextPageTriggerSignal
		
		_loadNextPage = SignalProducer<Elements, NoError>{ [weak self] observer, disposable in
			guard let request = self?.request else {
				fatalError()
			}
			
			/// Start
			self?._loading.value = true
			
			Session.sendRequest(request){ result in
				if case let .Success(response) = result {
					self?._hasNextPage.value = response.hasNextPage
					
					let query = request.query
					let page = request.page
					self?.request = SearchRepositoriesRequest(query: query, page: page + 1)
					
					observer.sendNext(response.elements)
				}
				
				/// Stop
				self?._loading.value = false
				observer.sendCompleted()
			}
		}
		
		_refreshTriggerSignal.observeNext{ [weak self] _ in
			guard let request = self?.request else {
				fatalError()
			}
			
			self?._elements.value = []
			
			Session.cancelRequest(request.dynamicType)
			self?._loading.value = false
			
			self?.loadNextPageTrigger.sendNext()
		}
		
		_loadNextPageTriggerSignal
			.filter{ [weak self ] _ in (self?.hasNextPage.value)! }
			.filter{ [weak self] _ in !((self?.loading.value)!) }
			.observeNext{ [weak self] _ in
				self?._loadNextPage.startWithNext{ repositories in
					guard let currentRepositories = self?.elements.value else {
						fatalError()
					}
					
					self?._elements.value = currentRepositories + repositories
				}
			}
	}
}
