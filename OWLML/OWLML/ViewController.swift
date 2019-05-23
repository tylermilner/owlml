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
    
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(keyboardKeyTapped(_:)), discoverabilityTitle: "Nudge selected box up"),
            UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(keyboardKeyTapped(_:)), discoverabilityTitle: "Nudge selected box down"),
            UIKeyCommand(input: UIKeyCommand.inputLeftArrow, modifierFlags: [], action: #selector(keyboardKeyTapped(_:)), discoverabilityTitle: "Nudge selected box left"),
            UIKeyCommand(input: UIKeyCommand.inputRightArrow, modifierFlags: [], action: #selector(keyboardKeyTapped(_:)), discoverabilityTitle: "Nudge selected box right")
        ]
    }
    private var player: AVPlayer?
    private var selectedBoxView: BoxView?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentDocumentPicker()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: videoView)
        
        let tappedView = videoView.hitTest(touchLocation, with: event)
        
        // Find the corresponding BoxView subview
        let selectedView = videoView.subviews.first { ($0 as? BoxView) == tappedView } as? BoxView
        
        if let selectedView = selectedView {
            // Toggle the selected state of the corresponding view
            selectedView.isSelected.toggle()
            selectedBoxView = selectedView
        } else if selectedBoxView != nil {
            // Deselect the existing selected view
            selectedBoxView?.isSelected.toggle()
            selectedBoxView = nil
        } else {
            // Create a new box view
            let boxSize = CGSize(width: 30, height: 30)
            
            // Center box around tap location
            let boxView = BoxView(frame: CGRect(x: touchLocation.x - (0.5 * boxSize.width), y: touchLocation.y - (0.5 * boxSize.height), width: boxSize.width, height: boxSize.height))
            
            videoView.addSubview(boxView)
        }
    }
    
    // MARK: - Private
    
    @objc private func keyboardKeyTapped(_ keyCommand: UIKeyCommand) {
        guard let selectedBoxView = selectedBoxView else { return }
        
        let translation: CGPoint = keyCommand.input.flatMap {
            switch $0 {
            case UIKeyCommand.inputUpArrow:
                return CGPoint(x: 0, y: -1)
            case UIKeyCommand.inputDownArrow:
                return CGPoint(x: 0, y: 1)
            case UIKeyCommand.inputLeftArrow:
                return CGPoint(x: -1, y: 0)
            case UIKeyCommand.inputRightArrow:
                return CGPoint(x: 1, y: 0)
            default:
                return nil
            }
        } ?? .zero
        
        let newFrame = selectedBoxView.frame.offsetBy(dx: translation.x, dy: translation.y)
        selectedBoxView.frame = newFrame
    }
    
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


