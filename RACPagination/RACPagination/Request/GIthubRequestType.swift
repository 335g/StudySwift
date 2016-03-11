//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import Foundation
import APIKit
import Himotoki
import WebLinking

// MARK: - GithubRequestType

protocol GithubRequestType: RequestType {}

extension GithubRequestType {
	var baseURL: NSURL {
		return NSURL(string: "https://api.github.com")!
	}
}

extension GithubRequestType where Response: Decodable, Response.DecodedType == Response {
	func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
		return try? decodeValue(object)
	}
}

extension GithubRequestType where Response: PaginationElementsResponseType, Response.Element.DecodedType == Response.Element {
	func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
		return (try? decodeArray(object, rootKeyPath: "items") as [Response.Element])
			.map{ ($0, URLResponse.findLink(relation: "next") != nil) }
			.map(Response.init)
	}
}