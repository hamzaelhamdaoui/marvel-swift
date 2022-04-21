//
//  FontHelper.swift
//  Marvel
//
//  Created by AvantgardeIT on 19/4/22.
//

import Foundation
import UIKit

enum Fonts: String {
    case regular
    case medium
    case semibold
    case semiboldIt
    case bold
    case boldIt
    case light
    case extraLight
    case it

    static let fontName = "SourceSansPro-"

    var string: String {
            return Fonts.fontName + self.rawValue
    }
}

struct FontHelper {
    static func italicFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.it.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }

    static func regularFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.regular.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }

    static func mediumFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.medium.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }

    static func semiBoldFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.semibold.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }

    static func semiBoldItFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.semiboldIt.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }

    static func boldFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.bold.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }

    static func boldItFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.boldIt.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }

    static func lightFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.light.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }

    static func extraLightFontWithSize(size: CGFloat) -> UIFont {
        UIFont(name: Fonts.extraLight.string, size: size) ?? UIFont.systemFont(ofSize: 15)
    }
}
