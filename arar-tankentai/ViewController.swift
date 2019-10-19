//
//  ViewController.swift
//  arar-tankentai
//
//  Created by kaichan on 10/12/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var remainTimeView: StatusView!
    @IBOutlet weak var scoreView: StatusView!
    var choiseView: ChoiseAnswerView!
    var guideView: GuideWayView!
    var alertView: AlertView!
    
    var remainTimer: RemainTimerManager!
    var currentQuest: Quest!
    var videoPlayer: AVPlayer!
    var videoNode: SCNNode!
    var replayNonde: SCNNode!
    var missLocGuideNodeList: [SCNNode] = []
    var hasShowMissLocationGuidePanelImageNameList: [String] = []
    var needsReloadNodesForNewQuest = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentQuest = questManager.generate()
        
        self.sceneView.delegate = self
        
        self.remainTimeView.title = "のこり時間"
        self.remainTimeView.status = "10:00"
        
        self.scoreView.title = "スコア"
        self.scoreView.status = "0"
        
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        self.choiseView = ChoiseAnswerView(frame: CGRect(x: 0, y: screenHeight() - 160, width: screenWidth(), height: 160 + bottom))
        self.choiseView.delegate = self
        self.choiseView.question = self.currentQuest.question
        self.choiseView.answer1 = self.currentQuest.answerCandidates[0]
        self.choiseView.answer2 = self.currentQuest.answerCandidates[1]
        self.choiseView.answer3 = self.currentQuest.answerCandidates[2]
        self.choiseView.answer4 = self.currentQuest.answerCandidates[3]
        self.choiseView.hideDown(isAnimated: false)
        self.view.addSubview(self.choiseView)
        
        self.guideView = GuideWayView(frame: CGRect(x: 0, y: screenHeight() - 100, width: screenWidth(), height: 100 + bottom))
        self.guideView.location = self.currentQuest.location
        self.view.addSubview(self.guideView)
        
        self.alertView = AlertView(frame: self.view.frame)
        self.alertView.hide(isAnimated: false)
        self.view.addSubview(self.alertView)
        
        self.remainTimer = RemainTimerManager()
        self.remainTimer.delegate = self
        self.remainTimer.load()
        self.remainTimer.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupAR()
    }
    
    func setupAR() {
        let configuration = ARImageTrackingConfiguration()
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            configuration.trackingImages = trackedImages
        }
        self.sceneView.session.run(configuration)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let currentTouchLocation = touches.first?.location(in: self.sceneView),
            let node = self.sceneView.hitTest(currentTouchLocation, options: nil).first?.node else { return }
        
        if node == self.replayNonde || node == self.videoNode {
            if self.videoPlayer.timeControlStatus == .paused {
                self.replayNonde.removeFromParentNode()
                self.videoPlayer.seek(to: CMTime.zero)
                self.videoPlayer.play()
            }
        }
    }
}

extension ViewController: RemainTimerManagerDelegate {
    
    func remainTimerManager(_ remainTimerManager: RemainTimerManager, updateTimer remainTime: String) {
        self.remainTimeView.status = remainTime
    }
    
    func remainTimerMangager(_ remainTimerManager: RemainTimerManager, finishTimer remainTime: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension ViewController: ChoiseAnswerViewDelegate {
    
    func choiseAnswerView(_ choiseAnswerView: ChoiseAnswerView, didSelectAnswerAt index: Int) {
        if self.currentQuest.answer == self.currentQuest.answerCandidates[index] {
            let message = "おめでとう！\n\(self.currentQuest.answerDescription)"
            self.alertView.show(title: "正解！", message: message)
            
            scoreManager.add(askingTime: 0)
            self.scoreView.status = String(scoreManager.score)
        }
        else {
            let message = "残念！正解は\n「 \(self.currentQuest.answer) 」\n\(self.currentQuest.answerDescription)"
            self.alertView.show(title: "不正解。。。", message: message)
        }
        
        // reset nodes
        self.resetAddedNodes()
        
        // Generate new quest
        self.currentQuest = questManager.generate()
        self.choiseView.question = self.currentQuest.question
        self.choiseView.answer1 = self.currentQuest.answerCandidates[0]
        self.choiseView.answer2 = self.currentQuest.answerCandidates[1]
        self.choiseView.answer3 = self.currentQuest.answerCandidates[2]
        self.choiseView.answer4 = self.currentQuest.answerCandidates[3]
        self.guideView.location = self.currentQuest.location
        
        self.choiseView.hideDown()
        self.guideView.showUp(delay: 1.0)
    }
}

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        let fileName = self.currentQuest.fileName

        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        guard let imageAnchorName = imageAnchor.referenceImage.name else {
            return
        }
        guard let fileUrlString = Bundle.main.path(forResource: fileName, ofType: "mov") else {
            return
        }

        if imageAnchorName == fileName {

            if self.needsReloadNodesForNewQuest == true {
                self.needsReloadNodesForNewQuest = false
                
                self.drawPlayVideoPanel(node: node, imageAnchor: imageAnchor, fileUrlString: fileUrlString)
                if self.choiseView.isShowing == false {
                    DispatchQueue.main.async {
                        self.guideView.hideDown()
                        self.choiseView.showUp(delay: 1.0)
                    }
                }
            }
        }
        else {
            if self.hasShowMissLocationGuidePanelImageNameList.contains(imageAnchorName) == false {
                self.hasShowMissLocationGuidePanelImageNameList.append(imageAnchorName)
                self.drawMissLocationGuidePanel(node: node, imageAnchor: imageAnchor)
            }
        }
    }
    
    func drawPlayVideoPanel(node: SCNNode, imageAnchor: ARImageAnchor, fileUrlString: String) {
        let videoItem = AVPlayerItem(url: URL(fileURLWithPath: fileUrlString))
        self.videoPlayer = AVPlayer(playerItem: videoItem)
        self.videoPlayer.play()
        
        let size = CGSize(width: 640, height: 640)
        let videoScene = SKScene(size: size)
        
        let videoPlayerNode = SKVideoNode(avPlayer: self.videoPlayer)
        videoPlayerNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        videoPlayerNode.yScale = -1.0
        
        videoScene.addChild(videoPlayerNode)
        
        let videoPlane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                             height: imageAnchor.referenceImage.physicalSize.height)
        videoPlane.firstMaterial?.diffuse.contents = videoScene
        self.videoNode = SCNNode(geometry: videoPlane)
        self.videoNode.eulerAngles.x = -Float.pi / 2
        node.addChildNode(self.videoNode)
        
        
        // Replay Panel
        let guidePanelImage = UIImage(named: "replayPanel")
        let width = imageAnchor.referenceImage.physicalSize.width
        let height = imageAnchor.referenceImage.physicalSize.height
        let replayPlane = SCNPlane(width: width,
                                   height: height)
        replayPlane.firstMaterial?.diffuse.contents = guidePanelImage
        self.replayNonde = SCNNode(geometry: replayPlane)
        self.replayNonde.eulerAngles.x = -Float.pi / 2
        
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer.currentItem, queue: .main) { [weak self] _ in
            node.addChildNode(self!.replayNonde)
        }
    }
    
    func drawMissLocationGuidePanel(node: SCNNode, imageAnchor: ARImageAnchor) {
        let guidePanelImage = UIImage(named: "missLocationGuidePanel")
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                             height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = guidePanelImage
        let guideNode = SCNNode(geometry: plane)
        guideNode.eulerAngles.x = -Float.pi / 2
        node.addChildNode(guideNode)
        self.missLocGuideNodeList.append(guideNode)
    }
    
    func resetAddedNodes() {
        self.videoPlayer.pause()
        self.hasShowMissLocationGuidePanelImageNameList = []
        if self.videoNode != nil {
            self.videoNode.removeFromParentNode()
        }
        if self.replayNonde != nil {
            self.replayNonde.removeFromParentNode()
        }
        for guideNode in self.missLocGuideNodeList {
            guideNode.removeFromParentNode()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.needsReloadNodesForNewQuest = true
        }
    }
}
