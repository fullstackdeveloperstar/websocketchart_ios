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

}
