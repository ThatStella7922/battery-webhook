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
        let visualEffect = NSVisualEffectView()
        visualEffect.blendingMode = .behindWindow
        visualEffect.state = .active
        visualEffect.material = .sidebar
        self.view = visualEffect
    }
}
#endif
