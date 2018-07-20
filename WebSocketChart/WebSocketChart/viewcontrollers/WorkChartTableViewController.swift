//
//  WorkChartTableViewController.swift
//  WebSocketChart
//
//  Created by developer on 7/13/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class WorkChartTableViewController: UITableViewController {

    @IBOutlet weak var workchart_nav_title: UINavigationItem!
    var isLoadedArray : [Bool] = []
    
    var workchartIndex = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.workchart_nav_title.title = GlobalObjs.globalObjs.workcharts[self.workchartIndex].name
        
        for index in GlobalObjs.globalObjs.workcharts[self.workchartIndex].chartItems{
            self.isLoadedArray.append(false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "segue_workcharttvc_chartstvc":
            let addChartVC = segue.destination as! ChartsTableViewController
            addChartVC.workchartNo = self.workchartIndex
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
        return GlobalObjs.globalObjs.workcharts[self.workchartIndex].chartItems.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workchart_cell", for: indexPath) as! WorkChartTableViewCell

        // Configure the cell...
        cell.workchartNo = self.workchartIndex
        cell.chartItemNo = indexPath.row
        cell.parentTableViewController = self
        if(!self.isLoadedArray[indexPath.row])
        {
            cell.initChartView()
            self.isLoadedArray[indexPath.row] = true
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

    
    @IBAction func addchart(_ sender: Any) {
        self.performSegue(withIdentifier: "segue_workcharttvc_chartstvc", sender: nil)
    }
}
