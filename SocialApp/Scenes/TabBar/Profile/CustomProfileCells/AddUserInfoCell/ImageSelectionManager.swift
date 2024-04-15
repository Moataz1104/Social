//
//  ImageSelectionManager.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 15/04/2024.
//

import Foundation
import UIKit

class ImageSelectionManager {
    static let shared = ImageSelectionManager()
    var selectedImage: UIImage? {
        didSet {
            NotificationCenter.default.post(name: .selectedImageDidChangeNotification, object: nil)
        }
    }
}

extension Notification.Name {
    static let selectedImageDidChangeNotification = Notification.Name("selectedImageDidChangeNotification")
}
