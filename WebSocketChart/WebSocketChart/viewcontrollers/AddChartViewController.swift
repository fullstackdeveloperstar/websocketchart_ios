//
//  AddChartViewController.swift
//  WebSocketChart
//
//  Created by developer on 7/16/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class AddChartViewController: UIViewController {

    var workChartNo : Int!
    var isAdded = false
    var chartItemNo : Int!
    
    @IBOutlet weak var tf_chartname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }
    
    
    
    @IBAction func next(_ sender: Any) {
        let st_chartname = self.tf_chartname.text
        if(st_chartname == "")
        {
            let alert = UIAlertController(title: "Warnning", message: "Please input the chart name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        if(self.isAdded){
            self.performSegue(withIdentifier: "segue_addchart_adddata", sender: nil)
        }
        else {
            let chartItem = ChartItem()
            chartItem.name = st_chartname!
            GlobalObjs.globalObjs.workcharts[self.workChartNo].chartItems.append(chartItem)
            self.isAdded = true
            self.chartItemNo = GlobalObjs.globalObjs.workcharts[self.workChartNo].chartItems.count - 1
            self.performSegue(withIdentifier: "segue_addchart_adddata", sender: nil)
        }
        
    }
    
    
}
