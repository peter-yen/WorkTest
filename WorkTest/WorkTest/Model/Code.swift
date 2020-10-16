//
//  Code.swift
//  WorkTest
//
//  Created by 嚴啟睿 on 2020/10/15.
//

import Foundation

class Code {
    var code: String
    var name: String
    
    init(dict: [String: Any]) {
        self.code = dict["stockcode"] as! String
        self.name = dict["stockname"] as! String
    }
}

