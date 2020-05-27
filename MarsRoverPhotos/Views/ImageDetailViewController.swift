//
//  ImageDetailViewController.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/22/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import Foundation
import UIKit
import ImageScrollView

class ImageDetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var imageScrollView: ImageScrollView!
    
    // MARK: public properties
    public var image: UIImage!
    
    // MARK: Lifecycle Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView.setup()
        imageScrollView.display(image: image)
    }
}
