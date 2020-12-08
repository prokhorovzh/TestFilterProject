//
//  ViewController.swift
//  TestFilterProject
//
//  Created by Anastasia Sokolan on 22.09.2020.
//  Copyright © 2020 Anastasia Sokolan. All rights reserved.
//

import CoreImage
import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Private Properties
        
   // private var imageView = UIImageView()
    private var metalView: MetalImageView!
    private var context: CIContext!
    private var device: MTLDevice!
    
    private var image: UIImage!
    
    private var filterWorker: FilterWorker!
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        metalView.frame = containerView.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        image = UIImage(named: "sunset")!
        
        filterWorker = FilterWorker(image: image)
        
        device = MTLCreateSystemDefaultDevice()
        context = CIContext(mtlDevice: device)
        
        metalView = MetalImageView(frame: .zero, device: device)
        
        containerView.addSubview(metalView)
//        imageView.image = image
//        imageView.contentMode = .scaleAspectFit
//
//        containerView.addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//            imageView.topAnchor.constraint(equalTo: containerView.topAnchor)
//        ])
    }
    
    // MARK: - IBActions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let filteredImage = filterWorker.apply(with: sender.value)
        metalView.render(image: filteredImage, context: context, device: device)
//        let filteredImage = filterWorker.applyUIImage(with: sender.value)
//        imageView.image = filteredImage
    }
}
