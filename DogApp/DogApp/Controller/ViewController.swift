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
        print(dogImage)
    }
}

