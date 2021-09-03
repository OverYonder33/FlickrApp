//
//  FlickrFeedListViewModelTests.swift
//  FlickrAppTests
//
//  Created by Carlos Henderson on 9/3/21.
//

import XCTest
@testable import FlickrApp

class FlickrFeedListViewModelTests: XCTestCase {

    var viewModelList: FlickrFeedListViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.viewModelList = FlickrFeedListViewModel(service: MockService())
    }

    override func tearDownWithError() throws {
        self.viewModelList = nil
        try super.tearDownWithError()
    }

    func testDataSuccess() {
        let expectationList = XCTestExpectation(description: "Successfully returning List Data")
        let expectationImage = XCTestExpectation(description: "Successfully returning image")
        var imageData: Data?
        
        self.viewModelList.bind {
            expectationList.fulfill()
        } errorH: { _ in
            XCTFail()
        }
        self.viewModelList.getItems(query: "Dolphin,whale")
        wait(for: [expectationList], timeout: 3)
        
        self.viewModelList.image(for: 0) { data in
            imageData = data
            expectationImage.fulfill()
        }
        wait(for: [expectationImage], timeout: 3)
        
        XCTAssertEqual(self.viewModelList.count, 20)
        XCTAssertNotNil(imageData)
    }
    
    func testDataFail() {
        let expectation = XCTestExpectation(description: "Failure occured")
        var error: Error?
        
        self.viewModelList.bind {
            XCTFail()
        } errorH: { err in
            error = err
            expectation.fulfill()
        }
        self.viewModelList.getItems(query: "fail")
        wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(error as? NetworkError, NetworkError.badData)
        XCTAssertEqual(self.viewModelList.count, 0)

    }
    
    
}
