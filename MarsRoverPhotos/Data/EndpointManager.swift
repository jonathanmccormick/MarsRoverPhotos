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
    let API_KEY = "rZ0WQcn5EccakcXSymwZcgbdCw8URtiVGJYADFpq"
    let GET_VERB = "GET"
    
    static let sharedInstance: EndpointManager = {
        let instance = EndpointManager()
        // setup code
        return instance
    }()
    
    public func getRovers(completionHandler: @escaping (_ photos: [RoverModel]) -> ()) {
        let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers?api_key=\(API_KEY)")!
        let getRequest = makeGetRequest(with: url)

        URLSession.shared.dataTask(with: getRequest, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(RoverListResponseModel.self, from: data!)
                if let rovers = responseModel.rovers {
                    DispatchQueue.main.async {
                        completionHandler(rovers)
                    }
                }
            } catch {
                print("JSON Serialization error : \(error)")
            }
        }).resume()
    }
    
    public func getPhotos(rover: RoverModel, page: Int, completionHandler: @escaping (_ photos: [PhotoModel]) -> ()) {
        let url = generateUrl(rover: rover.name!, sol: 1, page: page)
        fetchJSON(url: url, completionHandler: completionHandler)
    }
    
    private func fetchJSON(url: URL, completionHandler: @escaping (_ photos: [PhotoModel]) -> ()) {
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
    
    private func generateUrl(rover: String, sol: Int, page: Int) -> URL{
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.nasa.gov"
        urlComponents.path = "/mars-photos/api/v1/rovers/\(rover)/photos"
        urlComponents.queryItems = [
            URLQueryItem(name: "sol", value: String(sol)),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: API_KEY)
        ]
        
        return urlComponents.url!
    }
    
    private func makeGetRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = GET_VERB
        return request
    }
}
