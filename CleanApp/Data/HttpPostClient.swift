//
//  HttpPostClient.swift
//  Data
//
//  Created by Marcio Abrantes on 31/08/22.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

protocol HttpGetClient {
    func get(url: URL)
}
