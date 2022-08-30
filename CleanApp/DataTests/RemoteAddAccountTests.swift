//
//  RemoteAddAccountTests.swift
//  RemoteAddAccountTests
//
//  Created by Marcio Abrantes on 30/08/22.
//

import XCTest
import Domain

class RemoteAddAccount {
    
    private let url: URL
    private let httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        httpClient.post(url: url)
    }
}

protocol HttpPostClient {
    func post(url: URL)
}

protocol HttpGetClient {
    func get(url: URL)
}

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "https://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let remoteAddAccount = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        remoteAddAccount.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "https://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let remoteAddAccount = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        remoteAddAccount.add()
        XCTAssertEqual(httpClientSpy.data, data)
    }

}

extension RemoteAddAccountTests {
    class HttpClientSpy: HttpPostClient, HttpGetClient {
        var url: URL?
        
        func post(url: URL) {
            self.post(url: url)
        }
        
        func get(url: URL) {
            <#code#>
        }
    }
}
