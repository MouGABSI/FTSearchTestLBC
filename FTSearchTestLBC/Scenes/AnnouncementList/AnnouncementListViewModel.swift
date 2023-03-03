//
//  AnnouncementListViewModel.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit

class AnnouncementListViewModel {
    var service: AnnouncementListServiceProtocol?
    
    weak var dataSource : GenericDataSource<TableSectionViewModel>?
    var announcements: [Announcement] = []
    var categories: [LBCCategory] = []
    
    init(dataSource : GenericDataSource<TableSectionViewModel>?) {
        self.dataSource = dataSource
    }
    
    func fetchAnnouncements() {
        let group = DispatchGroup()
        group.enter()
        service?.fetchAnnouncementList(completion: { (result:Result<[Announcement], NetworkError>) in
            switch result {
                case .success(let announcements) :
                    self.announcements = announcements.sorted { ($0.createdOn ?? Date()) > ($1.createdOn ?? Date()) }.sorted{$0.isUrgent && !$1.isUrgent}
                    let worker = AnnouncementListWorker()
                    let sections = worker.generateSectionsViewModel(announcement: announcements)
                    self.dataSource?.data.value = sections
                    group.leave()
                case .failure(let error):
                    print("-----> \(error)")
                    group.leave()
            }
        })
        group.enter()
        service?.fetchCategories(completion: { (result:Result<[LBCCategory], NetworkError>) in
            switch result {
                case .success(let categories) :
                    
                    self.categories = categories
                    let allCategories = LBCCategory(id: 0, name: "All")
                    self.categories.insert(allCategories, at: 0)
                    group.leave()
                case .failure(let error):
                    print("-----> \(error)")
                    group.leave()
            }
        })
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            // this code will be executed when both methods have completed
            print("Both methods completed")
            print("categories -----> \(self.categories)")
            print("announcements -----> \(self.announcements)")
            self.setCategoryForAnnoucement(self.categories)
        }
    }
    
    internal func setCategoryForAnnoucement(_ categories: [LBCCategory]) {
        self.announcements = self.announcements.map({ (announcement) -> Announcement in
            var item = announcement
            let category = categories.first { return $0.id == announcement.categoryID}
            item.categoryName = category?.name
            return item
        })
    }
    
    func getAdvertisement(byCategory category: LBCCategory?) {
        
        var filteredAnnouncements = self.announcements
        if let _category = category, _category.id != 0 {
            filteredAnnouncements = announcements.filter({ $0.categoryID == _category.id })
        }
        let worker = AnnouncementListWorker()
        let sections = worker.generateSectionsViewModel(announcement: filteredAnnouncements)
        self.dataSource?.data.value = sections
    }
}

struct AnnouncementSectionViewModel: TableSectionViewModel {
    var dataModel: [TableRowViewModel]
    
}

struct AnnouncementRowViewModel: TableRowViewModel {
    
    var rowClass: AnyClass { return AnnouncementListCell.self }
    
    var rowHeight: CGFloat { return UITableView.automaticDimension }
    var identifier: Int
    var title: String
    var category: LBCCategory
    var price: Double
    var images: ImageURL
    var isUrgent: Bool
    func configure(_ cell: UITableViewCell) {
        
        if let announcementCell = cell as? AnnouncementListCell {
            announcementCell.configure(model: self)
        }
        
    }
}
