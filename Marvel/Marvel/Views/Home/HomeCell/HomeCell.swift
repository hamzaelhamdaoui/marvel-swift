//
//  HomeCell.swift
//  Marvel
//
//  Created by AvantgardeIT on 19/4/22.
//

import Nuke
import UIKit

class HomeCell: UITableViewCell {
    static let nibName = "HomeCell"
    static let reuseIdentifier = "HomeCell"
    static let rowHeight: CGFloat = 75

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var shortDescription: UILabel!

    var character: Character? {
        didSet {
            configure()
            setStyles()
        }
    }

    func configure() {
        characterName.text = character?.name
        shortDescription.attributedText = character?.shortDescription
        setImage()
    }

    func setStyles() {
        characterName.font = FontHelper.semiBoldFontWithSize(size: 18)
    }

    func setImage() {
        if let imageUrl = character?.thumbnail?.path,
            let imgExtension = character?.thumbnail?.thExtension,
           let url = APIService.shared.getImageURL(urlString: imageUrl, imgExtension: imgExtension, imgVariant: "standard_small") {
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: "ic_placeholder"),
                transition: .fadeIn(duration: 0.33)
            )
            Nuke.loadImage(with: url, options: options, into: characterImage, progress: nil, completion: nil)
        }
    }
}
