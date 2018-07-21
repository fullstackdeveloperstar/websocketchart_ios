//
//  ChartItem.swift
//  WebSocketChart
//
//  Created by developer on 7/15/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import Charts

class ChartItem: NSObject {
    var name = ""
    var type = WorkChartTypeEnum.Line
    var mainsubType = ChartItemMainSub.Main
    
    
    var isMaxLine = false
    var maxLineText = ""
    var isMinLine = false
    var minLineText = ""
    var maxLineLabelPosition = ChartLimitLine.LabelPosition.leftTop
    var minLineLabelPosition = ChartLimitLine.LabelPosition.leftBottom
    
}

