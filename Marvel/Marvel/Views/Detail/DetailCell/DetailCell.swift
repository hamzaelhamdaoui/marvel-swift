//
//  DetailCell.swift
//  Marvel
//
//  Created by AvantgardeIT on 21/4/22.
//

import UIKit

class DetailCell: UITableViewCell {
    class func nibName() -> String {
        "DetailCell"
    }
    
    class func reuseIdentifier() -> String {
        "DetailCell"
    }
    
    class var cellHeight: CGFloat {
        45
    }

    @IBOutlet weak var titleLabel: UILabel!

    var title: String? {
        didSet {
            configureView()
            setStyles()
        }
    }

    func configureView() {
        titleLabel.text = title
    }

    func setStyles() {
        titleLabel.font = FontHelper.semiBoldFontWithSize(size: 14)
    }
}
