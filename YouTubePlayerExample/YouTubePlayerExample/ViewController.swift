//
//  ViewController.swift
//  YouTubePlayerExample
//
//  Created by Giles Van Gruisen on 1/31/15.
//  Copyright (c) 2015 Giles Van Gruisen. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewController: UIViewController {

    @IBOutlet var playerView: YouTubePlayerView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var currentTimeButton: UIButton!
    @IBOutlet var durationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func play(sender: UIButton) {
        if playerView.ready {
            if playerView.playerState != YouTubePlayerState.Playing {
                playerView.play()
                playButton.setTitle("Pause", for: .normal)
            } else {
                playerView.pause()
                playButton.setTitle("Play", for: .normal)
            }
        }
    }

    @IBAction func prev(sender: UIButton) {
        playerView.previousVideo()
    }

    @IBAction func next(sender: UIButton) {
        playerView.nextVideo()
    }

    @IBAction func loadVideo(sender: UIButton) {
        playerView.playerVars = [
            "playsinline": "1",
            "controls": "0",
            "showinfo": "0"
            ] as YouTubePlayerView.YouTubePlayerParameters
        playerView.loadVideoID("e-KPO3kzy-M")
    }

    @IBAction func loadPlaylist(sender: UIButton) {
        playerView.loadPlaylistID("PLwkHn4Vusy9V5mshCt5HF6bMZoROoGbhc")
    }
    
    @IBAction func currentTime(sender: UIButton) {
        playerView.getCurrentTime { [weak self] result in
            switch result {
            case .success(let value):
                let title: String
                if let value = value as? String {
                    title = String(format: "Current Time %@", value)
                } else {
                    title = "Missing Current Time"
                }
                self?.currentTimeButton.setTitle(title, for: .normal)
            case .failure(let error):
                print("[ERROR]", error.localizedDescription)
            }
        }
    }
    
    @IBAction func duration(sender: UIButton) {
        playerView.getDuration { [weak self] result in
            switch result {
            case .success(let value):
                let title: String
                if let value = value as? String {
                    title = String(format: "Duration %@", value)
                } else {
                    title = "Missing Duration"
                }
                self?.durationButton.setTitle(title, for: .normal)
            case .failure(let error):
                print("[ERROR]", error.localizedDescription)
            }
        }
    }
    
    func showAlert(message: String) {
        self.present(alertWithMessage(message: message), animated: true, completion: nil)
    }

    func alertWithMessage(message: String) -> UIAlertController {
        let alertController =  UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        return alertController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

