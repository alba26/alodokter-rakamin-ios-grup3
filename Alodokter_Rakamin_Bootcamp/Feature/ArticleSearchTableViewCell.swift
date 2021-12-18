//
//  ArticleSearchTableViewCell.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by aurelia natasha on 16/12/21.
//

import UIKit

class ArticleSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var articleSearchImage: UIImageView!
    @IBOutlet weak var articleSearchTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

