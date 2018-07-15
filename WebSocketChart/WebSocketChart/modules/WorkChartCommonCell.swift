//
//  WorkChartCommonCell.swift
//  WebSocketChart
//
//  Created by developer on 7/13/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import Charts

class WorkChartCommonCell: NSObject , ChartViewDelegate{

    var linchart : LineChartView!
    var barchart : BarChartView!
    
    var workChartNo : Int!
    
    var parentVC : WorkChartTableViewController!
    
    var parentTVCC : WorkChartTableViewCell!
    
    func initChartView()  {
        switch GlobalObjs.globalObjs.workcharts[self.workChartNo].type {
        case .Line:
            self.initLineChartView()
            break
        default:
            break
        }
    }
    
    func initLineChartView(){
        self.linchart = LineChartView()
        self.linchart.delegate = self
        self.linchart.chartDescription?.enabled = false
        self.linchart.dragEnabled = true
        self.linchart.setScaleEnabled(true)
        self.linchart.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        self.linchart.xAxis.gridLineDashLengths = [10, 10]
        self.linchart.xAxis.gridLineDashPhase = 0
        
        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .rightBottom
        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = self.linchart.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 200
        leftAxis.axisMinimum = -50
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        self.linchart.rightAxis.enabled = false
        
        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
        
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = self.linchart
        marker.minimumSize = CGSize(width: 80, height: 40)
        self.linchart.marker = marker
        
        self.linchart.legend.form = .line
        self.linchart.animate(xAxisDuration: 2.5)
        self.seLineCharttDataCount(30, range: 30)
        
        self.linchart.translatesAutoresizingMaskIntoConstraints = false
        
        self.parentTVCC.chartView.addSubview(self.linchart)
        
        self.linchart.topAnchor.constraint(equalTo: self.parentTVCC.topAnchor).isActive = true
        self.linchart.leftAnchor.constraint(equalTo: self.parentTVCC.leftAnchor).isActive = true
        self.linchart.rightAnchor.constraint(equalTo: self.parentTVCC.rightAnchor).isActive = true
        self.linchart.bottomAnchor.constraint(equalTo: self.parentTVCC.bottomAnchor).isActive = true
    }
    
    
    func seLineCharttDataCount(_ count: Int, range: UInt32) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "star"))
        }

        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
        set1.drawIconsEnabled = false
        
        set1.lineDashLengths = [5, 2.5]
        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
        set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 1
        set1.formSize = 15
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        self.linchart.data = data
    }
    
    
  
}
