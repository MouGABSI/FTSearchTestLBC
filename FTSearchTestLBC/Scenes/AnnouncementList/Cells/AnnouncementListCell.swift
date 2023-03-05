//
//  AnnouncementListCell.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

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
        label.setContentCompressionResistancePriority(.required, for: .vertical)
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
    
    func setUrgentLayoutConstraints() {
        
        urgentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive            = true
        urgentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        urgentLabel.widthAnchor.constraint(equalToConstant: 100).isActive                                 = true
        urgentLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                 = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = .flexibleHeight
    }
    
    func setUp() {
        setupStackViews()
        contentView.addSubview(urgentLabel)
        setUrgentLayoutConstraints()
    }
    
    func configure(model: AnnouncementRowViewModel) {
        titleLabel.text       = model.title
        titleLabel.setDynamicTextColor()
        categoryLabel.text   = model.category.name
        categoryLabel.setDynamicTextColor()
        priceLabel.text      = "\(model.price)€"
        priceLabel.textColor = UIColor().lbcOrange
        urgentLabel.text     = "Urgent"
        urgentLabel.textAlignment = .center
        urgentLabel.backgroundColor = UIColor().lbcOrange
        urgentLabel.textColor       = .white
        urgentLabel.isHidden = !model.isUrgent
        
        if let iconUrString = model.images.small, let iconURL = URL(string: iconUrString) {
            ImageLoader.image(for: iconURL) { image in
                DispatchQueue.main.async { [weak self] in
                    self?.icon.image = image
                }
            }
        }
    }
    
    func setupStackViews() {
        let iconStackView = UIStackView()
        iconStackView.translatesAutoresizingMaskIntoConstraints = false
        iconStackView.axis = .vertical
        iconStackView.spacing = 10
        contentView.addSubview(iconStackView)
        
        icon.clipsToBounds = true
        icon.layer.cornerRadius = 20
        iconStackView.addArrangedSubview(icon)
        
        priceLabel.numberOfLines = 0
        iconStackView.addArrangedSubview(priceLabel)
        
        let titleStackView = UIStackView()
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .vertical
        titleStackView.spacing = 8
        contentView.addSubview(titleStackView)
        
        titleLabel.numberOfLines = 0
        titleStackView.addArrangedSubview(titleLabel)
        
        categoryLabel.numberOfLines = 0
        titleStackView.addArrangedSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 80),
            icon.widthAnchor.constraint(equalToConstant: 80),
            iconStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            iconStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            iconStackView.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            
            titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            titleStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titleStackView.leadingAnchor.constraint(equalTo: iconStackView.trailingAnchor, constant: 20),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
    }
}
