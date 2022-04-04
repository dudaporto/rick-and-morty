//
//  ImageService.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/04/22.
//

import Foundation
import UIKit

protocol ImageReceiver: AnyObject {
    var imageIdentifier: Int? { get }
    func setImage(_ image: UIImage)
}

final class ImageService {
    private var cache = NSCache<NSString, NSData>()
    
    func load(for receiver: ImageReceiver, imageUrl: URL, imageId: Int) {
        if let cachedImage = cache.object(forKey: imageUrl.absoluteString as NSString),
            let image = UIImage(data: cachedImage as Data) {
            if imageId == receiver.imageIdentifier {
                receiver.setImage(image)
            }
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    self.cache.setObject(data as NSData, forKey: imageUrl.absoluteString as NSString)
                    DispatchQueue.main.async {
                        if imageId == receiver.imageIdentifier {
                            receiver.setImage(image)
                        }
                    }
                }
            }
        }
    }
}
