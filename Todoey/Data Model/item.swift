//
//  item.swift
//  Todoey
//
//  Created by Chien-yeh Hsu on 8/2/19.
//  Copyright © 2019 PenHsinHsu. All rights reserved.
//

import Foundation

class item: Encodable,Decodable{
    var title: String = ""
    var done: Bool = false
}

