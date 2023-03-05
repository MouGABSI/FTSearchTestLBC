//
//  AnnouncementListViewModelTests.swift
//  FTSearchTestLBCTests
//
//  Created by Mouldi GABSI on 05/03/2023.
//

import XCTest
@testable import FTSearchTestLBC

final class AnnouncementListViewModelTests: XCTestCase {
    
    var viewModel: AnnouncementListViewModel!
    var dataSource: GenericDataSource<TableSectionViewModel>!
    
    override func setUpWithError() throws {
        super.setUp()
        let service = AnnouncementListServiceMock()
        let worker = AnnouncementListWorker()
        viewModel = AnnouncementListViewModel(service: service, worker: worker)
        dataSource = GenericDataSource<TableSectionViewModel>()
        viewModel.dataSource = dataSource
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchData() {
        let expectation = XCTestExpectation(description: "Fetch data expectation")
        viewModel.fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.categories.value.count, 12, "Categories count should be 12")
            XCTAssertEqual(self.viewModel.announcements.count, 3, "Announcement List should contains only 3 announcement")
            XCTAssertGreaterThan(self.dataSource.data.value.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGetAnnouncements() {
        let expectation = XCTestExpectation(description: "Get announcements expectation")
        viewModel.fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let category = LBCCategory(id: 4, name: "Test Category")
            self.viewModel.getAnnouncements(byCategory: category)
            XCTAssertEqual(self.dataSource.data.value.count, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}
