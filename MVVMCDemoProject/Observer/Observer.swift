//
//  Observer.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/22.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

class Observer<T> {
    private var observers: [String: CompletionHandler] = .init()
    private let lock: NSLock = .init()
    public private(set) var value: ValueType {
        didSet {
             notify()
        }
    }
    
    init(_ value: ValueType) {
        self.value = value
    }
    
    deinit {
        observers.removeAll()
    }

    private func notify() {
        let targets = observers
        targets.forEach({ $0.value(value) })
    }
}

// Observerable
extension Observer : Observerable {
    public typealias ValueType = T
    
    func addObserver(_ observer: AnyObject, completionHandler: @escaping CompletionHandler) {
        defer { lock.unlock() }
        lock.lock()
        observers[observer.description] = completionHandler
    }

    func removeObserver(_ observer: AnyObject) {
        defer { lock.unlock() }
        lock.lock()
        observers.removeValue(forKey: observer.description)
    }
    
    func just(_ value: ValueType) {
        self.value = value
    }
}
