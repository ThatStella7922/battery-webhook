//
//  AppDelegate.swift
//  battery-webhook
//
//  Created by Stella Luna on 12/8/23.
//

#if os(macOS)
import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let macVC = MacViewController()
        window = NSWindow(
                    contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
                    styleMask: [.miniaturizable, .closable, .titled, .resizable],
                    backing: .buffered, defer: false)
        window.center()
        window.title = prodName
        window.contentView = macVC.view
        window.makeKeyAndOrderFront(nil)
        addMenuItems()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func addMenuItems() {
        NSLog("[Initialization] Setting up command menu items...")
        
        let debugMenu = NSMenuItem(title: "Debug", action: nil, keyEquivalent: "")
        debugMenu.submenu = NSMenu(title: "visible")
        debugMenu.submenu?.addItem(withTitle: "Quit",
                                   action: #selector(NSApplication.terminate(_:)),
                                   keyEquivalent: "q")
        NSApplication.shared.mainMenu?.addItem(debugMenu)
    }
}
#endif
