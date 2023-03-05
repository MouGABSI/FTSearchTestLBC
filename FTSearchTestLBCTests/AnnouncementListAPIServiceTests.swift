//
//  AnnouncementListAPIServiceTests.swift
//  FTSearchTestLBCTests
//
//  Created by Mouldi GABSI on 05/03/2023.
//

import XCTest
@testable import FTSearchTestLBC

final class AnnouncementListAPIServiceTests: XCTestCase {
    
    var apiService: AnnouncementListServiceProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiService = AnnouncementListServiceMock()
    }
    
    func testFetchAnnouncementList() {
        let expectation = self.expectation(description: "Fetching announcement list")
        
        apiService.fetchAnnouncementList { result in
            switch result {
                case .success(let announcements):
                    XCTAssertEqual(announcements.count, 3, "Announcements list count should be 3")
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error fetching announcement list: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchCategories() {
        let expectation = self.expectation(description: "Fetching categories")
        
        apiService.fetchCategories { result in
            switch result {
                case .success(let categories):
                    XCTAssertEqual(categories.count, 12, "Announcements list count should be 3")
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error fetching categories: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
