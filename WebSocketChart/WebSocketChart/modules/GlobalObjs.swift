//
//  GlobalObjs.swift
//  WebSocketChart
//
//  Created by developer on 7/11/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

final class GlobalObjs: NSObject {
    
    static let globalObjs = GlobalObjs()
    var workcharts = [Workchart]()
    
    override init() {
        
    }
}

