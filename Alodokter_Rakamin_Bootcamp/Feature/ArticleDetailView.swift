//
//  ArticleDetailView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 14/12/21.
//

import UIKit

class ArticleDetailView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleBodyLabel: UILabel!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ArticleDetailView", owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
