//
//  ViewController.swift
//  BWTest
//
//  Created by Stella Luna on 12/13/23.
//

import UIKit
import BatteryWebhook
import BatteryWebhookCore

class ViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var colorPicker: UIColorWell!
    
    
    @IBAction func testNetFunctionButton(_ sender: UIButton) {
        let obj = BatteryWebhookServices.DiscordService.DiscordPayload(content: "gm")
        
        BatteryWebhookSendInfo.sendDiscord(sendUrl: "https://discord.com/api/webhooks/1031569089157681152/MV9_sStrZbjGQVA_MFdPE2i5a6SBvRTfkZSIig2fB28ADnzYsEankfvJH8VriNTivrBe", payload: obj)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "Battery Webhook Core version " + String(describing: BatteryWebhookUtilities.getVersion())
        
        // Do any additional setup after loading the view.
    }


}

