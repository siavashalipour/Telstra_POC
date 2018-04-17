//
//  ListViewController.swift
//  Telstra
//
//  Created by Siavash on 17/4/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import SnapKit
import RxCocoa
import RxSwift

final class ListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: String(describing: CustomCell.self))
        return tableView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var viewModel: ListViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        refresh()
        setupUI()
    }
    
    // MARK: - private methods
    private func bindUI() {
        spinner.startAnimating()
        _ = viewModel.rowsUpdated.subscribe { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
        }
        _ = viewModel.titleUpdated.subscribe({ (event) in
            DispatchQueue.main.async {
                self.title = event.element
                self.spinner.stopAnimating()
            }
        })
    }
    
    @objc
    private func refresh() {
        viewModel.fetchData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view.addSubview(spinner)
        spinner.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(30)
        }
        addRightBarButtonItem()
    }
    
    private func addRightBarButtonItem() {
        let rightBarButton = UIBarButtonItem.init(title: "Refresh", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.refresh))
        navigationItem.rightBarButtonItem = rightBarButton
    }
}
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell
        if let aCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomCell.self)) as? CustomCell{
            cell = aCell
        } else {
            cell = CustomCell()
        }
        if let vm = viewModel.item(at: indexPath) {
            cell.config(with: vm)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
