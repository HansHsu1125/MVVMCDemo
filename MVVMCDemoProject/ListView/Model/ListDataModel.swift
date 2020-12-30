//
//  ListDataModel.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/21.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import Foundation

struct ContentModel : Decodable {
    let title: String
    let content: String
}

struct ListDataModel : Decodable {
    let list: [ContentModel]
}
