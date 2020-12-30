//
//  ViewModelable.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/27.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

protocol ListViewModelable {
    associatedtype DataType
    associatedtype ObserverType: Observerable
    var dataChange: AnyObserver<ObserverType>? { get }
    func loadData()
    func didSelect(info data: DataType)
}

extension ListViewModelable {
    var inputs: Self { return self }
    var outputs: Self { return self }
}
