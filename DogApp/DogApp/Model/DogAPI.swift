//
//  DogAPI.swift
//  DogApp
//
//  Created by Ramiz Raja on 12/07/2019.
//  Copyright © 2019 Ramiz Raja. All rights reserved.
//

import Foundation

class DogAPI {
    enum EndPoint: String {
        case randomImageFromAllDogs = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    //class functions are same as static functions except that sublcasses can override them
    class func fetchImageData(completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: EndPoint.randomImageFromAllDogs.url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let dogImage = try parseImageDataUsingJsonSerialization(data: data)
                completionHandler(dogImage, nil)
            } catch {
                print(error)
                completionHandler(nil, error)
            }
    
        }
        task.resume()
    }
    
    private class func parseImageDataUsingJsonSerialization(data: Data) throws -> DogImage {
        let imageData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        let message = imageData["message"] as! String
        let status = imageData["status"] as! String
        return DogImage(message: message, status: status)
    }
    
    class func fetchImage(imageUrl: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            completionHandler(data, error)
        }
        
        task.resume()
    }
}
