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
                let vnRequest = VNCoreMLRequest(model: cmlModel) { (request, _) in
                    // 5.对请求到的结果进行处理
                    if let result = request.results?.first {
                        let res = result as! VNClassificationObservation
                        print(res.identifier)
                    }
                }
                // 3.获取请求的图片
                let cvImage = currentFrame.capturedImage
                // 4.发起请求
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
