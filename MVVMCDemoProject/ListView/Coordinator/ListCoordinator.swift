//
//  ListCoordinator.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/21.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import UIKit

typealias ContentListViewModel = AnyListViewModel<ContentModel,Observer<[ContentModel]?>>

class ListCoordinator : Coordinator<UINavigationController> {
    var viewController:UIViewController!
    
    override func start() {
        viewController = generateListViewController()
        show(viewController: viewController)
        super.start()
    }
}

//Private - api
private extension ListCoordinator {
    func generateListViewModel() -> ContentListViewModel {
        let listDataSourcesManager:ListDataSourcesManager = .init()
        let listViewModel:ListViewModel = .init(dataSourcesManager: listDataSourcesManager , coordinator: self)
        let anyListViewModel:ContentListViewModel = .init()
        anyListViewModel.dataChangeHandler = listViewModel.dataChange
        anyListViewModel.loadDataHandler = listViewModel.loadData
        anyListViewModel.didSelectHandler = listViewModel.inputs.didSelect
        return anyListViewModel
    }
    
    func generateListViewController() -> ListViewController {
        let viewModel:ContentListViewModel = generateListViewModel()
        let listViewController:ListViewController = .init(viewModel: viewModel)
        return listViewController
    }
}

//PresentCoordinatorable - api
extension ListCoordinator : PresentCoordinatorable {
    func presentViewController(customInfo:[String : Any]? = nil) {
        guard let info = customInfo?[modelKeyNameOfCustomInfo] as? ContentModel else { return }
        let detailViewController:DetailViewController = .init(contentInfo: info)
        present(viewController: detailViewController)
    }
}
