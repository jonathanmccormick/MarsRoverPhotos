//
//  PhotoListViewController.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/27/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    // MARK: Public rover property
    public var rover: RoverModel!
    
    // MARK: Private data
    public var photos: [PhotoDTO] = []
    private var currentPage = 1
    private var loadingData = false
    
    init(rover: RoverModel) {
        self.rover = rover
    }
    
    public func loadPhotos(completionHandler: @escaping () -> ()) {
        print(currentPage)
        EndpointManager.sharedInstance.getPhotos(rover: rover, page: currentPage) {
            photos in
            self.photos.append(contentsOf: photos.map{ $0.toDTO() })
            self.currentPage += 1
            self.loadingData = false
            completionHandler()
        }
    }

}
