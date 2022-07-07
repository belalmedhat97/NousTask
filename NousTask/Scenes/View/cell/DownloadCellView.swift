//
//  downlodCellView.swift
//  NousTask
//
//  Created by belal medhat on 06/07/2022.
//

import UIKit

class DownloadCellView: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var RImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        RImg.clipsToBounds = true
        RImg.layer.cornerRadius = 20
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
