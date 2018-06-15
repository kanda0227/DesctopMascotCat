//
//  AppDelegate.swift
//  DMC
//
//  Created by Kanda Sena on 2018/05/04.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    @IBOutlet weak var mainMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let status = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        status.menu = mainMenu
        status.highlightMode = true
        status.image = NSImage(named: NSImage.Name("icon.png"))
        
        let menuItem = NSMenuItem()
        menuItem.title = "Quit"
        status.menu?.addItem(menuItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

