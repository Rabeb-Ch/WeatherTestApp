//
//  TownTableViewCell.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit

class TownTableViewCell: UITableViewCell {

    @IBOutlet weak var townLabel : UILabel!
    @IBOutlet weak var accessoryImageView : UIImageView!
    @IBOutlet weak var deleteBtn : UIButton!

    var townVM : TownTableViewCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configure(){
        self.townLabel.text = townVM.townName
        self.deleteBtn.isEnabled = townVM.withDelete
        self.deleteBtn.isHidden = !townVM.withDelete
        self.accessoryImageView.image = UIImage(systemName: townVM.accessoryImageName)
    }
}
