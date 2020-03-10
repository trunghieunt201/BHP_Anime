//
//  MenuCell.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/5/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var outletBtn1: UIButton!
    @IBOutlet weak var outletBtn2: UIButton!
    @IBOutlet weak var outletBtn3: UIButton!
    
    var doneAction: (Int)->() = {_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func configCell(_ number: Int) {
        outletBtn1.setTitleColor(AppColors.grayText, for: .normal)
        outletBtn2.setTitleColor(AppColors.grayText, for: .normal)
        outletBtn3.setTitleColor(AppColors.grayText, for: .normal)
        
        if number == 1{
            outletBtn1.setTitleColor(AppColors.blackText, for: .normal)
        }else if number == 2{
            outletBtn2.setTitleColor(AppColors.blackText, for: .normal)
        }else{
            outletBtn3.setTitleColor(AppColors.blackText, for: .normal)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionBtn1(_ sender: Any) {
        self.doneAction(1)
    }
    
    @IBAction func actionBtn2(_ sender: Any) {
        self.doneAction(2)
    }
    
    @IBAction func actionBtn3(_ sender: Any) {
        self.doneAction(3)
    }
    
}
