//
//  AnyListViewModel.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/27.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

class AnyListViewModel<T, U : Observerable> {
    typealias DataType = T
    typealias ObserverType = U
    typealias AnyListModelCallBack = (([DataType]?) -> ())
    public var dataChangeHandler: (AnyObserver<ObserverType>)?
    public var loadDataHandler: (() -> ())?
    public var didSelectHandler: ((DataType) -> ())?
}

//ListViewModelable - api
extension AnyListViewModel : ListViewModelable {
    var dataChange: (AnyObserver<ObserverType>)? {
        get {
            return dataChangeHandler
        }
    }
    
    func loadData() {
        guard let handler = loadDataHandler else { return }
        handler()
    }
    
    func didSelect(info data: DataType) {
        guard let handler = didSelectHandler else { return }
        handler(data)
    }
}
