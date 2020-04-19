//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var eggLabel: UILabel!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var eggTimer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eggLabel.text = "How would you like your eggs?"
        progressBar.progress = 0
    }
    
    @IBAction func hardnessTapped(_ sender: UIButton) {
        
        eggTimer.invalidate()
        progressBar.progress = 0
        secondsPassed = 0
        
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]! * 60
        print(totalTime)
        
        eggLabel.text = "Your \(hardness.lowercased()) eggs are coming up!"
        
        eggTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let eggTime = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = eggTime
            triggerTockTick()
            
        } else {
            eggTimer.invalidate()
            eggLabel.text = "Done!"
            triggerDoneAlarm()
        }
    }
    
    func triggerTockTick() {
        let url = Bundle.main.url(forResource: "254315__jagadamba__clock-tick", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func triggerDoneAlarm() {
        let url = Bundle.main.url(forResource: "420506__jfrecords__uprising1", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
