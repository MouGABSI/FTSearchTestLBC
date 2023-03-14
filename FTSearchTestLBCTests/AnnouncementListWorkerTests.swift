//
//  AnnouncementListWorkerTests.swift
//  FTSearchTestLBCTests
//
//  Created by Mouldi GABSI on 05/03/2023.
//

import XCTest
@testable import FTSearchTestLBC

final class AnnouncementListWorkerTests: XCTestCase {
    
    var viewModel: AnnouncementListViewModel!
    var dataSource: GenericDataSource<TableSectionViewModel>!
    
    override func setUpWithError() throws {
        super.setUp()
        let service = AnnouncementListServiceMock()
        let worker = AnnouncementListWorker()
        viewModel = AnnouncementListViewModel(service: service, worker: worker, isLoading: DynamicValue(false))
        dataSource = GenericDataSource<TableSectionViewModel>()
        viewModel.dataSource = dataSource
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGenerateSectionsViewModel() throws {
        let expectation = XCTestExpectation(description: "Fetch data expectation")
        viewModel.fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let sections = self.dataSource.data.value
            XCTAssertEqual(sections.count, 1, "Sections should contains one Table View Section")
            let firstSection = sections[0]
            let rows = firstSection.dataModel
            XCTAssertEqual(rows.count, 3, "rows should contains 3 elements")
            let firstRow = rows[0]
            let lastRow = rows[2]
            print("sections ----> \(sections)")
            XCTAssertTrue(firstRow is AnnouncementRowViewModel, "FirstRow should not be an AnnouncementRowViewModel")
            let firstAnnouncementRowVM = firstRow as! AnnouncementRowViewModel
            let lastRowVM = lastRow as! AnnouncementRowViewModel
            XCTAssertTrue(firstAnnouncementRowVM.isUrgent, "First Announcement should be urgent")
            XCTAssertFalse(lastRowVM.isUrgent, "Last Announcement Should not be urgent!")
            XCTAssertEqual(firstAnnouncementRowVM.title, "Statue homme noir assis en plâtre polychrome")
            XCTAssertEqual(firstAnnouncementRowVM.category.name, "Maison")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
}
