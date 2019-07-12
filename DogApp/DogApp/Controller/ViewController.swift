//
//  ViewController.swift
//  DogApp
//
//  Created by Ramiz Raja on 12/07/2019.
//  Copyright © 2019 Ramiz Raja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadRandomImage()
    }

    private func loadRandomImage() {
        DogAPI.fetchImageData(completionHandler: handleRandomImageResponse(dogImage:error:))
    }
    
    private func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        let imageUrlStr = dogImage?.message ?? ""
        guard let imageUrl = URL(string: imageUrlStr) else {
            print("Invalid image url: \(imageUrlStr)")
            return
        }
        
        DogAPI.fetchImage(imageUrl: imageUrl, completionHandler: handleImageFetch(data:error:))
    }
    
    private func handleImageFetch(data: Data?, error: Error?) {
        guard let data = data else {
            print("Image data is nil")
            return
        }
        
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data)
        }
    }
}

