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
    
    @IBOutlet private var videoPlayerView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentDocumentPicker()
    }
    
    // MARK: - Private

    private func playVideo(at url: URL) {
        let player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        videoPlayerView.layer.addSublayer(playerLayer)
        player.play()
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
        playVideo(at: videoURL)
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
