//
//  Cat.swift
//  DMC
//
//  Created by Kanda Sena on 2018/05/04.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import Cocoa

enum Cat {
    case black
    case white
    case mike
    case russianBlue
}

extension Cat {
    
    var rightWalk1: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mike3.png"))!
        }
    }
    var rightWalk2: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mike4.png"))!
        }
    }
    var leftWalk1: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mike1.png"))!
        }
    }
    var leftWalk2: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mike2.png"))!
        }
    }
    var sit1: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mikeSit1.png"))!
        }
    }
    var sit2: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mikeSit2.png"))!
        }
    }
    var stand1: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mikeStand1.png"))!
        }
    }
    var stand2: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mikeStand2.png"))!
        }
    }
    var fight1: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mikeFight1.png"))!
        }
    }
    var fight2: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mikeFight2.png"))!
        }
    }
    var sleep: NSImage {
        switch self {
        default:
            return NSImage(named: NSImage.Name("mikeSleep.png"))!
        }
    }
    
    var rightWalk1Size: CGSize {
        switch self {
        default:
            return CGSize(width: 96, height: 69)
        }
    }
    var rightWalk2Size: CGSize {
        switch self {
        default:
            return CGSize(width: 99, height: 69)
        }
    }
    var leftWalk1Size: CGSize {
        switch self {
        default:
            return CGSize(width: 94, height: 68)
        }
    }
    var leftWalk2Size: CGSize {
        switch self {
        default:
            return CGSize(width: 99, height: 69)
        }
    }
    var sit1Size: CGSize {
        switch self {
        default:
            return CGSize(width: 62, height: 93)
        }
    }
    var sit2Size: CGSize {
        switch self {
        default:
            return CGSize(width: 62, height: 92)
        }
    }
    var stand1Size: CGSize {
        switch self {
        default:
            return CGSize(width: 85, height: 80)
        }
    }
    var stand2Size: CGSize {
        switch self {
        default:
            return CGSize(width: 84, height: 80)
        }
    }
    var fight1Size: CGSize {
        switch self {
        default:
            return CGSize(width: 72, height: 81)
        }
    }
    var fight2Size: CGSize {
        switch self {
        default:
            return CGSize(width: 72, height: 81)
        }
    }
    var SleepSize: CGSize {
        switch self {
        default:
            return CGSize(width: 89, height: 66)
        }
    }
}

enum NowImage {
    case rightWalk1
    case rightWalk2
    case leftWalk1
    case leftWalk2
    case sit1
    case sit2
    case stand(WalkDir)
    case fight(WalkDir)
    case sleep
}

extension NowImage: Equatable {
    static func ==(lhs: NowImage, rhs: NowImage) -> Bool {
        switch (lhs, rhs) {
        case (.rightWalk1, .rightWalk1):
            return true
        case (.rightWalk2, .rightWalk2):
            return true
        case (.leftWalk1, .leftWalk1):
            return true
        case (.leftWalk2, .leftWalk2):
            return true
        case (.sit1, .sit1):
            return true
        case (.sit2, .sit2):
            return true
        case (.stand(let m), .stand(let n)):
            return m == n
        case (.fight(let m), .fight(let n)):
            return m == n
        case (.sleep, .sleep):
            return true
        default:
            return false
        }
    }
}

extension NowImage {
    
    func image(cat: Cat) -> NSImage {
        switch self {
        case .leftWalk1:
            return cat.leftWalk1
        case .leftWalk2:
            return cat.leftWalk2
        case .rightWalk1:
            return cat.rightWalk1
        case .rightWalk2:
            return cat.rightWalk2
        case .sit1:
            return cat.sit1
        case .sit2:
            return cat.sit2
        case .stand(let dir):
            switch dir {
            case .right:
                return cat.stand2
            case .left:
                return cat.stand1
            default:
                return cat.stand1
            }
        case .fight(let dir):
            switch dir {
            case .right:
                return cat.fight2
            case .left:
                return cat.fight1
            default:
                return cat.fight1
            }
        case .sleep:
            return cat.sleep
        }
    }
    
    func imageSize(cat: Cat) -> CGSize {
        switch self {
        case .leftWalk1:
            return cat.leftWalk1Size
        case .leftWalk2:
            return cat.leftWalk2Size
        case .rightWalk1:
            return cat.rightWalk1Size
        case .rightWalk2:
            return cat.rightWalk2Size
        case .sit1:
            return cat.sit1Size
        case .sit2:
            return cat.sit2Size
        case .stand(let dir):
            switch dir {
            case .right:
                return cat.stand2Size
            case .left:
                return cat.stand1Size
            default:
                return cat.stand1Size
            }
        case .fight(let dir):
            switch dir {
            case .right:
                return cat.fight2Size
            case .left:
                return cat.fight1Size
            default:
                return cat.fight1Size
            }
        case .sleep:
            return cat.SleepSize
        }
    }
    
    func switchWalk(_ walkDir: WalkDir) -> NowImage {
        switch walkDir {
        case .right:
            if self == .rightWalk1 {
                return .rightWalk2
            } else {
                return .rightWalk1
            }
        case .left:
            if self == .leftWalk1 {
                return .leftWalk2
            } else {
                return .leftWalk1
            }
        default:
            return self
        }
    }
}

enum WalkDir {
    case none
    case right
    case left
}
