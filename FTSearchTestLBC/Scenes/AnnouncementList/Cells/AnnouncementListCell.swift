//
//  AnnouncementListCell.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation
import UIKit

class AnnouncementListCell: UITableViewCell {

    let icon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let urgentLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.backgroundColor = UIColor(red: 238.0/255.0, green: 104.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let categoryLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    func setIconLayoutConstraints() {
        
        icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive           = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive   = true
        icon.heightAnchor.constraint(equalToConstant: 80).isActive                                 = true
        icon.widthAnchor.constraint(equalToConstant: 80).isActive                                  = true
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func setTitleLayoutConstraints() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive            = true
        titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20).isActive          = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive  = true
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func setUrgentLayoutConstraints() {
        
        urgentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive            = true
        urgentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        urgentLabel.widthAnchor.constraint(equalToConstant: 100).isActive                                 = true
        urgentLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                 = true
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func setPriceLayoutConstraints() {
        
        priceLabel.heightAnchor.constraint(equalToConstant: 28).isActive                                 = true
        priceLabel.widthAnchor.constraint(equalToConstant: 120).isActive                                 = true
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive   = true
        priceLabel.topAnchor.constraint(greaterThanOrEqualTo: icon.bottomAnchor, constant: 10).isActive  = true
        priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive     = true
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func setCategoryLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categoryLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            categoryLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)
         ])
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp() {
        contentView.addSubview(icon)
        setIconLayoutConstraints()
        contentView.addSubview(titleLabel)
        setTitleLayoutConstraints()
        contentView.addSubview(urgentLabel)
        setUrgentLayoutConstraints()
        contentView.addSubview(categoryLabel)
        setCategoryLayoutConstraints()
        contentView.addSubview(priceLabel)
        setPriceLayoutConstraints()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
    func configure(model: AnnouncementRowViewModel) {
        titleLabel.text       = model.title
        titleLabel.setDynamicTextColor()
        categoryLabel.text   = model.category.name
        categoryLabel.setDynamicTextColor()
        priceLabel.text      = "\(model.price)"
        priceLabel.setDynamicTextColor()
        urgentLabel.text     = "Urgent"
        urgentLabel.textAlignment = .center
        urgentLabel.backgroundColor = UIColor(red: 238.0/255.0, green: 104.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        urgentLabel.textColor       = .white
        urgentLabel.isHidden = !model.isUrgent
        
        if let iconUrString = model.images.thumb, let iconURL = URL(string: iconUrString) {
            ImageLoader.image(for: iconURL) { image in
              self.icon.image = image
            }
        }
    }

}
