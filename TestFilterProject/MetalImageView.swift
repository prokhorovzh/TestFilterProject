//
//  MetalImageView.swift
//  TestFilterProject
//
//  Created by Евгений Прохоров on 01.10.2020.
//  Copyright © 2020 Anastasia Sokolan. All rights reserved.
//

import AVFoundation
import MetalKit
import UIKit

class MetalImageView: MTKView {
    private var mtlTexture: MTLTexture?
    private var commandQueue: MTLCommandQueue?
    private var ciContext: CIContext?
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        isOpaque = false
        enableSetNeedsDisplay = true
        framebufferOnly = false
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        isOpaque = false
        enableSetNeedsDisplay = true
        framebufferOnly = false
    }
    
    func render(image: CIImage, context: CIContext, device: MTLDevice) {
        ciContext = context
        self.device = device
        
        var rect = bounds
        rect.size = drawableSize
        rect = AVMakeRect(aspectRatio: image.extent.size, insideRect: rect)
        let filteredImage = image.transformed(by: CGAffineTransform(
                                scaleX: rect.size.width/image.extent.size.width,
                                y: rect.size.height/image.extent.size.height))
        let x = -rect.origin.x
        let y = -rect.origin.y
        
        commandQueue = device.makeCommandQueue()
        
        let buffer = commandQueue!.makeCommandBuffer()!
        mtlTexture = currentDrawable!.texture
        ciContext!.render(filteredImage.oriented(.down), to: currentDrawable!.texture, commandBuffer: buffer, bounds: CGRect(origin: CGPoint(x: x, y: y), size: drawableSize), colorSpace: CGColorSpaceCreateDeviceRGB())
        buffer.present(currentDrawable!)
        buffer.commit()
    }
}
