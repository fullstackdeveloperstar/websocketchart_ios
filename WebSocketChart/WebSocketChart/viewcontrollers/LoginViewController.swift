//
//  ViewController.swift
//  WebSocketChart
//
//  Created by developer on 7/10/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tf_username: UITextField!
  
    @IBOutlet weak var tf_pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked) )
        
        keyboardToolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        self.tf_username.inputAccessoryView = keyboardToolBar
        self.tf_pass.inputAccessoryView = keyboardToolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @objc func doneClicked()  {
        self.view.endEditing(true)
    }
}

