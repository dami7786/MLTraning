//
//  ViewController.swift
//  MLPhoto
//
//  Created by 张爱民 on 2017/12/6.
//  Copyright © 2017年 iOSOR. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named:"bird.jpg")!
        let model = try! VNCoreMLModel(for: Resnet50().model)
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let vnRequest = VNCoreMLRequest(model: model) { (request, error) in
            if let result = request.results?.first, result is VNClassificationObservation  {
                let res = result as! VNClassificationObservation
                print(res.identifier, res.confidence, res.uuid.uuidString)
            }
        }
        try? handler.perform([vnRequest])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

