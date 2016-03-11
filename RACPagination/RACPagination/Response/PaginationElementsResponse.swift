//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import Himotoki

// MARK: - PaginationResponseType

protocol PaginationElementsResponseType {
	typealias Element: Decodable
	
	var elements: [Element] { get }
	var hasNextPage: Bool { get }
	
	init(elements: [Element], hasNextPage: Bool)
}

// MARK: - PaginationResponse

struct PaginationElementsResponse<E: Decodable where E.DecodedType == E>: PaginationElementsResponseType {
	typealias Element = E
	
	let elements: [Element]
	let hasNextPage: Bool
	
}