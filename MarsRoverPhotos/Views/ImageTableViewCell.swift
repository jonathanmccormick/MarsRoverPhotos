//
//  ImageTableViewCell.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/21/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import Foundation
import UIKit

class ImageTableViewCell: UITableViewCell {
    
    // MARK: Public identifier
    public static let id = "ImageTableViewCell"
    
    // MARK: Outlets
    @IBOutlet weak var marsImage: UIImageView!
    @IBOutlet weak var cameraNameLabel: UILabel!
    @IBOutlet weak var sol: UILabel!
    
    // MARK: Lifecycle Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
