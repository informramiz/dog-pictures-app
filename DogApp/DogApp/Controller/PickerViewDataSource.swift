//
//  PickerViewDataSource.swift
//  DogApp
//
//  Created by Ramiz Raja on 13/07/2019.
//  Copyright © 2019 Ramiz Raja. All rights reserved.
//

import Foundation
import UIKit
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
}
