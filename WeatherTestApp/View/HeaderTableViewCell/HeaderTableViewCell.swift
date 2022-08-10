//
//  HeaderTableViewCell.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var headerViewCellVM : HeaderTableViewCellVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureHeaderCell(){
        locationLabel.text = headerViewCellVM?.timeZone
        summaryLabel.text = headerViewCellVM?.desc
        tempLabel.text = headerViewCellVM?.temperature
    }
    
}
