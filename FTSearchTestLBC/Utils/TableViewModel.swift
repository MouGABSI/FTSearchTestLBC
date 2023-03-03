//
//  TableViewModel.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit

// MARK: - Generic Table View Model
extension Array where Element == TableSectionViewModel {
    
    func headerViewModel(_ section: Int) -> TableHeaderViewModel? { return self[section].header }
    func numberOfRows(_ section: Int) -> Int { return self[section].count }
    func row(rowAt indexPath: IndexPath) -> TableRowViewModel? {
        if indexPath.section < self.count {
            if indexPath.row < self[indexPath.section].dataModel.count {
                return self[indexPath.section].dataModel[indexPath.row]
            }
        }
        return nil
    }
}
// MARK: - Generic Table Section View Model to avoid if - else in table headers method if we have multiple section with differents headers UI
protocol TableSectionViewModel {
    var header: TableHeaderViewModel? { get }
    var dataModel: [TableRowViewModel] { get }
    
    var count: Int { get }
}

extension TableSectionViewModel {
    var header: TableHeaderViewModel? { return nil }
    var count: Int { return dataModel.count }
}

protocol TableHeaderViewModel {
    var rowClass: AnyClass { get }
    var headerHeight: CGFloat { get }
    
    func configure(_ view: UITableViewHeaderFooterView, isExpanded: Bool?)
}
// MARK: - Generic Table Row View Model to avoid if - else in table cellForRow method if we have multiple rows with differents UI
protocol TableRowViewModel {
    var rowClass: AnyClass { get }
    var rowHeight: CGFloat { get }
    
    func configure(_ cell: UITableViewCell)
}

/**
 Extension UITableViewCell that offer
 a reuse identifier which is the name of the class
 */
extension UITableViewCell {
    /// Default Identifier for reuse
    @objc static var identifier: String {
        return String(describing: self)
    }
}
