//
//  DogAPI.swift
//  DogApp
//
//  Created by Ramiz Raja on 12/07/2019.
//  Copyright © 2019 Ramiz Raja. All rights reserved.
//


import Foundation

class DogAPI {
    enum EndPoint {
        case randomImageFromAllDogs
        case randomImageForBreed(String)
        
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogs:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            }
        }
    }
    
    //class functions are same as static functions except that sublcasses can override them
    class func fetchRandomImageData(completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: EndPoint.randomImageFromAllDogs.url) { (data, response, error) in
            handleLoadRandomImageResponse(data, response, error, completionHandler)
        }
        task.resume()
    }
    
    //class functions are same as static functions except that sublcasses can override them
    class func fetchRandomImageData(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: EndPoint.randomImageForBreed(breed).url) { (data, response, error) in
            handleLoadRandomImageResponse(data, response, error, completionHandler)

        }
        task.resume()
    }
    
    private class func handleLoadRandomImageResponse(_ data: Data?,
                                                     _ response: URLResponse?,
                                                     _ error: Error?,
                                                     _ completionHandler: @escaping (DogImage?, Error?) -> Void) {
        guard let data = data else {
            completionHandler(nil, error)
            return
        }
        
        do {
            let dogImage = try parseImageDataUsingJsonDecoder(data: data)
            completionHandler(dogImage, nil)
        } catch {
            print(error)
            completionHandler(nil, error)
        }
    }
    
    private class func parseImageDataUsingJsonSerialization(data: Data) throws -> DogImage {
        let imageData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        let message = imageData["message"] as! String
        let status = imageData["status"] as! String
        return DogImage(message: message, status: status)
    }
    
    private class func parseImageDataUsingJsonDecoder(data: Data) throws -> DogImage {
        let decoder = JSONDecoder()
        return try decoder.decode(DogImage.self, from: data)
    }
    
    class func fetchImage(imageUrl: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            completionHandler(data, error)
        }
        
        task.resume()
    }
}
