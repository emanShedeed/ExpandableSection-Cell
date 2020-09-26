//
//  automaticCellHeight.swift
//  ExpandableTableViewSection
//
//  Created by gody on 9/13/20.
//  Copyright © 2020 gody. All rights reserved.
//

import UIKit

class AutomaticCell: UITableViewCell {
    @IBOutlet weak var titleLbl :UILabel!
    @IBOutlet weak var subTitleLbl :UILabel!
    @IBOutlet weak var subTitleLblHeight : NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
