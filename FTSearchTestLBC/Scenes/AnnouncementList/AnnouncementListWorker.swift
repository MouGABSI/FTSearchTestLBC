//
//  AnnouncementListWorker.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation

struct AnnouncementListWorker {
    func generateSectionsViewModel(announcement: [Announcement]) -> [AnnouncementSectionViewModel] {
        let sortedAnnouncements = announcement.sorted { ($0.createdOn ?? Date()) > ($1.createdOn ?? Date()) }.sorted{$0.isUrgent && !$1.isUrgent}
        let rows = sortedAnnouncements.map { (announcement) -> AnnouncementRowViewModel in
            AnnouncementRowViewModel(identifier: announcement.id,
                                      title: announcement.title,
                                     category: LBCCategory(id: announcement.categoryID, name: announcement.categoryName ?? ""),
                                      price: announcement.price,
                                      images: announcement.imagesURL,
                                      isUrgent: announcement.isUrgent)
        }
        let sections = rows.count > 0 ? [AnnouncementSectionViewModel(dataModel: rows)] : []
        return sections
    }
}
