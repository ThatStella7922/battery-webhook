//
//  TestView.swift
//  battery-webhook
//
//  Created by Stella Luna on 12/8/23.
//

#if os(iOS)
import UIKit
import Foundation

class IOSViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("[Initialization] \(prodName) IOSViewController starting up")
        setupView()
    }
    
    func setupView(){
        self.view.backgroundColor = .green
    }
}
#endif
