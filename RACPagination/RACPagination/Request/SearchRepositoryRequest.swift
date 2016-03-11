//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import APIKit

struct SearchRepositoriesRequest: GithubRequestType {
	typealias Response = PaginationElementsResponse<Repository>
	
	let query: String
	let page: Int
	
	init(query: String, page: Int = 1){
		self.query = query
		self.page = page
	}
	
	var method: HTTPMethod {
		return .GET
	}
	
	var path: String {
		return "/search/repositories"
	}
	
	var parameters: [String: AnyObject] {
		return ["q": query, "page": page]
	}
}