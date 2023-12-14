//
//  ViewController.swift
//  BWTest
//
//  Created by Stella Luna on 12/13/23.
//

import UIKit
import BatteryWebhook

class ViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var colorPicker: UIColorWell!
    
    
    @IBAction func testNetFunctionButton(_ sender: UIButton) {
        BatteryWebhookSendInfo.sendDiscord()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "Battery Webhook Core version " + String(describing: BatteryWebhookUtilities.getVersion())
        
        // Do any additional setup after loading the view.
    }


}

