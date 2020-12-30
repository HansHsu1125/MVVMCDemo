//
//  ListViewController.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/21.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import UIKit

class ListViewController : UIViewController {
    let lock: NSLock = .init()
    let listViewTitle: String = "Notes"
    let listViewModel: ContentListViewModel
    let loadingView: UIActivityIndicatorView = .init(style: .large)
    let tableView: UITableView = .init(frame: .zero, style: .plain)
    let reuseIdentify: String = "ListCell"
    var lists: [ContentModel]?
    
    init(viewModel: ContentListViewModel) {
        listViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarSytyle()
        setupObserver()
        setupSubViews()
        setupConstraints()
        fetchData()
    }
}

// For initial
private extension ListViewController {
    func setupNavBarSytyle() {
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = listViewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSubViews() {
        view.backgroundColor = .white
        
        tableView.register(ListCell.self, forCellReuseIdentifier: reuseIdentify)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        loadingView.isHidden = true
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        view.setNeedsUpdateConstraints()
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide:UILayoutGuide = view.safeAreaLayoutGuide
        tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor , constant: 10).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor , constant: -10).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor , constant:  10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor , constant: -10).isActive = true
        
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupObserver() {
        listViewModel.outputs.dataChange?.addObserver(self, completionHandler: prcessData(datas:))
    }
}

// Private - api
private extension ListViewController {
    func refreshListView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func startLoadingView() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.isHidden = false
            self?.loadingView.startAnimating()
        }
    }
    
    func stoptLoadingView() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.isHidden = true
            self?.loadingView.stopAnimating()
        }
    }
}

// Process data
extension ListViewController {
    func fetchData() {
        startLoadingView()
        listViewModel.outputs.loadData()
    }
    
    func prcessData(datas: [ContentModel]?) {
        guard let listData = datas else { return }
        updateListData(datas: listData)
        stoptLoadingView()
        refreshListView()
    }
    
    func updateListData(datas: [ContentModel]?) {
        defer { lock.unlock() }
        lock.lock()
        lists = datas
    }
}

// UITableViewDataSource
extension ListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas = lists else { return 0 }
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentify) as? ListCell else {
            let cell = ListCell.init(style: .default, reuseIdentifier: reuseIdentify)
            return cell
        }

        return contentCell
    }
}

// UITableViewDelegate
extension ListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let datas = lists else { return }
        guard indexPath.row < datas.count else { return }
        guard let contentCell = cell as? ListCell else { return }
        
        let contentInfo:ContentModel = datas[indexPath.row]
        contentCell.configure(info: contentInfo)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let datas = lists else { return }
        guard indexPath.row < datas.count else { return }
        
        let contentInfo:ContentModel = datas[indexPath.row]
        listViewModel.inputs.didSelect(info: contentInfo)
    }
}
