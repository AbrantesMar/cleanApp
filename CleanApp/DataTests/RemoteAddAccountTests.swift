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
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data)
    }
}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

protocol HttpGetClient {
    func get(url: URL)
}

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "https://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let remoteAddAccount = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        remoteAddAccount.add(addAccountModel: makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let url = URL(string: "https://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let remoteAddAccount = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let accountModel = makeAddAccountModel()
        remoteAddAccount.add(addAccountModel: accountModel)
        let data = try? JSONEncoder().encode(accountModel)
        XCTAssertEqual(httpClientSpy.data, data)
    }

}

extension RemoteAddAccountTests {
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any_name", email: "any_email@email.com", password: "äny_password", passwordConfirmation: "äny_password")
    }
    
    class HttpClientSpy: HttpPostClient, HttpGetClient {
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
        
        func get(url: URL) {
            return
        }
    }
}
