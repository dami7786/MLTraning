//
//  ViewController.swift
//  AR_CML
//
//  Created by 张爱民 on 2017/12/5.
//  Copyright © 2017年 iOSOR. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision

class ViewController: UIViewController, ARSCNViewDelegate {
    // ARSCNView 和 ARSKView 区别：
    // ARSCNView: A view for displaying AR experiences that augment the camera view with 3D SceneKit content.
    // ARSKView: A view for displaying AR experiences that augment the camera view with 2D SpriteKit content.
    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(gesture:)))
        sceneView.addGestureRecognizer(tapGesture)
    }

    @objc func onTap(gesture: UIGestureRecognizer) {
        guard let currentFrame = sceneView.session.currentFrame else { return }
        DispatchQueue.global().async {
            do {
                // 1.创建模型
                let cmlModel = try! VNCoreMLModel(for: Resnet50().model)
                // 2.创建请求
                // VNCoreMLRequest是什么: An image analysis request that uses a Core ML model to process images.
                // 它是一个使用Core ML数据模型来来分析图片的请求图片分析
//                The results array of a Core ML-based image analysis request contains a different observation type depending on the kind of MLModel object you create the request with:
//                If the model predicts a single feature (that is, the model's modelDescription object has a non-nil value for its predictedFeatureName property), Vision treats that model as a classifier: the results are VNClassificationObservation objects.
//                If the model's outputs include at least one output whose feature type is image, Vision treats that model as an image-to-image model: the results are VNPixelBufferObservation objects.
//                Otherwise, Vision treats the model as a general predictor model: the results are VNCoreMLFeatureValueObservation objects
                let vnRequest = VNCoreMLRequest(model: cmlModel) { (request, _) in
                    // 5.对请求到的结果进行处理
                    if let result = request.results?.first, result is VNClassificationObservation {
                        let res = result as! VNClassificationObservation
                        // 表示和匹配度
                        print(res.identifier,res.confidence, res.uuid.uuidString)
                    }
                }
                // 3.获取请求的图片
                //capturedImage是什么： A pixel buffer containing the image captured by the camera.
//                ARKit captures pixel buffers in a planar YCbCr format (also known as YUV) format. To render these images on a device display, you'll need to access the luma and chroma planes of the pixel buffer and convert pixel values to an RGB format.
//                For sample code that performs this conversion using Metal, create a new app in Xcode 9 with the Augmented Reality template, and choose Metal for the content technology.
                let cvImage = currentFrame.capturedImage
                // 4.发起请求
                //VNImageRequestHandler是什么： An object that processes one or more image analysis requests pertaining to a single image.
                let handler = VNImageRequestHandler(cvPixelBuffer: cvImage, orientation: .upMirrored, options: [:])
                try handler.perform([vnRequest])
            } catch {

            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate

/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }
}
