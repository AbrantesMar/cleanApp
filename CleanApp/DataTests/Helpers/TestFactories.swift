//
//  TextFactories.swift
//  DataTests
//
//  Created by Marcio Abrantes on 02/09/22.
//

import Foundation

func makeUrl() -> URL {
    return URL(string: "https://any-url.com")!
}

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\": \"Marcio Abrantes\"}".utf8)
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
