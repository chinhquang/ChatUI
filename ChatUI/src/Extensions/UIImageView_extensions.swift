//
//  UIImageView_extensions.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/24/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import SDWebImage
import ImageViewer
import AVFoundation

//MARK: - Set image
extension UIImageView: DisplaceableView {
    func setImage(imgURL : String, placeHolderImage : UIImage? = nil){
        self.sd_setImage(with: URL(string: imgURL), placeholderImage: placeHolderImage)
    }
    func setImage(from imgURL : String, with placeHolderImage : UIImage? = nil){
        
        self.sd_setImage(with: URL(string: imgURL), placeholderImage: placeHolderImage, options: .refreshCached)
    }
}


struct DataItem {

    let imageView: UIImageView
    let galleryItem: GalleryItem
}

func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
    DispatchQueue.global().async { //1
        let asset = AVAsset(url: url) //2
        let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
        avAssetImageGenerator.appliesPreferredTrackTransform = true //4
        let thumnailTime = CMTimeMake(value: 3, timescale: 1) //5
        do {
            let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
            let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
            DispatchQueue.main.async { //8
                completion(thumbNailImage) //9
            }
        } catch {
            print(error.localizedDescription) //10
            DispatchQueue.main.async {
                completion(nil) //11
            }
        }
    }
}
