//
//  EventTableViewCell.swift
//  SEAC_Project_Experimentation
//
//  Created by Student on 7/17/19.
//  Copyright © 2019 SEAC_Organization. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocAndTime: UILabel!
    @IBOutlet weak var eventPeople: UILabel!
    @IBOutlet weak var eventImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
