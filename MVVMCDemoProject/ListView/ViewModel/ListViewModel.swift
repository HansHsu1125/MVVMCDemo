//
//  ListViewModel.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/21.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

internal let modelKeyNameOfCustomInfo = "model"

final class ListViewModel : ListViewModelable {
    typealias DataType = ContentModel
    typealias ObserverType = Observer<[DataType]?>
    private let dataSourcesManager: ListDataSourcesManager
    private let coordinator: ListCoordinator
    private var shouldPresentDetail: Observer<DataType?> = .init(nil)
    public private(set) var dataChange: AnyObserver<ObserverType>? = .init(Observer.init(nil))

    init(dataSourcesManager: ListDataSourcesManager , coordinator: ListCoordinator) {
        self.dataSourcesManager = dataSourcesManager
        self.coordinator = coordinator
        bindInputs()
    }
    
    func bindInputs() {
        shouldPresentDetail.addObserver(self) { [weak self] (model) in
            guard let self = self else { return }
            guard let model = model else { return }
            let cutomInfo:[String:Any] = [modelKeyNameOfCustomInfo : model]
            self.coordinator.presentViewController(customInfo: cutomInfo)
        }
    }
}

//ListViewModelable - api
extension ListViewModel {
    func loadData() {
        dataSourcesManager.async.loadData {[weak self] (result) in
            guard let self = self else { return }
            guard let observer = self.dataChange else { return }
            guard case let Result.success(data) = result else { return }
            observer.just(data)
        }
    }
    
    func didSelect(info data: DataType) {
        shouldPresentDetail.just(data)
    }
}
