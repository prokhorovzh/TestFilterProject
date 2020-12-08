//
//  UIExtensions.swift
//  TestFilterProject
//
//  Created by Anastasia Sokolan on 24.09.2020.
//  Copyright © 2020 Anastasia Sokolan. All rights reserved.
//

import UIKit

extension UIImage {
    var cgImageOrientation: CGImagePropertyOrientation {
        switch imageOrientation {
        case .up: return .up
        case .down: return .down
        case .left: return .left
        case .right: return .right
        case .upMirrored: return .upMirrored
        case .downMirrored: return .downMirrored
        case .leftMirrored: return .leftMirrored
        case .rightMirrored: return .rightMirrored
        @unknown default: return .up
        }
    }
}
