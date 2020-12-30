//
//  ListDataSourcesManager.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/24.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

enum LoadDataError : Error {
    case failedToFoundResources
    case failedToConvertData
    case failedToDecodeData
}

class ListDataSourcesManager : DataSourcesManagerable {
    typealias DataType = ContentModel
    
    func loadData(_ completeHandler: @escaping (Result<[DataType]>) -> Void) {
        loadLocalJsonFile(completeHandler)
    }
}

private extension ListDataSourcesManager {
    func convertToContentModel(jsonData: Data) -> ListDataModel? {
           guard let lists = try? JSONDecoder().decode(ListDataModel.self, from: jsonData) else { return nil }
           return lists
       }
       
       func loadLocalJsonFile(_ completeHandler: @escaping (Result<[DataType]>) -> ()) {
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                guard let path = Bundle.main.path(forResource: "list", ofType: "json") else {
                    completeHandler(.failed(LoadDataError.failedToFoundResources))
                    return
                }
                
                guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                    completeHandler(.failed(LoadDataError.failedToConvertData))
                    return
                }
                
                guard let listData = self.convertToContentModel(jsonData: data) else {
                    completeHandler(.failed(LoadDataError.failedToDecodeData))
                    return
                }

                completeHandler(.success(listData.list))
            }
       }
}
