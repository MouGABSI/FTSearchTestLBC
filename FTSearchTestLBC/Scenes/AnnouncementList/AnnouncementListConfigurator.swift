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

        let service = AdvertisementListAPIService()
        let dataSource = AnnouncementListDataSource()
        var viewModel  = AnnouncementListViewModel(dataSource: dataSource)
        viewController.dataSource = dataSource
        viewModel.service = service
        viewController.viewModel = viewModel
        
    }
}
