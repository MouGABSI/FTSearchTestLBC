//
//  ImageLoader.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit

class ImageLoader {
    
    // Create a shared cache to store downloaded image data
    private static let cache = NSCache<NSString, NSData>()
    
    // Asynchronously download an image from a URL
    class func image(for url: URL, completionHandler: @escaping(_ image: UIImage?) -> ()) {
            
            // Check if the image data is already in the cache
            if let data = self.cache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
                return
            }
            
            // If not, download the image data from the URL
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                    DispatchQueue.main.async { completionHandler(nil) }
                    return
                }
                
                guard let data = data, let _ = UIImage(data: data) else {
                    DispatchQueue.main.async { completionHandler(nil) }
                    return
                }
                
                // Store the image data in the cache
                self.cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                // Return the downloaded image
                DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
            }
            task.resume()
    }
    
}
