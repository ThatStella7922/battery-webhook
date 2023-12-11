//
//  MacViewController.swift
//  battery-webhook
//
//  Created by Stella Luna on 12/8/23.
//

#if os(macOS)
import Cocoa
import Foundation

class MacViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("[Initialization] MacViewController setting up view...")
        setupBlur()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setupBlur() {
        NSLog("[MacViewController] Initializing window background blur...")
        if #available(macOS 10.10, *) {
            let visualEffect = NSVisualEffectView()
            visualEffect.blendingMode = .behindWindow
            visualEffect.state = .active
            if #available(macOS 10.11, *) {
                visualEffect.material = .sidebar
            } else {
                visualEffect.material = .mediumLight
            }
            self.view = visualEffect
        } else {
            NSLog("[MacViewController] Will not blur because this requires macOS 10.10+")
        }
        
    }
}
#endif
