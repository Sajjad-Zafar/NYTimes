//
//  NetworkServiceTests.swift
//  NYTimesTests
//
//  Created by Sajjad Zafar on 6/25/23.
//

import XCTest
import Combine
@testable import NYTimes

class ViewModelTest: XCTestCase {
    
    var sut: NewsListingViewModel!
    var mockNetworkService: MockNetworkService!
    var mockImageLoaderService: MockImageLoaderService!
    private let appear = PassthroughSubject<Void, Never>()
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockImageLoaderService = MockImageLoaderService()
        sut = NewsListingViewModel(service: mockNetworkService, imageLoader: mockImageLoaderService)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        mockImageLoaderService = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    /// Test the fetch popular news with the mock data, it should successfully load the data and it has only 1 result.
    func test_FetchMostPopularNews_Successfully() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch most popular news successfully")
        
        let input = NewsListingViewModel.Input(appear: appear.eraseToAnyPublisher())
        
        // When
        let output = sut.transform(input)
        var state: NewsListingState?
        output.result
            .sink(receiveValue: { newState in
                state = newState
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        appear.send()
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        
        switch state {
        case .success(let newsViewModels):
            XCTAssertEqual(newsViewModels[0].title, "Spelling Bee Buddy: Personalized Hints That Update as You Play")
            XCTAssertEqual(newsViewModels[0].abstract, "Customized hints that update based on your progress in today’s puzzle.")
            XCTAssertEqual(newsViewModels[0].section, "The Upshot")
            XCTAssertEqual(newsViewModels[0].byLine, "By Neil Berg, Matthew Conlen, Josh Katz, Aaron Krolik, Eve Washington and Eden Weingart")
            XCTAssertEqual(newsViewModels[0].id, 100000008839905)
            XCTAssertEqual(newsViewModels[0].publishedDate, "2023-04-10")
        default:
            XCTFail("Unexpected state: \(String(describing: state))")
        }
    }
}
