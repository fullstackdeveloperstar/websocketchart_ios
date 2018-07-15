//
//  AddWorkChartViewController.swift
//  WebSocketChart
//
//  Created by developer on 7/12/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class AddWorkChartViewController: UIViewController {

    @IBOutlet weak var tf_workchartname: UITextField!
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func done(_ sender: Any) {
        let st_workchartname = self.tf_workchartname.text
        if(st_workchartname == "")
        {
            let alert = UIAlertController(title: "Warnning", message: "Please input the workchart name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let workchart = Workchart()
        workchart.name = st_workchartname!
        GlobalObjs.globalObjs.workcharts.append(workchart)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func next(_ sender: Any) {
        self.performSegue(withIdentifier: "segue_addworkchart_charts", sender: nil)
    }
    
    @objc func doneClicked()  {
        self.view.endEditing(true)
    }
    
    
}
