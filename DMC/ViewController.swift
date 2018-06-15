//
//  ViewController.swift
//  DMC
//
//  Created by Kanda Sena on 2018/05/04.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSSpeechRecognizerDelegate {
    
    var imageView = MouseStalkerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setFirstCat()
        setMouseStalker()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func setFirstCat() {
        self.view.frame = CGRect(x: 0, y: 0, width: NSScreen.main!.frame.width, height: NSScreen.main!.frame.height)
        imageView.image = NSImage(named: NSImage.Name("blackCat1.png"))
        imageView.frame = CGRect(x: NSScreen.main!.frame.size.width/2,
                                 y: NSScreen.main!.frame.height/2,
                                 width: imageView.image?.size.width ?? 0,
                                 height: imageView.image?.size.height ?? 0)
        
        self.view.addSubview(imageView)
    }
    
    private func setMouseStalker() {
        imageView.stalk(to: NSEvent.mouseLocation)
        
        NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved]) {
            self.imageView.stalk(to: NSEvent.mouseLocation)
            return $0
        }
        
        NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved]) { _ in 
            self.imageView.stalk(to: NSEvent.mouseLocation)
        }
        
        NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown]) {
            self.imageView.cry(to: NSEvent.mouseLocation)
            return $0
        }
        
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown]) { _ in
            self.imageView.cry(to: NSEvent.mouseLocation)
        }
        
        NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDragged]) {
            self.imageView.carry(to: NSEvent.mouseLocation)
            return $0
        }
    }
}

