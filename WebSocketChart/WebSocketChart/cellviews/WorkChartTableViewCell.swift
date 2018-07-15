//
//  WorkChartTableViewCell.swift
//  WebSocketChart
//
//  Created by developer on 7/13/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import Charts

class WorkChartTableViewCell: UITableViewCell {

    @IBOutlet weak var chartView: UIView!
   
    var workChartCommonCell : WorkChartCommonCell!
    
    var workchartNo : Int!
    
    var parentTableViewController : WorkChartTableViewController!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initChartView()  {
        self.workChartCommonCell = WorkChartCommonCell()
        self.workChartCommonCell.workChartNo = self.workchartNo
        self.workChartCommonCell.parentVC = self.parentTableViewController
        self.workChartCommonCell.parentTVCC = self
        self.workChartCommonCell.initChartView()
    }
}
