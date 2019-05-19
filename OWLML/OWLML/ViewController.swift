//
//  ViewController.swift
//  OWLML
//
//  Created by Tyler Milner on 5/18/19.
//  Copyright © 2019 Tyler Milner. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var videoView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var player: AVPlayer?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentDocumentPicker()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let touchLocation = firstTouch.location(in: videoView)
            
            let hitView = videoView.hitTest(touchLocation, with: event)
            
            let existingView = videoView.subviews.first {
                guard let boxView = $0 as? BoxView else { return false }
                return boxView == hitView
            } as? BoxView
            
            // Set existing view to a "selected" state to move it around
            if let selectedView = existingView {
                debugPrint("Selected \(selectedView)")
                selectedView.strokeWidth = 4
            // Create a new box view
            } else {
                debugPrint("Tapped \(touchLocation)")
                
                let boxSize = CGSize(width: 30, height: 30)
                
                // Center box around tap location
                let boxView = BoxView(frame: CGRect(x: touchLocation.x - (0.5 * boxSize.width), y: touchLocation.y - (0.5 * boxSize.height), width: boxSize.width, height: boxSize.height))
                
                videoView.addSubview(boxView)
            }
        }
    }
    
    // MARK: - Private
    
    @objc private func videoViewTapped(_ recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: videoView)
        debugPrint("Tapped \(tapLocation)")
        
        let boxSize = CGSize(width: 30, height: 30)
        
        // Center box around tap location
        let boxView = BoxView(frame: CGRect(x: tapLocation.x - (0.5 * boxSize.width), y: tapLocation.y - (0.5 * boxSize.height), width: boxSize.width, height: boxSize.height))
        
        videoView.addSubview(boxView)
    }

    private func loadVideo(at url: URL) {
        let player = AVPlayer(url: url)
        self.player = player
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        videoView.layer.addSublayer(playerLayer)
    }
    
    private func presentDocumentPicker() {
        let types: [String] = [kUTTypeMPEG4 as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        
        present(documentPicker, animated: true, completion: nil)
    }
}

// MARK: - UIDocumentPickerDelegate

extension ViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let videoURL = urls.first else { return }
        loadVideo(at: videoURL)
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: - UITapGestureRecognizer


