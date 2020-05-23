/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct RoverModel : Codable {
	let id : Int?
	let name : String?
	let landing_date : String?
	let launch_date : String?
	let status : String?
	let max_sol : Int?
	let max_date : String?
	let total_photos : Int?
	let cameras : [Cameras]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case landing_date = "landing_date"
		case launch_date = "launch_date"
		case status = "status"
		case max_sol = "max_sol"
		case max_date = "max_date"
		case total_photos = "total_photos"
		case cameras = "cameras"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		landing_date = try values.decodeIfPresent(String.self, forKey: .landing_date)
		launch_date = try values.decodeIfPresent(String.self, forKey: .launch_date)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		max_sol = try values.decodeIfPresent(Int.self, forKey: .max_sol)
		max_date = try values.decodeIfPresent(String.self, forKey: .max_date)
		total_photos = try values.decodeIfPresent(Int.self, forKey: .total_photos)
		cameras = try values.decodeIfPresent([Cameras].self, forKey: .cameras)
	}

}
