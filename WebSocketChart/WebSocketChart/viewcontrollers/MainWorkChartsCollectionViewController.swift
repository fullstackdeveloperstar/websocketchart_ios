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
        
        let workchart2 = Workchart()
        workchart2.name = "WorkChart2"
        workchart2.type = WorkChartTypeEnum.Bar
        let workchart3 = Workchart()
        workchart3.name = "WorkChart3"
        workchart3.type = WorkChartTypeEnum.Bubble
        GlobalObjs.globalObjs.workcharts.append(workchart1)
        GlobalObjs.globalObjs.workcharts.append(workchart2)
        GlobalObjs.globalObjs.workcharts.append(workchart3)
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
