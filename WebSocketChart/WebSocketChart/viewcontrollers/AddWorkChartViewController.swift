//
//  AddWorkChartViewController.swift
//  WebSocketChart
//
//  Created by developer on 7/12/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class AddWorkChartViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tf_workchartname: UITextField!
    
    @IBOutlet weak var pk_workcharttype: UIPickerView!
    
    var chartTypes = ["Line Chart",
                      "Bar Chart",
                      "Pie Chart",
                      "Bubble Chart",
                      "Candle Chart",
                      "Scatter Chart",
                      "Radar Chart"]
    
    var isAdded = false
    var workChartNo : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked) )
        
        keyboardToolBar.setItems([flexibleSpace, doneButton], animated: true)
        self.tf_workchartname.inputAccessoryView = keyboardToolBar
        
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
        case "segue_addworkchart_charts":
            let chartsTVC = segue.destination as! ChartsTableViewController
            chartsTVC.workchartNo = self.workChartNo
            break
        default:
            break
        }
    }
 

    @IBAction func done(_ sender: Any) {
        let st_workchartname = self.tf_workchartname.text
        if(st_workchartname == "")
        {
            let alert = UIAlertController(title: "Warnning", message: "Please input the workchart name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        
        if(isAdded){
            self.navigationController?.popViewController(animated: true)
        }
        else{
            let workchart = Workchart()
            workchart.name = st_workchartname!
            GlobalObjs.globalObjs.workcharts.append(workchart)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func next(_ sender: Any) {
        let st_workchartname = self.tf_workchartname.text
        if(st_workchartname == "")
        {
            let alert = UIAlertController(title: "Warnning", message: "Please input the workchart name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        if(self.isAdded)
        {
            self.performSegue(withIdentifier: "segue_addworkchart_charts", sender: nil)
        }
        else {
            let workchart = Workchart()
            workchart.name = st_workchartname!
            switch self.pk_workcharttype.selectedRow(inComponent: 0){
            case 0:
                workchart.type = .Line
                break
            case 1:
                workchart.type = .Bar
                break
            case 2:
                workchart.type = .Pie
                break
            case 3:
                workchart.type = .Bubble
                break
            case 4:
                workchart.type = .Candle
                break
            case 5:
                workchart.type = .Scatter
                break
            case 6:
                workchart.type = .Radar
                break
            default:
                workchart.type = .Line
                break
                
            }
            GlobalObjs.globalObjs.workcharts.append(workchart)
            self.isAdded = true
            self.workChartNo = GlobalObjs.globalObjs.workcharts.count - 1
            self.performSegue(withIdentifier: "segue_addworkchart_charts", sender: nil)
        }
        
    }
    
    @objc func doneClicked()  {
        self.view.endEditing(true)
    }
    
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
