//
//  EndpointManager.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/22/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import Foundation

class EndpointManager {
    
    // MARK: Properties
    let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=rZ0WQcn5EccakcXSymwZcgbdCw8URtiVGJYADFpq")!
    let GET_VERB = "GET"
    
    static let sharedInstance: EndpointManager = {
        let instance = EndpointManager()
        // setup code
        return instance
    }()
    
    public func fetchJSON(completionHandler: @escaping (_ photos: [Photos]) -> ()) {
        let getRequest = makeGetRequest(with: url)

        URLSession.shared.dataTask(with: getRequest, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Json4Swift_Base.self, from: data!)
                if let photos = responseModel.photos {
                    DispatchQueue.main.async {
                        completionHandler(photos)
                    }
                }
            } catch {
                print("JSON Serialization error")
            }
        }).resume()
    }
    
    private func makeGetRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = GET_VERB
        return request
    }
}
