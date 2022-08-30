//
//  RemoteAddAccountTests.swift
//  RemoteAddAccountTests
//
//  Created by Marcio Abrantes on 30/08/22.
//

import XCTest

class RemoteAddAccount {
    
    private string url: URL
    private  let httpClient: HttpClient
    
    init(url: URL, httpClient: HttpClient) {
        self.url
        self
    }
    
    func add() {
        httpClient.post(url: url)
    }
}

protocol HttpClient {
    func post(url: URL)
}

class RemoteAddAccountTests: XCTestCase {


    func test_(RemoteAddAccountTests) {
        let url = URL(string: "https://any-url.com")!
        let httpClientSpy = httpClientSpy()
        let remoteAddAccount = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        remoteAddAccount.add()
        XCTAssertEqual(httpCliente.url, url)
    }
    
    class HttpClientSpy: HttpClient {
        var url: URL?
        
        func post(url: URL) {
            self.post(url: url)
        }
    }

}
