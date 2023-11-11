//
//  ServiceRequestingImageVIew.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import UIKit


// We are using this to gain access to our UIIMAGE 

class ServiceRequestingImageView: UIImageView, APIDataProvidable {

    func fetchImage(from url: URL) {
        let request = URLRequest(url: url)
        perform(request) { [weak self] result in
            switch result {
            case .failure:
                print("Error fetching the image! 📸📸📸")
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {return}
                DispatchQueue.main.async {
                    self?.contentMode = .scaleToFill
                    self?.image = image
                }
            }
        }
    }
}
