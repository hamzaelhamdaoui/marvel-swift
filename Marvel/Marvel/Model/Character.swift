// swiftlint:disable all

/*
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Atributika
import Foundation

struct Character : Codable {
	let id : Int?
	let name : String?
	let description : String?
	let modified : String?
	let thumbnail : Thumbnail?
	let resourceURI : String?
	let comics : Comics?
	let series : Series?
	let stories : Stories?
	let events : Events?
	let urls : [Urls]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case description = "description"
		case modified = "modified"
		case thumbnail = "thumbnail"
		case resourceURI = "resourceURI"
		case comics = "comics"
		case series = "series"
		case stories = "stories"
		case events = "events"
		case urls = "urls"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		modified = try values.decodeIfPresent(String.self, forKey: .modified)
		thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
		resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
		comics = try values.decodeIfPresent(Comics.self, forKey: .comics)
		series = try values.decodeIfPresent(Series.self, forKey: .series)
		stories = try values.decodeIfPresent(Stories.self, forKey: .stories)
		events = try values.decodeIfPresent(Events.self, forKey: .events)
		urls = try values.decodeIfPresent([Urls].self, forKey: .urls)
	}

    var shortDescription: NSAttributedString {
        let b = Style("b").foregroundColor(.black).font(FontHelper.boldFontWithSize(size: 14))
        let all = Style.font(FontHelper.semiBoldFontWithSize(size: 12)).foregroundColor(UIColor.gray)

        let shortDescription = "Comics <b>\(comics?.available ?? 0)</b> Series <b>\(series?.available ?? 0)</b> Stories <b>\(stories?.available ?? 0)</b> Events <b>\(events?.available ?? 0)</b>"
        return shortDescription.style(tags: [b]).styleAll(all).attributedString
    }
}
