//
//  AnnoucementDetailsViewController.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit

class AnnoucementDetailsViewController: UIViewController {
    
    //MARK: Vars
    
    var currentAnnouncement: Announcement?
    let scrollView = UIScrollView()
    let scrollViewContentView = UIView()
    
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
   
    let descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: Initializer
    init(annoucement: Announcement) {
        self.currentAnnouncement = annoucement
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? .black : .white
            }
        } else {
            view.backgroundColor = .white
        }
    }
    
    func configureUI() {
        configureScrollView()
        configureTitleLabel()
        configureIconImageView()
        configurePriceLabel()
        configureCategoryLabel()
        configureDescriptionLabel()
        configureIsUrgentLabel()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContentView.topAnchor.constraint(equalTo:scrollView.topAnchor).isActive = true
        scrollViewContentView.leftAnchor.constraint(equalTo:scrollView.leftAnchor).isActive = true
        scrollViewContentView.rightAnchor.constraint(equalTo:scrollView.rightAnchor).isActive = true
        scrollViewContentView.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor).isActive = true
    }
    
    func configureIconImageView() {
        scrollViewContentView.addSubview(icon)
        icon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive            = true
        icon.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 30).isActive    = true
        icon.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
        if let iconUrlString = currentAnnouncement?.imagesURL.thumb, let iconURL = URL(string: iconUrlString) {
            ImageLoader.image(for: iconURL) { image in
              self.icon.image = image
            }
        }
    }
    
    func configureTitleLabel() {
        scrollViewContentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.setDynamicTextColor()
        titleLabel.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: 30).isActive            = true
        titleLabel.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 20).isActive    = true
        titleLabel.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -20).isActive = true
        titleLabel.text = currentAnnouncement?.title
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
    }
    
    func configureCategoryLabel() {
        scrollViewContentView.addSubview(categoryLabel)
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .left
        categoryLabel.setDynamicTextColor()
        categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive                    = true
        categoryLabel.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 20).isActive    = true
        categoryLabel.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -30).isActive = true
        categoryLabel.text = currentAnnouncement?.categoryName
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
    }
    
    func configurePriceLabel() {
        scrollViewContentView.addSubview(priceLabel)
        priceLabel.numberOfLines = 1
        priceLabel.textAlignment = .left
        priceLabel.textColor = UIColor().lbcOrange
        priceLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 20).isActive                          = true
        priceLabel.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 20).isActive    = true
        priceLabel.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -80).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 28).isActive                                            = true
        priceLabel.text = "\(currentAnnouncement?.price ?? 0)€"
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
    }
    
    func configureDescriptionLabel() {
        scrollViewContentView.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.setDynamicTextColor()
        descriptionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15).isActive                 = true
        descriptionLabel.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 20).isActive    = true
        descriptionLabel.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -30).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor, constant: -20).isActive     = true
        descriptionLabel.text = currentAnnouncement?.announcementDescription
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func configureIsUrgentLabel() {
        scrollViewContentView.addSubview(urgentLabel)
        urgentLabel.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: 5).isActive             = true
        urgentLabel.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -10).isActive = true
        urgentLabel.widthAnchor.constraint(equalToConstant: 100).isActive                                            = true
        urgentLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                            = true
        urgentLabel.text            = "Urgent"
        urgentLabel.textAlignment   = .center
        urgentLabel.backgroundColor = UIColor(red: 238.0/255.0, green: 104.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        urgentLabel.textColor       = .white
        urgentLabel.isHidden = !(currentAnnouncement?.isUrgent ?? false)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
