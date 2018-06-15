//
//  MouseStalkerView.swift
//  DMC
//
//  Created by Kanda Sena on 2018/05/04.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import Cocoa
import AudioToolbox

final class MouseStalkerView: NSImageView {
    
    var timer: Timer?
    var sleepTimer: Timer?
    var fightTimer: Timer?
    let cat: Cat = .black
    var now: NowImage = .sit1 {
        didSet {
            DispatchQueue.main.async {
                self.frame.size = self.now.imageSize(cat: self.cat)
                self.image = self.now.image(cat: self.cat)
            }
        }
    }
    var canMove = true
    var mousePosition: NSPoint!
    var elapsedTimes = 0
    
    let defaultSpeed: CGFloat = 20
    let nearDistance: CGFloat = 50
    var timeInterval: CGFloat = 0.1
    let cryStopTimeInterval: CGFloat = 1.0
    let sleepTimeInterval: CGFloat = 300
    let walkTimeInterval: Int = 5
    
    var distance: NSPoint!
    var goal: NSPoint!
    
    required init() {
        super.init(frame: .zero)
        setSleepTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("使用しません")
    }
    
    func stalk(to pos: NSPoint) {
        let distanceVec = self.distanceVec(pos: pos, frame: self.frame)
        self.distance = distanceVec
        self.goal = pos
        guard canMove else { return }
        guard pow(distanceVec.x, 2) + pow(distanceVec.y, 2) > pow(nearDistance, 2) else {
            return
        }
        
        if distanceVec.x > 0 {
            now = self.now.switchWalk(.right)
        } else {
            now = self.now.switchWalk(.left)
        }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(self.stalkToMouse), userInfo: nil, repeats: true)
    }
    
    private func distanceVec(pos: NSPoint, frame: NSRect) -> NSPoint {
        let disX = pos.x - (frame.origin.x + frame.size.width/2)
        let disY = pos.y - (frame.origin.y)
        return NSPoint(x: disX, y: disY)
    }
    
    @objc private func stalkToMouse() {
        var pos = self.frame
        guard canMove else { return }
        
        let speedX = defaultSpeed * distance.x / sqrt(pow(distance.x, 2) + pow(distance.y, 2))
        let speedY = defaultSpeed * distance.y / sqrt(pow(distance.x, 2) + pow(distance.y, 2))
        let speed = NSPoint(x: speedX, y: speedY)
        
        pos.origin.x += speed.x * timeInterval
        pos.origin.y += speed.y * timeInterval
        let dir: WalkDir = speed.x > 0 ? .right : .left
        self.walk(dir)
        elapsedTimes += 1
        
        let dis = distanceVec(pos: goal, frame: self.frame)
        if pow(dis.x, 2) + pow(dis.y, 2) < pow(nearDistance, 2)  {
            timer?.invalidate()
            now = .fight(dir)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.now = .stand(dir)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.now = .fight(dir)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.now = .stand(dir)
                        return
                    }
                }
            }
        } else {
            frame = pos
        }
    }
    
    private func walk(_ walk: WalkDir) {
        if elapsedTimes % walkTimeInterval == walkTimeInterval - 1 {
            now = now.switchWalk(walk)
        }
    }
    
    func cry(to pos: NSPoint) {
        let dis = distanceVec(pos: pos, frame: self.frame)
        if pow(dis.x, 2) + pow(dis.y, 2) < pow(nearDistance, 2) {
            cryCat()
        }
    }
    
    @objc private func cryCat() {
        now = .sit1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.now = .sit2
            var soundIdRing:SystemSoundID = 0
            let soundUrl = NSURL.fileURL(withPath: Bundle.main.path(forResource: "cry", ofType:"wav")!)
            let selfCanMove = self.canMove
            
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundIdRing)
            self.canMove = false
            AudioServicesPlaySystemSoundWithCompletion(soundIdRing) {
                self.now = .sit1
                AudioServicesDisposeSystemSoundID(soundIdRing)
                self.canMove = !selfCanMove
                self.setSleepTimer()
            }
        }
    }
    
    @objc private func sleep() {
        self.canMove = false
        self.now = .sleep
        self.setWakeUpTimer()
    }
    
    @objc private func wakeUp() {
        self.canMove = true
        self.now = .sit1
        self.setSleepTimer()
    }
    
    private func setSleepTimer() {
        sleepTimer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.sleepTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.sleepTimeInterval), target: self, selector: #selector(self.sleep), userInfo: nil, repeats: false)
        }
    }
    
    private func setWakeUpTimer() {
        sleepTimer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.sleepTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.sleepTimeInterval), target: self, selector: #selector(self.wakeUp), userInfo: nil, repeats: false)
        }
    }
    
    func carry(to pos: NSPoint) {
        now = .sit1
        self.frame.origin = CGPoint(x: pos.x - self.frame.size.width/2, y: pos.y - self.frame.size.height/4)
    }
}
