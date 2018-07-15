//
//  Workchart.swift
//  WebSocketChart
//
//  Created by developer on 7/11/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

enum WorkChartTypeEnum {
    case Line
    case Bar
    case Pie
    case Bubble
    case Candle
    case Scatter
    case Radar
}

class Workchart: NSObject {
   var name = ""
   var type = WorkChartTypeEnum.Line
   var chartItems = [ChartItem]()
}
