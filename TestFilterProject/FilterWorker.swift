//
//  FilterWorker.swift
//  TestFilterProject
//
//  Created by Anastasia Sokolan on 27.09.2020.
//  Copyright © 2020 Anastasia Sokolan. All rights reserved.
//

import UIKit

class FilterWorker {
    private let image: UIImage
    private var filter = CIFilter(name: "CIExposureAdjust")!
    private var context = CIContext()
    
    init(image: UIImage) {
        self.image = image
        
        filter.setValue(CIImage(image: image)!, forKey: kCIInputImageKey)
    }
    
    func apply(with intensity: Float) -> CIImage {
        filter.setValue(intensity, forKey: kCIInputEVKey)
        let outputImage = filter.outputImage!
        return outputImage.oriented(image.cgImageOrientation)
    }
    
    func applyUIImage(with intensity: Float) -> UIImage {
        let filteredImage = apply(with: intensity)
        let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent)
        
        return UIImage(cgImage: cgImage!)
    }
}
