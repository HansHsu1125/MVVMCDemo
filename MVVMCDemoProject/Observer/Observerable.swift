//
//  Observerable.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/31.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

protocol Observerable {
    associatedtype ValueType
    typealias CompletionHandler = ((ValueType) -> Void)
    var value: ValueType { get }
    func addObserver(_ observer: AnyObject, completionHandler: @escaping CompletionHandler)
    func removeObserver(_ obsserver: AnyObject)
    func just(_ value: ValueType)
}
