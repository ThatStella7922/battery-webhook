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
        NSLog("[Initialization] MacViewController starting up...")
        setupBlur()
        setupSidebar()
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
    
    
    func setupSidebar() {
        NSLog("[MacViewController] Initializing window splitview...")
        let splitView = MainSplitViewController()
        self.view.addSubview(splitView.view)
    }
}

class MainSplitViewController: NSSplitViewController {
    private let splitViewResorationIdentifier = "com.company.restorationId:mainSplitViewController"
    
    lazy var vcA = MacWelcomeViewController()
    lazy var vcB = MacWelcomeViewController()

    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupUI() {
        
        view.wantsLayer = true
        
        splitView.dividerStyle = .paneSplitter
        splitView.autosaveName = NSSplitView.AutosaveName(rawValue: splitViewResorationIdentifier)
        splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: splitViewResorationIdentifier)
    }

    private func setupLayout() {
        
        minimumThicknessForInlineSidebars = 180
        
        let itemA = NSSplitViewItem(sidebarWithViewController: vcA)
        itemA.minimumThickness = 80
        addSplitViewItem(itemA)
        
        let itemB = NSSplitViewItem(contentListWithViewController: vcB)
        itemB.minimumThickness = 100
        addSplitViewItem(itemB)
    }
}
#endif
