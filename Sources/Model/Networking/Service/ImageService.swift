import Foundation
import UIKit

protocol Cancellable: AnyObject {
    func cancel()
}

protocol ImageReceiver: AnyObject {
    var currentDownloadTask: Cancellable? { get set }
    func setImage(_ image: UIImage)
}

final class ImageService {
    private var cache = NSCache<NSString, NSData>()
    
    func load(for receiver: ImageReceiver, imageUrl: URL) {
        if let cachedImage = cache.object(forKey: imageUrl.absoluteString as NSString),
            let image = UIImage(data: cachedImage as Data) {
            receiver.setImage(image)
            return
        }

        let dataTask = URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, _, _) in
            guard let self = self else { return }
            if let data = data, let image = UIImage(data: data) {
                self.cache.setObject(data as NSData, forKey: imageUrl.absoluteString as NSString)
                DispatchQueue.main.async {
                    receiver.setImage(image)
                }
            }
        }
        
        receiver.currentDownloadTask = dataTask
        dataTask.resume()
    }
}

extension URLSessionDataTask: Cancellable { }
