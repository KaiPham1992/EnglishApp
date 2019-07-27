	//
//  File.swift
//  EnglishApp
//
//  Created by vinova on 6/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit
    
protocol TimeDelegate: class {
    func endTime()
    func startTime()
    func pauseTime()
    func changeTime()
}

class ViewTime: BaseViewXib{
    @IBAction func clickPlay(_ sender: Any) {
        if !isStart {
            viewPlay.isHidden = true
            startTimer()
        } else {
            viewPlay.isHidden = false
            pauseTimer()
        }
        
    }
    @IBOutlet weak var viewPlay: UIView!
    
    var timer : Timer?
    var isStart = false
    
    weak var delegate: TimeDelegate?
    var time = 60
    
    @IBOutlet weak var lblTime: UILabel!
    override func setUpViews() {
        super.setUpViews()
        
    }
    
    func getCurrentTime() -> Int{
        return self.time
    }
    
    func stopTimer() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func setupTimeStartNow(min: Int) {
        self.time = min
        self.setupTimer(time: self.time)
        startTimer()
    }
    
    func setupTime(min: Int){
        self.time = min
        self.setupTimer(time: self.time)
    }
    
    func startTimer(){
        self.isStart = true
        viewPlay.isHidden = true
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTime), userInfo: nil, repeats: true)
        }
        delegate?.startTime()
    }
    
    func pauseTimer(){
        self.isStart = false
        viewPlay.isHidden = false
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
        delegate?.pauseTime()
    }
    
    @objc func changeTime(){
        if self.time == 0 {
            stopTimer()
            delegate?.endTime()
            
        } else {
            self.delegate?.changeTime()
            self.time -= 1
            self.setupTimer(time: self.time)
        }
    }
    
    func setupTimer(time: Int){
        let second = self.time % 60
        let min : Int = self.time / 60
        let timeText = second < 10 ? "\(min):0\(second) \(LocalizableKey.min.showLanguage)" : "\(min):\(second) \(LocalizableKey.min.showLanguage)"
        lblTime.text = timeText
    }
}
