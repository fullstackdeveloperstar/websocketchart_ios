//
//  AddDataViewController.swift
//  WebSocketChart
//
//  Created by developer on 7/20/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class AddDataViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var pk_charttype: UIPickerView!
    @IBOutlet weak var sg_typeofdata: UISegmentedControl!
    
    var workChartNo : Int!
    
    var chartItemNo : Int!
    
    var chartItem : ChartItem!
    
    var chartTypes = ["Line Chart",
                      "Bar Chart",
                      "Pie Chart",
                      "Bubble Chart",
                      "Candle Chart",
                      "Scatter Chart",
                      "Radar Chart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.chartItem = GlobalObjs.globalObjs.workcharts[self.workChartNo].chartItems[self.chartItemNo]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func  numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.chartTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.chartTypes[row]
    }

    @IBAction func next(_ sender: Any) {
        switch self.pk_charttype.selectedRow(inComponent: 0) {
        case 0:
            self.chartItem.type = .Line
            break
        case 1:
            self.chartItem.type = .Bar
            break
        case 2:
            self.chartItem.type = .Pie
            break
        case 3:
            self.chartItem.type = .Bubble
            break
        case 4:
            self.chartItem.type = .Candle
            break
        case 5:
            self.chartItem.type = .Scatter
            break
        case 6:
            self.chartItem.type = .Radar
            break
        default:
            self.chartItem.type = .Line
            break
        }
        
        self.performSegue(withIdentifier: "segue_adddata_details", sender: nil)
    }
    
}
