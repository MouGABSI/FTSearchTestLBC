//
//  AnnouncementListViewController.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit

class AnnouncementListViewController: UIViewController {
    
    var dataSource: AnnouncementListDataSource?
    var viewModel : AnnouncementListViewModelProtocol?
    var selectedId: Int?
    var selectedCategory: LBCCategory?
    lazy var activityIndicator = UIActivityIndicatorView()
    let announcementTableView = UITableView()
    var filterController: FilterTableViewController<LBCCategory>?
    
    init(configurator: AnnouncementListConfigurator = AnnouncementListConfigurator.shared) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    // MARK: - Configurator
    
    private func configure(configurator: AnnouncementListConfigurator = AnnouncementListConfigurator.shared) {
        
        configurator.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setupFilterView(categories: viewModel?.categories)
        self.dataSource?.data.addAndNotify(observer: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.announcementTableView.reloadData()
            }
        }
        self.viewModel?.categories.addAndNotify(observer: self, completionHandler: { [weak self] _ in
            DispatchQueue.main.async {
                self?.filterController?.refreshValues(newValues: self?.viewModel?.categories.value ?? [])
            }
        })
        self.viewModel?.isLoading.addAndNotify(observer: self, completionHandler: { [weak self] (isLoading) in
            if let loading = isLoading, loading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        })
        fetchAnnounecementOnLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(displayFilter))
        
    }
    
    func setupFilterView(categories: DynamicValue<[LBCCategory]>?) {
        filterController = FilterTableViewController<LBCCategory>(categories?.value ?? []) { (category) -> String in
            category.description
        } onSelect: { (category) in
            self.selectedCategory = (self.selectedCategory == category) ? nil : category
            self.viewModel?.getAnnouncements(byCategory: self.selectedCategory)
        }
        filterController?.preferredContentSize = CGSize(width: 300, height: 400)
    }
    
    @objc @IBAction func displayFilter(_ sender: UIBarButtonItem) {
        if let _filterController = filterController {
            showPopup(_filterController, sourceView: sender)
        }
    }
    
    private func showPopup(_ controller: UIViewController, sourceView: UIBarButtonItem) {
        if let presentationController = self.configurePresentation(forController: controller) {
            presentationController.barButtonItem = sourceView
            presentationController.permittedArrowDirections = .up
            self.present(controller, animated: true)
        }
    }
    
    func configurePresentation(forController controller : UIViewController) -> UIPopoverPresentationController? {
        controller.modalPresentationStyle = .popover
        let presentationController = controller.presentationController as? UIPopoverPresentationController
        presentationController?.delegate = self
        return presentationController
    }
    
    fileprivate func configureView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? .black : .white
            }
        } else {
            view.backgroundColor = .white
        }
        
        setupAnnouncementTableView()
        setupActivityIndicator()
        self.view.bringSubviewToFront(activityIndicator)
    }
    
    fileprivate func setupAnnouncementTableView() {
        view.addSubview(announcementTableView)
        
        announcementTableView.translatesAutoresizingMaskIntoConstraints = false
        announcementTableView.rowHeight = UITableView.automaticDimension
        announcementTableView.estimatedRowHeight = 300
        announcementTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        announcementTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        announcementTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        announcementTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        announcementTableView.register(AnnouncementListCell.self, forCellReuseIdentifier: AnnouncementListCell.identifier)
        announcementTableView.dataSource = dataSource
        announcementTableView.delegate = self
    }
    
    fileprivate func  setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.color = UIColor.lightGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    // MARK: Event handling
    
    /**
     fetchAnnounecementOnLoad() is called by the ViewController
     AKA: Ask the Interactor to do fetch announecements
     */
    func fetchAnnounecementOnLoad() {
        viewModel?.fetchData()
    }
}

// MARK: UITableViewDelegate
extension AnnouncementListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.dataSource?.data.value.row(rowAt: indexPath)?.rowHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < viewModel?.announcements.count ?? 0, let selectedAnnouncement = viewModel?.announcements[indexPath.row] {
            let viewController = AnnoucementDetailsViewController(annoucement: selectedAnnouncement)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension AnnouncementListViewController : UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
