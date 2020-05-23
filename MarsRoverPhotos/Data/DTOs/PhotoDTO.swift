//
//  Photo.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/22/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import Foundation
import UIKit

class PhotoDTO {
    let id : Int?
    let sol : Int?
    let camera : Camera?
    let img_src : String?
    var image: UIImage? = nil
    let earth_date : String?
    let rover : RoverModel?
    
    init(id : Int?,
         sol : Int?,
         camera : Camera?,
         img_src : String?,
         earth_date : String?,
         rover : RoverModel?) {
        self.id = id
        self.sol = sol
        self.camera = camera
        self.img_src = img_src
        self.earth_date = earth_date
        self.rover = rover
    }
}
