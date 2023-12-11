//
//  MacWelcomeView.swift
//  battery-webhook
//
//  Created by Stella Luna on 12/8/23.
//

#if os(macOS)
import Cocoa
import Foundation

class MacWelcomeViewController: NSViewController {
    var ProdNameHeroLabel = NSLabel(labelWithString: "\(prodName)")
    var ConfigureButton = NSButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("[Initialization] MacWelcomeViewController starting up...")
        setupUIElements()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setupUIElements() {
        NSLog("[MacWelcomeViewController] Initializing view contents...")
        self.view.addSubview(ProdNameHeroLabel)
    }
    
}
#endif
