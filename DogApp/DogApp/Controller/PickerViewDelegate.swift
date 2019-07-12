//
//  PickerViewDelegate.swift
//  DogApp
//
//  Created by Ramiz Raja on 13/07/2019.
//  Copyright © 2019 Ramiz Raja. All rights reserved.
//

import Foundation
import UIKit
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        loadRandomImage(breeds[row])
    }
}
