//
//  AnnouncementListViewController.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit

class AnnouncementListViewController: UIViewController {
    
    var dataSource: AnnouncementListDataSource?
    var viewModel : AnnouncementListViewModel?
    var selectedId: Int?
    var selectedCategory: LBCCategory?
    
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
        self.dataSource?.data.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.announcementTableView.reloadData()
                self?.setupFilterView()
            }
        }
        fetchAnnounecementOnLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(displayFilter))
        
    }
    
    func setupFilterView() {
        filterController = FilterTableViewController<LBCCategory>(viewModel?.categories ?? []) { (category) -> String in
            category.description
        } onSelect: { (category) in
            self.selectedCategory = (self.selectedCategory == category) ? nil : category
            self.viewModel?.getAdvertisement(byCategory: self.selectedCategory)
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
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(announcementTableView)
        
        announcementTableView.translatesAutoresizingMaskIntoConstraints = false
        announcementTableView.estimatedRowHeight = 10
        announcementTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        announcementTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        announcementTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        announcementTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        announcementTableView.register(AnnouncementListCell.self, forCellReuseIdentifier: AnnouncementListCell.identifier)
        announcementTableView.dataSource = dataSource
        announcementTableView.delegate = self
        
    }
    
    // MARK: Event handling
    
    /**
     fetchAnnounecementOnLoad() is called by the ViewController
     AKA: Ask the Interactor to do fetch announecements
     */
    func fetchAnnounecementOnLoad() {
        viewModel?.fetchAnnouncements()
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
