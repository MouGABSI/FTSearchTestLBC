//
//  AnnouncementListViewModel.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit

protocol AnnouncementListViewModelProtocol {
    var dataSource : GenericDataSource<TableSectionViewModel>? { get set }
    var announcements: [Announcement] { get }
    var categories: DynamicValue<[LBCCategory]> { get }
    var isLoading: DynamicValue<Bool> { get }
    func fetchData()
    func getAnnouncements(byCategory category: LBCCategory?)
}

class AnnouncementListViewModel: AnnouncementListViewModelProtocol {
    
    private let service: AnnouncementListServiceProtocol?
    private let worker: AnnouncementListWorker
    var categories: DynamicValue<[LBCCategory]> = DynamicValue([])
    weak var dataSource: GenericDataSource<TableSectionViewModel>?
    var isLoading: DynamicValue<Bool>
    var announcements: [Announcement] = []
    
    init(service: AnnouncementListServiceProtocol, worker: AnnouncementListWorker, isLoading: DynamicValue<Bool>) {
        self.service = service
        self.worker = worker
        self.isLoading = isLoading
    }
    
    func fetchData() {
        let group = DispatchGroup()
        group.enter()
        isLoading.value = true
        service?.fetchAnnouncementList(completion: { (result:Result<[Announcement], NetworkError>) in
            switch result {
                case .success(let announcements) :
                    self.announcements = announcements.sorted { ($0.createdOn ?? Date()) > ($1.createdOn ?? Date()) }.sorted{$0.isUrgent && !$1.isUrgent}
                    let worker = AnnouncementListWorker()
                    let sections = worker.generateSectionsViewModel(announcements: announcements)
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
                    
                    var allCategories = categories
                    let allCategory = LBCCategory(id: 0, name: "All")
                    allCategories.insert(allCategory, at: 0)
                    self.categories.value = allCategories
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
            self.isLoading.value = false
            self.setCategoryForAnnouncements(self.categories.value)
            let worker = AnnouncementListWorker()
            let sections = worker.generateSectionsViewModel(announcements: self.announcements)
            self.dataSource?.data.value = sections
        }
    }
    
    private func setCategoryForAnnouncements(_ categories: [LBCCategory]) {
        announcements = announcements.map { (announcement) in
            var item = announcement
            let category = categories.first { $0.id == announcement.categoryID }
            item.categoryName = category?.name
            return item
        }
    }
    
    func getAnnouncements(byCategory category: LBCCategory?) {
        var filteredAnnouncements = self.announcements
        if let _category = category, _category.id != 0 {
            filteredAnnouncements = announcements.filter({ $0.categoryID == _category.id })
        }
        let worker = AnnouncementListWorker()
        let sections = worker.generateSectionsViewModel(announcements: filteredAnnouncements)
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
    var price: Int
    var images: ImageURL
    var isUrgent: Bool
    func configure(_ cell: UITableViewCell) {
        
        if let announcementCell = cell as? AnnouncementListCell {
            announcementCell.configure(model: self)
        }
        
    }
}
