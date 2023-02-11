//
//  CategoryTableViewCell.swift
//  RealmList
//
//  Created by Ahmed Hamam on 11/02/2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!{
        didSet{
            categoryLabel.backgroundColor = .black
            categoryLabel.textColor = .orange
            categoryLabel.layer.borderColor = UIColor.white.cgColor
            categoryLabel.layer.borderWidth = 1
            categoryLabel.layer.cornerRadius = categoryLabel.frame.size.height/10
            categoryLabel.clipsToBounds = true
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
