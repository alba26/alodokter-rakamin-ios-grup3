//
//  UITextField+extension.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 07/12/21.
//

import UIKit

extension UITextField {
    func setCustomUI(withPlaceholder placeholder: String?) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 8, width: self.frame.width - 25, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.borderStyle = .none
        self.clearButtonMode = .whileEditing
        self.layer.addSublayer(bottomLine)
        self.placeholder = placeholder
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
