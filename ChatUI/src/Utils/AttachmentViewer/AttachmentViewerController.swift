//
//  AttachmentViewerController.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/25/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import ImageViewer

class CounterView: UIView {

    var count: Int
    let countLabel = UILabel()
    var currentIndex: Int {
        didSet {
            updateLabel()
        }
    }

    init(frame: CGRect, currentIndex: Int, count: Int) {

        self.currentIndex = currentIndex
        self.count = count

        super.init(frame: frame)

        configureLabel()
        updateLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLabel() {

        countLabel.textAlignment = .center
        self.addSubview(countLabel)
    }

    func updateLabel() {

        let stringTemplate = "%d of %d"
        let countString = String(format: stringTemplate, arguments: [currentIndex + 1, count])

        countLabel.attributedText = NSAttributedString(string: countString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        countLabel.frame = self.bounds
    }
}
class AttachmentViewerController{
   
    var items: [DataItem] = []
    init (imageViews : UIImageView..., messageType : MessageType){
        for (index, imageView) in imageViews.enumerated() {

            var galleryItem: GalleryItem!
            switch messageType{
                
            case .text:
                return
            case .image(imageURL: let imageURL):
                let Url = URL(string: imageURL)
                let data = try? Data(contentsOf: Url!) //
                let image =  imageView.image ?? UIImage(data: data!)
                galleryItem = GalleryItem.image { $0(image) }
            case .video(let videoURL):
                galleryItem = GalleryItem.video(fetchPreviewImageBlock: { $0(#imageLiteral(resourceName: "image_placeholder")) }, videoURL: URL (string: videoURL)!)
            }
            items.append(DataItem(imageView: imageView, galleryItem: galleryItem))
        }
    }
    func showGalleryImageViewer( displacedView : UIImageView, fromViewController : UIViewController) {

//        guard let displacedView = sender.view as? UIImageView else { return }

        guard let displacedViewIndex = items.firstIndex(where: { $0.imageView == displacedView }) else { return }

        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        let headerView = CounterView(frame: frame, currentIndex: displacedViewIndex, count: items.count)
        let footerView = CounterView(frame: frame, currentIndex: displacedViewIndex, count: items.count)

        let galleryViewController = GalleryViewController(startIndex: displacedViewIndex, itemsDataSource: self, itemsDelegate: self, displacedViewsDataSource: self, configuration: galleryConfiguration())
        galleryViewController.headerView = headerView
        galleryViewController.footerView = footerView

        galleryViewController.launchedCompletion = { print("LAUNCHED") }
        galleryViewController.closedCompletion = { print("CLOSED") }
        galleryViewController.swipedToDismissCompletion = { print("SWIPE-DISMISSED") }

        galleryViewController.landedPageAtIndexCompletion = { index in

            print("LANDED AT INDEX: \(index)")

            headerView.count = self.items.count
            headerView.currentIndex = index
            footerView.count = self.items.count
            footerView.currentIndex = index
        }

        fromViewController.presentImageGallery(galleryViewController)
    }
    func galleryConfiguration() -> GalleryConfiguration {

        return [

            GalleryConfigurationItem.closeButtonMode(.builtIn),

            GalleryConfigurationItem.pagingMode(.standard),
            GalleryConfigurationItem.presentationStyle(.displacement),
            GalleryConfigurationItem.hideDecorationViewsOnLaunch(false),

            GalleryConfigurationItem.swipeToDismissMode(.vertical),
            GalleryConfigurationItem.toggleDecorationViewsBySingleTap(false),
            GalleryConfigurationItem.activityViewByLongPress(false),

            GalleryConfigurationItem.overlayColor(UIColor(white: 0.035, alpha: 1)),
            GalleryConfigurationItem.overlayColorOpacity(1),
            GalleryConfigurationItem.overlayBlurOpacity(1),
            GalleryConfigurationItem.overlayBlurStyle(UIBlurEffect.Style.light),
            
            GalleryConfigurationItem.videoControlsColor(.white),

            GalleryConfigurationItem.maximumZoomScale(8),
            GalleryConfigurationItem.swipeToDismissThresholdVelocity(500),

            GalleryConfigurationItem.doubleTapToZoomDuration(0.15),

            GalleryConfigurationItem.blurPresentDuration(0.5),
            GalleryConfigurationItem.blurPresentDelay(0),
            GalleryConfigurationItem.colorPresentDuration(0.25),
            GalleryConfigurationItem.colorPresentDelay(0),

            GalleryConfigurationItem.blurDismissDuration(0.1),
            GalleryConfigurationItem.blurDismissDelay(0.4),
            GalleryConfigurationItem.colorDismissDuration(0.45),
            GalleryConfigurationItem.colorDismissDelay(0),

            GalleryConfigurationItem.itemFadeDuration(0.3),
            GalleryConfigurationItem.decorationViewsFadeDuration(0.15),
            GalleryConfigurationItem.rotationDuration(0.15),

            GalleryConfigurationItem.displacementDuration(0.55),
            GalleryConfigurationItem.reverseDisplacementDuration(0.25),
            GalleryConfigurationItem.displacementTransitionStyle(.springBounce(0.7)),
            GalleryConfigurationItem.displacementTimingCurve(.linear),

            GalleryConfigurationItem.statusBarHidden(true),
            GalleryConfigurationItem.displacementKeepOriginalInPlace(false),
            GalleryConfigurationItem.displacementInsetMargin(50)
        ]
    }

}
extension AttachmentViewerController: GalleryDisplacedViewsDataSource {

    func provideDisplacementItem(atIndex index: Int) -> DisplaceableView? {

        return index < items.count ? items[index].imageView : nil
    }
}

extension AttachmentViewerController: GalleryItemsDataSource {

    func itemCount() -> Int {

        return items.count
    }

    func provideGalleryItem(_ index: Int) -> GalleryItem {

        return items[index].galleryItem
    }
}

extension AttachmentViewerController: GalleryItemsDelegate {

    func removeGalleryItem(at index: Int) {

        print("remove item at \(index)")

        let imageView = items[index].imageView
        imageView.removeFromSuperview()
        items.remove(at: index)
    }
}

// Some external custom UIImageView we want to show in the gallery
class FLSomeAnimatedImage: UIImageView {
}

// Extend ImageBaseController so we get all the functionality for free
class AnimatedViewController: ItemBaseController<FLSomeAnimatedImage> {
}
