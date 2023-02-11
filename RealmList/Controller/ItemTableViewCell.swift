//
//  ItemTableViewCell.swift
//  RealmList
//
//  Created by Ahmed Hamam on 11/02/2023.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!{
        didSet{
            itemLabel.backgroundColor = .black
            itemLabel.textColor = .orange
            itemLabel.layer.borderColor = UIColor.white.cgColor
            itemLabel.layer.borderWidth = 1
            itemLabel.layer.cornerRadius = itemLabel.frame.size.height/10
            itemLabel.clipsToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
