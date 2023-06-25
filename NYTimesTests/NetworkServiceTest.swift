//
//  NetworkServiceTest.swift
//  NYTimesTests
//
//  Created by Sajjad Zafar on 6/25/23.
//

import XCTest
import Combine
@testable import NYTimes

class NetworkServiceTests: XCTestCase {
    
    var sut: NetworkServiceSpy!
    
    override func setUp() {
        super.setUp()
        sut = NetworkServiceSpy()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_LoadDataFromJson_ShouldPassSuccessfully() {
        // Given
        let mockData = """
            {
                "status": "Ok",
                "copyright": "Copyright (c) 2023 The New York Times Company.  All Rights Reserved.",
                "num_results": 0,
                "results": []
            }
        """.data(using: .utf8)!
        let expectedResult = NewsModel(status: "Ok", copyright: "Copyright (c) 2023 The New York Times Company.  All Rights Reserved.", numResults: 0, results: [])
        sut.mockData = mockData
        
        // When
        let resource = Resource<NewsModel>.popularNews()
        let publisher = sut.load(resource)
        
        var receivedResult: NewsModel?
        let expectation = XCTestExpectation(description: "Convert data from local json to model successfully")
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Unexpected error: \(error)")
                }
            }, receiveValue: { result in
                receivedResult = result
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 2.0)
        
        XCTAssertEqual(receivedResult?.numResults, expectedResult.numResults)
        XCTAssertEqual(receivedResult?.status, expectedResult.status)
        XCTAssertEqual(receivedResult?.copyright, expectedResult.copyright)
        cancellable.cancel()
    }
    
    func test_LoadInvalidRequest_ShouldFail() {
        // Given
        let expectedError = NetworkError.invalidRequest
        sut.mockError = expectedError

        // When
        let resource = Resource<NewsModel>.popularNews()
        let publisher = sut.load(resource)

        // Then
        var receivedError: Error?
        let expectation = XCTestExpectation(description: "Receive error of invalid request")
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected result")
            })

        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(receivedError as? NetworkError)
        cancellable.cancel()
    }
}
