//
//  ProgramacaoCellTableViewCell.swift
//  cine_ufes
//
//  Created by Student on 12/21/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import UIKit

class ProgramacaoCellTableViewCell: UITableViewCell {

    @IBOutlet weak var horarioLabel: UILabel!
    @IBOutlet weak var diaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
