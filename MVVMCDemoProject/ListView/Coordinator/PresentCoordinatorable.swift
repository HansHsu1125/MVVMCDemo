//
//  PresentCoordinatorable.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/28.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

protocol PresentCoordinatorable {
    func presentViewController(customInfo: [String : Any]?)
}
