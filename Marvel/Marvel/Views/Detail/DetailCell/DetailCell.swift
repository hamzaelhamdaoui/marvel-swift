//
//  DetailCell.swift
//  Marvel
//
//  Created by AvantgardeIT on 21/4/22.
//

import UIKit

class DetailCell: UITableViewCell {
    static let nibName = "DetailCell"
    static let reuseIdentifier = "DetailCell"
    static let cellHeight: CGFloat = 45

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
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
    }
}
