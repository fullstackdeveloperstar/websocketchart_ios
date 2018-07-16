//
//  ChartsTableViewController.swift
//  WebSocketChart
//
//  Created by developer on 7/15/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class ChartsTableViewController: UITableViewController {
    
    var workchartNo : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "segue_charts_addchart":
            let addChartVC = segue.destination as! AddChartViewController
            addChartVC.workChartNo = self.workchartNo
            break
        default:
            break
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GlobalObjs.globalObjs.workcharts[self.workchartNo].chartItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charts_cell", for: indexPath) as! ChartsTableViewCell

        // Configure the cell...
        
        cell.lb_chart_name.text = GlobalObjs.globalObjs.workcharts[self.workchartNo].chartItems[indexPath.row].name
        
        switch  GlobalObjs.globalObjs.workcharts[self.workchartNo].chartItems[indexPath.row].type{
        case .Line:
            cell.lb_chart_type.text = "Line"
            break
        case .Bar:
            cell.lb_chart_type.text = "Bar"
            break
        case .Bubble:
            cell.lb_chart_type.text = "Bubble"
            break
        case .Candle:
            cell.lb_chart_type.text = "Candle"
            break
        case .Pie:
            cell.lb_chart_type.text = "Pie"
            break
        case .Radar:
            cell.lb_chart_type.text = "Radar"
            break
        case .Scatter:
            cell.lb_chart_type.text = "Scatter"
            break
        default:
            break
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    @IBAction func addChart(_ sender: Any) {
        self.performSegue(withIdentifier: "segue_charts_addchart", sender: nil)
    }
}
