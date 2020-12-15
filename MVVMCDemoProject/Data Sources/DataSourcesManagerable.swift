//
//  DataSourcesManagerable.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/24.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failed(Error)
}

protocol DataSourcesManagerable {
    associatedtype DataType
    func loadData(_ completeHandler:@escaping (Result<[DataType]>) -> ())
}

extension DataSourcesManagerable {
    var sync:Self { return self }
    var async:Self { return self }
}
