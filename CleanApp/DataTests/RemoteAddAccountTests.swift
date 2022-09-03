//
//  RemoteAddAccountTests.swift
//  RemoteAddAccountTests
//
//  Created by Marcio Abrantes on 30/08/22.
//

import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut()
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let accountModel = makeAddAccountModel()
        sut.add(addAccountModel: accountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, accountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completionWithError(.noConnectivity)
        })
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completeWith: .success(account), when: {
            httpClientSpy.completionWithData(account.toData()!)
        })
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalide_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completionWithData(Data("invalide_data".utf8))
        })
    }

}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "https://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let url = makeUrl()
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
    
    func makeUrl() -> URL {
        return URL(string: "https://any-url.com")!
    }
    
    func expect(_ sut: RemoteAddAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedResultError), .failure(let receivedResultError)): XCTAssertEqual(expectedResultError, receivedResultError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected error receive \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any_name", email: "any_email@email.com", password: "äny_password", passwordConfirmation: "äny_password")
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "any_id", name: "any_name", email: "any_email@email.com", password: "äny_password")
    }
    
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completionWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
        
        func completionWithData(_ data: Data) {
            completion?(.success(data))
        }
        
        func get(url: URL) {
            return
        }
    }
}
