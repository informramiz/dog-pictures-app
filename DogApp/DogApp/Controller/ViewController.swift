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
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.dataSource = self
        pickerView.delegate = self
        
        loadBreeds()
    }
    
    private func loadBreeds() {
        DogAPI.listBreeds { (breeds, error) in
            guard let breeds = breeds else {
                print(error ?? "Error occurred when loading breeds list")
                return
            }
            
            self.breeds = breeds.breedNamesList
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
    }

    func loadRandomImage(_ breed: String) {
        DogAPI.fetchRandomImageData(breed: breed, completionHandler: handleRandomImageResponse(dogImage:error:))
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

