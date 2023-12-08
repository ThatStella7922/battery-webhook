//
//  AppDelegate.swift
//  battery-webhook
//
//  Created by Stella Luna on 12/8/23.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        window = NSWindow(
                    contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
                    styleMask: [.miniaturizable, .titled],
                    backing: .buffered, defer: false)
        window.center()
        window.title = "i have a window"
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

