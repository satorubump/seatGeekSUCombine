//
//  ImageLoader.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import Foundation

///
///  Image Data Downloading in A Syncronize
///
final class ImageLoader : ObservableObject {
    /// Observed Download Image Data
    @Published var downloadData: Data?
    var cacheData = [String : Data]()

    /// Image Downloading
    func downloadImage(url: String) {
        /// if it has chache no download
        if let cache = cacheData[url] {
            downloadData = cache
            return
        }
        guard let imageURL = URL(string: url) else { return }
        /// Image Downloading on A Sync Thread
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downloadData = data
                self.cacheData[url] = data
            }
        }
    }
}
