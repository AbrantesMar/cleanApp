//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Marcio Abrantes on 31/08/22.
//

import Foundation

public final class RemoteAddAccount {
    
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel) {
        httpClient.post(to: url, with: addAccountModel.toData())
    }
}
