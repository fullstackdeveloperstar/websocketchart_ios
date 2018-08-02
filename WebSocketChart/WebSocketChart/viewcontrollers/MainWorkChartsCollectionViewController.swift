//
//  MainWorkChartsCollectionViewController.swift
//  WebSocketChart
//
//  Created by developer on 7/11/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainWorkChartsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var clickedWorkChart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let workchart1 = Workchart()
        workchart1.name = "WorkChart1"
        let chartItem1 = ChartItem()
        chartItem1.name = "Chart Item 1"
        chartItem1.type = .Line
        chartItem1.mainsubType = .Main
        workchart1.chartItems.append(chartItem1)
        
        let chartItem2 = ChartItem()
        chartItem2.name = "Chart Item 2"
        chartItem2.type = .Bar
        chartItem2.mainsubType = .Sub
        
        workchart1.chartItems.append(chartItem2)
        
        
        let chartItem3 = ChartItem()
        chartItem3.name = "Chart Item3"
        chartItem3.type = .Candle
        chartItem3.mainsubType = .Sub
        workchart1.chartItems.append(chartItem3)
        
    
        
        let workchart2 = Workchart()
        workchart2.name = "WorkChart2"
        let chartItem2_1 = ChartItem()
        chartItem2_1.name = "Chart Item 1"
        chartItem2_1.type = .Line
        chartItem2_1.mainsubType = .Sub
        chartItem2_1.isMaxLine = true
        chartItem2_1.maxLineText = "Sell Position"
        chartItem2_1.isMinLine = true
        chartItem2_1.minLineText = "Buy Position"
        chartItem2_1.maxLineLabelPosition = .rightTop
        chartItem2_1.minLineLabelPosition = .rightBottom
        
        let chartItem2_2 = ChartItem()
        chartItem2_2.name = "Chart Item 1"
        chartItem2_2.type = .Line
        chartItem2_2.mainsubType = .Sub
        chartItem2_2.isMaxLine = true
        chartItem2_2.maxLineText = "sms, email, IVR"
        chartItem2_2.isMinLine = true
        chartItem2_2.minLineText = "sms, email, IVR"
        chartItem2_2.maxLineLabelPosition = .leftTop
        chartItem2_2.minLineLabelPosition = .leftBottom
        
        workchart2.chartItems.append(chartItem2_1)
        workchart2.chartItems.append(chartItem2_2)
        
        let workchart3 = Workchart()
        workchart3.name = "WorkChart3"
        let chartItem3_1 = ChartItem()
        chartItem3_1.name = "Chart Item 3-1"
        chartItem3_1.type = .Bar
        chartItem3_1.mainsubType = .Sub
        workchart3.chartItems.append(chartItem3_1)
        
        let workchart4 = Workchart()
        workchart4.name = "WorkChart4"
        let chartItem4_1 = ChartItem()
        chartItem4_1.name = "Chart Item 4-1"
        chartItem4_1.type = .Pie
        chartItem4_1.mainsubType = .Sub
        workchart4.chartItems.append(chartItem4_1)
        
        let workchart5 = Workchart()
        workchart5.name = "WorkChart5"
        let chartItem5_1 = ChartItem()
        chartItem5_1.name = "Chart Item 5-1"
        chartItem5_1.type = .Candle
        chartItem5_1.mainsubType = .Sub
        workchart5.chartItems.append(chartItem5_1)
        
        let workchart6 = Workchart()
        workchart6.name = "WorkChart6"
        let chartItem6_1 = ChartItem()
        chartItem6_1.name = "Chart Item 6-1"
        chartItem6_1.type = .Scatter
        chartItem6_1.mainsubType = .Sub
        workchart6.chartItems.append(chartItem6_1)
        
        let workchart7 = Workchart()
        workchart7.name = "WorkChart7"
        let chartItem7_1 = ChartItem()
        chartItem7_1.name = "Chart Item 7-1"
        chartItem7_1.type = .Bubble
        chartItem7_1.mainsubType = .Sub
        workchart7.chartItems.append(chartItem7_1)
        
        GlobalObjs.globalObjs.workcharts.append(workchart1)
        GlobalObjs.globalObjs.workcharts.append(workchart2)
        GlobalObjs.globalObjs.workcharts.append(workchart3)
        GlobalObjs.globalObjs.workcharts.append(workchart4)
        GlobalObjs.globalObjs.workcharts.append(workchart5)
        GlobalObjs.globalObjs.workcharts.append(workchart6)
        GlobalObjs.globalObjs.workcharts.append(workchart7)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "sg_main_workchart":
            let workChartVC = segue.destination as! WorkChartTableViewController
            workChartVC.workchartIndex = self.clickedWorkChart
            break
        default:
            break
        }
     }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return GlobalObjs.globalObjs.workcharts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workchart_cell", for: indexPath)as! WorkChartCollectionViewCell
    
        // Configure the cell
        cell.lb_name.text = GlobalObjs.globalObjs.workcharts[indexPath.row].name
        if( GlobalObjs.globalObjs.workcharts[indexPath.row].chartItems.count == 0){
            cell.img_preview.image = #imageLiteral(resourceName: "s_mainchart")
        } else {
            if(GlobalObjs.globalObjs.workcharts[indexPath.row].chartItems[0].mainsubType == .Main){
                cell.img_preview.image = #imageLiteral(resourceName: "s_mainchart")
            } else {
                GlobalObjs.globalObjs.workcharts[indexPath.row].type = GlobalObjs.globalObjs.workcharts[indexPath.row].chartItems[0].type
                switch GlobalObjs.globalObjs.workcharts[indexPath.row].type {
                    case WorkChartTypeEnum.Line:
                        cell.img_preview.image = #imageLiteral(resourceName: "s_linechart")
                        break
                    case WorkChartTypeEnum.Bar:
                        cell.img_preview.image = #imageLiteral(resourceName: "s_barchart")
                        break
                    case WorkChartTypeEnum.Bubble:
                        cell.img_preview.image = #imageLiteral(resourceName: "s_bubble")
                        break
                    case WorkChartTypeEnum.Candle:
                        cell.img_preview.image = #imageLiteral(resourceName: "s_candlestickchart")
                        break
                    case WorkChartTypeEnum.Pie:
                        cell.img_preview.image = #imageLiteral(resourceName: "s_piechart")
                        break
                    case WorkChartTypeEnum.Radar:
                        cell.img_preview.image = #imageLiteral(resourceName: "s_radarchart")
                        break
                    case WorkChartTypeEnum.Scatter:
                        cell.img_preview.image = #imageLiteral(resourceName: "s_scatterchart")
                        break
                    default:
                        cell.img_preview.image = #imageLiteral(resourceName: "s_linechart")
                        break
                }
            }
        }
       
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          self.clickedWorkChart = indexPath.row
          self.performSegue(withIdentifier: "sg_main_workchart", sender: nil)
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 150, height: 170)
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}
