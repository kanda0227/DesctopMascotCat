//
//  MainWindowController.swift
//  DMC
//
//  Created by Kanda Sena on 2018/05/04.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import Cocoa

final class MainWindowController: NSWindowController {
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.styleMask = .fullSizeContentView
        
        window?.backgroundColor = .clear
        
        window?.level = NSWindow.Level(Int(CGWindowLevelForKey(.floatingWindow)))
        
        window?.setFrame(window?.frame ?? .zero, display: true)
    }
}
