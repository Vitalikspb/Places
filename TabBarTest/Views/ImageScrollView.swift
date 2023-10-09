////
////  ImageScrollView.swift
////  TabBarTest
////
////  Created by VITALIY SVIRIDOV on 18.12.2021.
////
//
//import UIKit
//
//class ImageScrollView: UIScrollView {
//    
//    // MARK: - Private properties
//    
//    private var imageZoomView: UIImageView!
//    private lazy var zoomingTap: UITapGestureRecognizer = {
//        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
//        zoomingTap.numberOfTapsRequired = 2
//        return zoomingTap
//    }()
//    
//    // MARK: - LifeCycle
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.centerImage()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.delegate = self
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Helper functions
//    
//    func set(image: UIImage) {
//        imageZoomView = nil
//        imageZoomView = UIImageView(image: image)
//        imageZoomView.addGestureRecognizer(zoomingTap)
//        imageZoomView.isUserInteractionEnabled = true
//        
//        self.backgroundColor = .white
//        self.delegate = self
//        self.decelerationRate = UIScrollView.DecelerationRate.fast
//        self.showsVerticalScrollIndicator = false
//        self.showsHorizontalScrollIndicator = false
//        self.addSubview(imageZoomView)
//        
//        configureFor(imageSize: image.size)
//    }
//    
//    private func configureFor(imageSize: CGSize) {
//        self.contentSize = imageSize
//        setCurrentMaxMinZoomScale()
//        self.zoomScale = self.minimumZoomScale
//    }
//    
//    private func setCurrentMaxMinZoomScale() {
//        let boundsSize = self.bounds.size
//        let imageSize = imageZoomView.bounds.size
//        let xScale = boundsSize.width / imageSize.width
//        let yScale = boundsSize.height / imageSize.height
//        let minScale = min(xScale, yScale)
//        var maxScale: CGFloat = 1.0
//        
//        if minScale < 0.1 {
//            maxScale = 0.3
//        }
//        if minScale >= 0.1 && minScale < 0.5 {
//            maxScale = 0.7
//        }
//        if minScale >= 0.5 {
//            maxScale = max(1.0, minScale)
//        }
//        self.maximumZoomScale = maxScale
//        self.minimumZoomScale = minScale
//    }
//    
//    private func centerImage() {
//        let boundsSize = self.bounds.size
//        var frameToCenter = imageZoomView.frame
//        
//        if frameToCenter.size.width < boundsSize.width {
//            frameToCenter.origin.x = ((boundsSize.width - frameToCenter.size.width) / 2)
//        } else {
//            frameToCenter.origin.x = 0
//        }
//        
//        if frameToCenter.size.height < boundsSize.height {
//            // MARK: - TODO 180 проверить на других экранах получил путем подбора - выставляем картинку по центру экрана
//            frameToCenter.origin.y = ((boundsSize.height-180 - frameToCenter.size.height) / 2)
//        } else {
//            frameToCenter.origin.y = 0
//        }
//        
//        imageZoomView.frame = frameToCenter
//    }
//    
//    private func handleZoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
//        var zoomRect = CGRect.zero
//        let bounds = self.bounds
//        
//        zoomRect.size.width = bounds.size.width / scale
//        zoomRect.size.height = bounds.size.height / scale
//        
//        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
//        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
//        
//        return zoomRect
//    }
//    
//    private func zoomTap(point: CGPoint, animated: Bool) {
//        let currentScale = self.zoomScale
//        let minScale = self.minimumZoomScale
//        let maxScale = self.maximumZoomScale
//        
//        if (minScale == maxScale && minScale > 1) { return }
//        let toScale = maxScale
//        let finalScale = (currentScale == minScale) ? toScale : minScale
//        let zoomRect = handleZoomRect(scale: finalScale, center: point)
//        
//        zoom(to: zoomRect, animated: animated)
//    }
//    
//    // MARK: - Selectors
//    
//    @objc private func handleZoomingTap(sender: UITapGestureRecognizer) {
//        let location = sender.location(in: sender.view)
//        zoomTap(point: location, animated: true)
//    }
//    
//}
//
//// MARK: - UIScrollViewDelegate
//
//extension ImageScrollView: UIScrollViewDelegate {
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        setCurrentMaxMinZoomScale()
//        return self.imageZoomView
//    }
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        self.centerImage()
//    }
//}
