//
//  WorkChartCommonCell.swift
//  WebSocketChart
//
//  Created by developer on 7/13/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import Charts

private let ITEM_COUNT = 12

class WorkChartCommonCell: NSObject , ChartViewDelegate{

    var linchart : LineChartView!
    var barchart : BarChartView!
    var candlechart : CandleStickChartView!
    var piechart : PieChartView!
    var scatterchart : ScatterChartView!
    var bubblechart : BubbleChartView!
    var combinedchart : CombinedChartView!
    
    var workChartNo : Int!
    var chartItemNo : Int!
    
    var parentVC : WorkChartTableViewController!
    
    var parentTVCC : WorkChartTableViewCell!
    
    var chartItem : ChartItem!
    
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    
    func initChartView()  {
        self.chartItem = GlobalObjs.globalObjs.workcharts[self.workChartNo].chartItems[self.chartItemNo]
        
        if(self.chartItem.mainsubType == .Main){
            self.initCombineChart()
        }
        else{
        
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
            case .Pie:
                self.initPieChart()
                break
            case .Scatter:
                self.initScatter()
                break
            case .Bubble:
                self.initBubbleChart()
                break
            default:
                break
            }
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
        ll1.labelPosition = self.chartItem.maxLineLabelPosition
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: 30, label: self.chartItem.minLineText)
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = self.chartItem.minLineLabelPosition
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
        
        self.linchart.legend.form = .circle
        self.linchart.legend.horizontalAlignment = .center
        self.linchart.legend.verticalAlignment = .top
        
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

        let set1 = LineChartDataSet(values: values, label: "Buy Pos")
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
        
        
        let values2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(20) + 120)
            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "star"))
        }
        
        let set2 = LineChartDataSet(values: values2, label: "Sell Pos")
        set2.drawIconsEnabled = false
        
        set2.lineDashLengths = [5, 2.5]
        set2.highlightLineDashLengths = [5, 2.5]
        set2.setColor(.green)
        set2.setCircleColor(.green)
        set2.lineWidth = 1
        set2.circleRadius = 3
        set2.drawCircleHoleEnabled = false
        set2.valueFont = .systemFont(ofSize: 9)
        set2.formLineDashLengths = [5, 2.5]
        set2.formLineWidth = 1
        set2.formSize = 15
        
       
       
        let data = LineChartData(dataSets: [set1, set2])
        
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
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
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
        self.barchart.animate(xAxisDuration: 2.5)
        
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
            set1 = BarChartDataSet(values: yVals, label: "Bar Chart Data")
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
        
        self.candlechart.animate(xAxisDuration: 2.5)
        
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
    
    func initPieChart()  {
        self.piechart = PieChartView()
        self.piechart.delegate = self
        
        let l = self.piechart.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        self.piechart.setExtraOffsets(left: 20, top: 0, right: 20, bottom: 0)
        
        self.piechart.animate(xAxisDuration: 2.5, easingOption: .easeOutBack)
        
        self.piechart.translatesAutoresizingMaskIntoConstraints = false
        
        self.parentTVCC.chartView.addSubview(self.piechart)
        
        self.piechart.topAnchor.constraint(equalTo: self.parentTVCC.topAnchor).isActive = true
        self.piechart.leftAnchor.constraint(equalTo: self.parentTVCC.leftAnchor).isActive = true
        self.piechart.rightAnchor.constraint(equalTo: self.parentTVCC.rightAnchor).isActive = true
        self.piechart.bottomAnchor.constraint(equalTo: self.parentTVCC.bottomAnchor).isActive = true
        
        self.setPieDataCount(7, range: 50)
    }
    
    func setPieDataCount(_ count: Int, range: UInt32) {
        let parties = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F",
                       "Party G", "Party H", "Party I", "Party J", "Party K", "Party L",
                       "Party M", "Party N", "Party O", "Party P", "Party Q", "Party R",
                       "Party S", "Party T", "Party U", "Party V", "Party W", "Party X",
                       "Party Y", "Party Z"]
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count])
        }
        
        let set = PieChartDataSet(values: entries, label: "Election Results")
        set.sliceSpace = 2
        
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        set.valueLinePart1OffsetPercentage = 0.8
        set.valueLinePart1Length = 0.2
        set.valueLinePart2Length = 0.4
        //set.xValuePosition = .outsideSlice
        set.yValuePosition = .outsideSlice
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        self.piechart.data = data
        self.piechart.highlightValues(nil)
    }
    
    func initScatter()  {
        self.scatterchart = ScatterChartView()
        
        self.scatterchart.delegate = self
        
        self.scatterchart.chartDescription?.enabled = false
        
        self.scatterchart.dragEnabled = true
        self.scatterchart.setScaleEnabled(true)
        self.scatterchart.maxVisibleCount = 200
        self.scatterchart.pinchZoomEnabled = true
        
        let l = self.scatterchart.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xOffset = 5
        
        let leftAxis = self.scatterchart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.axisMinimum = 0
        
        self.scatterchart.rightAxis.enabled = false
        
        
        let xAxis = self.scatterchart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        
        self.scatterchart.animate(yAxisDuration: 2.5)
        
        self.scatterchart.translatesAutoresizingMaskIntoConstraints = false
        
        self.parentTVCC.chartView.addSubview(self.scatterchart)
        
        self.scatterchart.topAnchor.constraint(equalTo: self.parentTVCC.topAnchor).isActive = true
        self.scatterchart.leftAnchor.constraint(equalTo: self.parentTVCC.leftAnchor).isActive = true
        self.scatterchart.rightAnchor.constraint(equalTo: self.parentTVCC.rightAnchor).isActive = true
        self.scatterchart.bottomAnchor.constraint(equalTo: self.parentTVCC.bottomAnchor).isActive = true
        
        self.setScatterChartDataCount(30, range: 50)
    }
    
    func setScatterChartDataCount(_ count: Int, range: UInt32) {
        let values1 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let values2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i) + 0.33, y: val)
        }
        let values3 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i) + 0.66, y: val)
        }
        
        
        let set1 = ScatterChartDataSet(values: values1, label: "DS 1")
        set1.setScatterShape(.square)
        set1.setColor(ChartColorTemplates.colorful()[0])
        set1.scatterShapeSize = 8
        
        let set2 = ScatterChartDataSet(values: values2, label: "DS 2")
        set2.setScatterShape(.circle)
        set2.scatterShapeHoleColor = ChartColorTemplates.colorful()[3]
        set2.scatterShapeHoleRadius = 3.5
        set2.setColor(ChartColorTemplates.colorful()[1])
        set2.scatterShapeSize = 8
        
        let set3 = ScatterChartDataSet(values: values3, label: "DS 3")
        set3.setScatterShape(.cross)
        set3.setColor(ChartColorTemplates.colorful()[2])
        set3.scatterShapeSize = 8
        
        let data = ScatterChartData(dataSets: [set1, set2, set3])
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        
        self.scatterchart.data = data
    }
    
    func initBubbleChart() {
        self.bubblechart = BubbleChartView()
        self.bubblechart.delegate = self
        
        self.bubblechart.chartDescription?.enabled = false
        
        self.bubblechart.dragEnabled = true
        self.bubblechart.setScaleEnabled(true)
        self.bubblechart.maxVisibleCount = 200
        self.bubblechart.pinchZoomEnabled = true
        
        self.bubblechart.legend.horizontalAlignment = .center
        self.bubblechart.legend.verticalAlignment = .top
        self.bubblechart.legend.orientation = .horizontal
        self.bubblechart.legend.drawInside = false
        self.bubblechart.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        self.bubblechart.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        self.bubblechart.leftAxis.spaceTop = 0.3
        self.bubblechart.leftAxis.spaceBottom = 0.3
        self.bubblechart.leftAxis.axisMinimum = 0
        
        self.bubblechart.rightAxis.enabled = false
        
        self.bubblechart.xAxis.labelPosition = .bottom
        self.bubblechart.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        self.bubblechart.animate(yAxisDuration: 2.5)
        
        
        self.bubblechart.translatesAutoresizingMaskIntoConstraints = false
        
        self.parentTVCC.chartView.addSubview(self.bubblechart)
        
        self.bubblechart.topAnchor.constraint(equalTo: self.parentTVCC.topAnchor).isActive = true
        self.bubblechart.leftAnchor.constraint(equalTo: self.parentTVCC.leftAnchor).isActive = true
        self.bubblechart.rightAnchor.constraint(equalTo: self.parentTVCC.rightAnchor).isActive = true
        self.bubblechart.bottomAnchor.constraint(equalTo: self.parentTVCC.bottomAnchor).isActive = true
        
        self.setBubbleChartDataCount(30, range: 50)
        
    }
    
    func setBubbleChartDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(range))
            let size = CGFloat(arc4random_uniform(range))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size, icon: #imageLiteral(resourceName: "star"))
        }
        let yVals2 = (0..<count).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(range))
            let size = CGFloat(arc4random_uniform(range))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size, icon: #imageLiteral(resourceName: "star"))
        }
        let yVals3 = (0..<count).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(range))
            let size = CGFloat(arc4random_uniform(range))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size)
        }
        
        let set1 = BubbleChartDataSet(values: yVals1, label: "DS 1")
        set1.drawIconsEnabled = false
        set1.setColor(ChartColorTemplates.colorful()[0], alpha: 0.5)
        set1.drawValuesEnabled = true
        
        let set2 = BubbleChartDataSet(values: yVals2, label: "DS 2")
        set2.drawIconsEnabled = false
        set2.iconsOffset = CGPoint(x: 0, y: 15)
        set2.setColor(ChartColorTemplates.colorful()[1], alpha: 0.5)
        set2.drawValuesEnabled = true
        
        let set3 = BubbleChartDataSet(values: yVals3, label: "DS 3")
        set3.setColor(ChartColorTemplates.colorful()[2], alpha: 0.5)
        set3.drawValuesEnabled = true
        
        let data = BubbleChartData(dataSets: [set1, set2, set3])
        data.setDrawValues(false)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 7)!)
        data.setHighlightCircleWidth(1.5)
        data.setValueTextColor(.white)
        
        self.bubblechart.data = data
    }
    
    func initCombineChart()  {
        
        self.combinedchart = CombinedChartView()
        
        self.combinedchart.delegate = self
        
        self.combinedchart.chartDescription?.enabled = false
        
        self.combinedchart.drawBarShadowEnabled = false
        self.combinedchart.highlightFullBarEnabled = false
        
        
        self.combinedchart.drawOrder = [DrawOrder.bar.rawValue,
                               DrawOrder.bubble.rawValue,
                               DrawOrder.candle.rawValue,
                               DrawOrder.line.rawValue,
                               DrawOrder.scatter.rawValue]
        
        let l = self.combinedchart.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        //        chartView.legend = l
        
        let rightAxis = self.combinedchart.rightAxis
        rightAxis.axisMinimum = 0
        
        let leftAxis = self.combinedchart.leftAxis
        leftAxis.axisMinimum = 0
        
        let xAxis = self.combinedchart.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        
        self.setCombineChartData()
        
        self.combinedchart.translatesAutoresizingMaskIntoConstraints = false
        
        self.parentTVCC.chartView.addSubview(self.combinedchart)
        
        self.combinedchart.topAnchor.constraint(equalTo: self.parentTVCC.topAnchor).isActive = true
        self.combinedchart.leftAnchor.constraint(equalTo: self.parentTVCC.leftAnchor).isActive = true
        self.combinedchart.rightAnchor.constraint(equalTo: self.parentTVCC.rightAnchor).isActive = true
        self.combinedchart.bottomAnchor.constraint(equalTo: self.parentTVCC.bottomAnchor).isActive = true
        
        
        
        
    }
    
    func setCombineChartData() {
        let data = CombinedChartData()
        data.lineData = generateLineData()
        data.barData = generateBarData()
        data.bubbleData = generateBubbleData()
        data.scatterData = generateScatterData()
        data.candleData = generateCandleData()
        
        self.combinedchart.xAxis.axisMaximum = data.xMax + 0.25
        
        self.combinedchart.data = data
    }
    
    func generateLineData() -> LineChartData {
        let entries = (0..<ITEM_COUNT).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i) + 0.5, y: Double(arc4random_uniform(15) + 5))
        }
        
        let set = LineChartDataSet(values: entries, label: "Line DataSet")
        set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.lineWidth = 2.5
        set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        
        set.axisDependency = .left
        
        return LineChartData(dataSet: set)
    }
    
    func generateBarData() -> BarChartData {
        let entries1 = (0..<ITEM_COUNT).map { _ -> BarChartDataEntry in
            return BarChartDataEntry(x: 0, y: Double(arc4random_uniform(25) + 25))
        }
        let entries2 = (0..<ITEM_COUNT).map { _ -> BarChartDataEntry in
            return BarChartDataEntry(x: 0, yValues: [Double(arc4random_uniform(13) + 12), Double(arc4random_uniform(13) + 12)])
        }
        
        let set1 = BarChartDataSet(values: entries1, label: "Bar 1")
        set1.setColor(UIColor(red: 60/255, green: 220/255, blue: 78/255, alpha: 1))
        set1.valueTextColor = UIColor(red: 60/255, green: 220/255, blue: 78/255, alpha: 1)
        set1.valueFont = .systemFont(ofSize: 10)
        set1.axisDependency = .left
        
        let set2 = BarChartDataSet(values: entries2, label: "")
        set2.stackLabels = ["Stack 1", "Stack 2"]
        set2.colors = [UIColor(red: 61/255, green: 165/255, blue: 255/255, alpha: 1),
                       UIColor(red: 23/255, green: 197/255, blue: 255/255, alpha: 1)
        ]
        set2.valueTextColor = UIColor(red: 61/255, green: 165/255, blue: 255/255, alpha: 1)
        set2.valueFont = .systemFont(ofSize: 10)
        set2.axisDependency = .left
        
        let groupSpace = 0.06
        let barSpace = 0.02 // x2 dataset
        let barWidth = 0.45 // x2 dataset
        // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
        
        let data = BarChartData(dataSets: [set1, set2])
        data.barWidth = barWidth
        
        // make this BarData object grouped
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        
        return data
    }
    
    func generateScatterData() -> ScatterChartData {
        let entries = stride(from: 0.0, to: Double(ITEM_COUNT), by: 0.5).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: i+0.25, y: Double(arc4random_uniform(10) + 55))
        }
        
        let set = ScatterChartDataSet(values: entries, label: "Scatter DataSet")
        set.colors = ChartColorTemplates.material()
        set.scatterShapeSize = 4.5
        set.drawValuesEnabled = false
        set.valueFont = .systemFont(ofSize: 10)
        
        return ScatterChartData(dataSet: set)
    }
    
    func generateCandleData() -> CandleChartData {
        let entries = stride(from: 0, to: ITEM_COUNT, by: 2).map { (i) -> CandleChartDataEntry in
            return CandleChartDataEntry(x: Double(i+1), shadowH: 90, shadowL: 70, open: 85, close: 75)
        }
        
        let set = CandleChartDataSet(values: entries, label: "Candle DataSet")
        set.setColor(UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1))
        set.decreasingColor = UIColor(red: 142/255, green: 150/255, blue: 175/255, alpha: 1)
        set.shadowColor = .darkGray
        set.valueFont = .systemFont(ofSize: 10)
        set.drawValuesEnabled = false
        
        return CandleChartData(dataSet: set)
    }
    
    func generateBubbleData() -> BubbleChartData {
        let entries = (0..<ITEM_COUNT).map { (i) -> BubbleChartDataEntry in
            return BubbleChartDataEntry(x: Double(i) + 0.5,
                                        y: Double(arc4random_uniform(10) + 105),
                                        size: CGFloat(arc4random_uniform(50) + 105))
        }
        
        let set = BubbleChartDataSet(values: entries, label: "Bubble DataSet")
        set.setColors(ChartColorTemplates.vordiplom(), alpha: 1)
        set.valueTextColor = .white
        set.valueFont = .systemFont(ofSize: 10)
        set.drawValuesEnabled = true
        
        return BubbleChartData(dataSet: set)
    }
}
    
  
extension WorkChartCommonCell: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value) % months.count]
    }
}

