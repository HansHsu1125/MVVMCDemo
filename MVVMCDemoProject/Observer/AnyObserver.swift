//
//  AnyObserver.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/31.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

class AnyObserver<T:Observerable> {
    private let _observer:T
    
    init(_ observer:T) {
        _observer = observer
    }
}

extension AnyObserver: Observerable {
    typealias ValueType = T.ValueType
    var value: T.ValueType {
        return _observer.value
    }
    
    func addObserver(_ observer: AnyObject, completionHandler: @escaping CompletionHandler) {
        _observer.addObserver(observer, completionHandler: completionHandler)
    }

    func removeObserver(_ observer: AnyObject) {
        _observer.removeObserver(observer)
    }
    
    func just(_ value: ValueType) {
        _observer.just(value)
    }
}
