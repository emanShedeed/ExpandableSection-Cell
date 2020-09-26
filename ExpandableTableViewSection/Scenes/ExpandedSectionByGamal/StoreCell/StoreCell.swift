//
//  StoreCell.swift
//  Ataba
//
//  Created by eman shedeed on 12/15/19.
//  Copyright © 2019 eman shedeed. All rights reserved.
//
import UIKit
protocol StoreCellDelegate:class{
    func storeCell(didTappedSelectStore cell:StoreCell)
}
class StoreCell: UITableViewCell {
    
    @IBOutlet weak var  storenameLbl : UILabel!
    @IBOutlet weak var  selectStoreBtn : UIButton!
    weak var cellDelegate:StoreCellDelegate?
    var storID : String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func selectStoreBtnPressed(){
        cellDelegate?.storeCell(didTappedSelectStore: self)
    }
}
extension StoreCell{
    func displayData(storeName:String,isSelected:Bool){
        self.storenameLbl.text = storeName
        selectStoreBtn.setBackgroundImage(isSelected ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
    }
}
