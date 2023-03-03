//
//  LBCAnnouncement.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation
// MARK: - Announcement
struct Announcement: Codable {
    let id, categoryID: Int
    var categoryName: String?
    let title, announcementDescription: String
    let price: Double
    let imagesURL: ImageURL
    let creationDate: String?
    let isUrgent: Bool
    let siret: String?
    var createdOn: Date? { return creationDate?.toDate }
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case announcementDescription = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
        case categoryName
    }
}

// MARK: - ImagesURL
struct ImageURL: Codable {
    let small: String?
    let thumb: String?
}
