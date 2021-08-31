//
//  Constants.swift
//  anime_recommendation
//
//  Created by Leo Nugraha on 2021/8/30.
//

import Foundation
import UIKit

let GET_API_URL = "https://api.jikan.moe/v3/top/anime/"

let MAX_PAGE = 5
let MIN_PAGE = 1

let bkColor     = UIColor.init(red:  32/255.0, green:  52/255.0, blue:  77/255.0, alpha: 1.0)
let bk_6Color   = UIColor.init(red:  98/255.0, green: 103/255.0, blue: 129/255.0, alpha: 0.6)
let blColor     = UIColor.init(red:  77/255.0, green: 106/255.0, blue: 141/255.0, alpha: 1.0)
let bl_5Color   = UIColor.init(red:  77/255.0, green: 106/255.0, blue: 141/255.0, alpha: 0.5)
let gyColor     = UIColor.init(red: 245/255.0, green: 246/255.0, blue: 250/255.0, alpha: 1.0)

class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}

extension UIImageView {

    public func load(urlStr: String) {
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: urlStr) else {
                return
            }

            func setImage(image: UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }

            let urlToString = url.absoluteString as NSString
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            } else {
                setImage(image: nil)
            }
        }
    }

}
