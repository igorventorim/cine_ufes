//
//  TituloTableViewCell.swift
//  cine_ufes
//
//  Created by Student on 12/19/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import UIKit

class TituloTableViewCell: UITableViewCell {

    @IBOutlet weak var TituloLabel: UILabel!
    
    @IBOutlet weak var generoLabel: UILabel!
    
    @IBOutlet weak var notaLabel: UILabel!

    @IBOutlet weak var imagemView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
