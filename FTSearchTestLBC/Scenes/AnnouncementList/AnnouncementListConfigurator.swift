//
//  AnnouncementListConfigurator.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit

final class AnnouncementListConfigurator {


    // MARK: - Singleton

    static let shared: AnnouncementListConfigurator = AnnouncementListConfigurator()


    // MARK: - Configuration

    func configure(viewController: AnnouncementListViewController) {

        let service = AnnouncementListAPIService()
        let dataSource = AnnouncementListDataSource()
        let isLoading = DynamicValue(false)
        let viewModel  = AnnouncementListViewModel(service: service, worker: AnnouncementListWorker(), isLoading: isLoading)
        viewModel.dataSource = dataSource
        viewModel.isLoading = isLoading
        viewController.dataSource = dataSource
        viewController.viewModel = viewModel
        
    }
}
