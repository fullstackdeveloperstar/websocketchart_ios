//
//  ChartsTableViewCell.swift
//  WebSocketChart
//
//  Created by developer on 7/15/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class ChartsTableViewCell: UITableViewCell {

    @IBOutlet weak var lb_chart_name: UILabel!
    @IBOutlet weak var lb_chart_type: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
