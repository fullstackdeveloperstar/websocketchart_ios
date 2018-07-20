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
    var candlechart : CandleStickChartView!
    
    var workChartNo : Int!
    var chartItemNo : Int!
    
    var parentVC : WorkChartTableViewController!
    
    var parentTVCC : WorkChartTableViewCell!
    
    var chartItem : ChartItem!
    
    func initChartView()  {
        self.chartItem = GlobalObjs.globalObjs.workcharts[self.workChartNo].chartItems[self.chartItemNo]
        
        switch self.chartItem.type {
        case .Line:
            self.initLineChartView()
            break
        case .Bar:
            self.initBarChart()
            break
        case .Candle:
            self.initCandleChart()
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
        
        
        
        let ll1 = ChartLimitLine(limit: 150, label: self.chartItem.maxLineText)
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .leftTop
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: -30, label: self.chartItem.minLineText)
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .leftBottom
        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = self.linchart.leftAxis
        leftAxis.removeAllLimitLines()
        
        if(self.chartItem.isMaxLine){
            leftAxis.addLimitLine(ll1)
        }
        if(self.chartItem.isMinLine){
             leftAxis.addLimitLine(ll2)
        }
       
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
    
    func initBarChart() {
        self.barchart = BarChartView()
        self.barchart.delegate = self
        
        self.barchart.drawBarShadowEnabled = false
        self.barchart.drawValueAboveBarEnabled = false
        
        self.barchart.maxVisibleCount = 60
        
        let xAxis = self.barchart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = DayAxisValueFormatter(chart: self.barchart)
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " $"
        leftAxisFormatter.positiveSuffix = " $"
        
        let leftAxis = self.barchart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        
        let rightAxis = self.barchart.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.labelCount = 8
        rightAxis.valueFormatter = leftAxis.valueFormatter
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0
        
        let l = self.barchart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        //        chartView.legend = l
        
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: self.barchart.xAxis.valueFormatter!)
        marker.chartView = self.barchart
        marker.minimumSize = CGSize(width: 80, height: 40)
        self.barchart.marker = marker
        self.setBarChartDataCount(50, range: 50)
        
        self.barchart.translatesAutoresizingMaskIntoConstraints = false
        
        self.parentTVCC.chartView.addSubview(self.barchart)
        
        self.barchart.topAnchor.constraint(equalTo: self.parentTVCC.topAnchor).isActive = true
        self.barchart.leftAnchor.constraint(equalTo: self.parentTVCC.leftAnchor).isActive = true
        self.barchart.rightAnchor.constraint(equalTo: self.parentTVCC.rightAnchor).isActive = true
        self.barchart.bottomAnchor.constraint(equalTo: self.parentTVCC.bottomAnchor).isActive = true
        
    }
    
    func setBarChartDataCount(_ count: Int, range: UInt32) {
        let start = 1
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            if arc4random_uniform(100) < 25 {
                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
            } else {
                return BarChartDataEntry(x: Double(i), y: val)
            }
        }
        
        var set1: BarChartDataSet! = nil
        if let set = self.barchart.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1.values = yVals
            self.barchart.data?.notifyDataChanged()
            self.barchart.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(values: yVals, label: "The year 2017")
            set1.colors = ChartColorTemplates.material()
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
            self.barchart.data = data
        }
    }
    
    func initCandleChart()  {
        self.candlechart = CandleStickChartView()
        self.candlechart.delegate = self
        
        self.candlechart.chartDescription?.enabled = false
        
        self.candlechart.dragEnabled = false
        self.candlechart.setScaleEnabled(true)
        self.candlechart.maxVisibleCount = 200
        self.candlechart.pinchZoomEnabled = true
        
        self.candlechart.legend.horizontalAlignment = .center
        self.candlechart.legend.verticalAlignment = .top
        self.candlechart.legend.orientation = .vertical
        self.candlechart.legend.drawInside = false
        self.candlechart.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        self.candlechart.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        self.candlechart.leftAxis.spaceTop = 0.3
        self.candlechart.leftAxis.spaceBottom = 0.3
        self.candlechart.leftAxis.axisMinimum = 0
        
        self.candlechart.rightAxis.enabled = false
        
        self.candlechart.xAxis.labelPosition = .bottom
        self.candlechart.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        self.setCandleChartDataCount(50, range: 50)
        
        self.candlechart.translatesAutoresizingMaskIntoConstraints = false
        
        self.parentTVCC.chartView.addSubview(self.candlechart)
        
        self.candlechart.topAnchor.constraint(equalTo: self.parentTVCC.topAnchor).isActive = true
        self.candlechart.leftAnchor.constraint(equalTo: self.parentTVCC.leftAnchor).isActive = true
        self.candlechart.rightAnchor.constraint(equalTo: self.parentTVCC.rightAnchor).isActive = true
        self.candlechart.bottomAnchor.constraint(equalTo: self.parentTVCC.bottomAnchor).isActive = true
        
    }
    
    func setCandleChartDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> CandleChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(40) + mult)
            let high = Double(arc4random_uniform(9) + 8)
            let low = Double(arc4random_uniform(9) + 8)
            let open = Double(arc4random_uniform(6) + 1)
            let close = Double(arc4random_uniform(6) + 1)
            let even = i % 2 == 0
            
            return CandleChartDataEntry(x: Double(i), shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close, icon: #imageLiteral(resourceName: "star"))
        }
        
        let set1 = CandleChartDataSet(values: yVals1, label: "Data Set")
        set1.axisDependency = .left
        set1.setColor(UIColor(white: 80/255, alpha: 1))
        set1.drawIconsEnabled = false
        set1.shadowColor = .darkGray
        set1.shadowWidth = 0.7
        set1.decreasingColor = .red
        set1.decreasingFilled = true
        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
        set1.increasingFilled = false
        set1.neutralColor = .blue
        
        let data = CandleChartData(dataSet: set1)
        self.candlechart.data = data
    }
  
}
