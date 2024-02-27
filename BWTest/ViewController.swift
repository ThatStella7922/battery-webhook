//
//  ViewController.swift
//  BWTest
//
//  Created by Stella Luna on 12/13/23.
//

import UIKit
import BatteryWebhookLib

class ViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func testNetFunctionButton(_ sender: UIButton) {
        let obj = BatteryWebhookServices.DiscordService.DiscordPayload(content: "gm")
        
        do {
            try BatteryWebhookSendInfo.sendDiscord(sendUrl: "https://discord.com/api/webhooks/1031569089157681152/MV9_sStrZbjGQVA_MFdPE2i5a6SBvRTfkZSIig2fB28ADnzYsEankfvJH8VriNTivrB", payload: obj)
        } catch BatteryWebhookServices.DiscordService.DiscordNetworkError.intermediary(let errorObj) {
            print("[ViewController] Discord Network Error: \(errorObj.message) with code \(errorObj.code)")
            errorLabel.text = "Discord Network Error: \(errorObj.message)\nError code: \(errorObj.code)"
        } catch BatteryWebhookNetworking.NetworkingError.systemError(let errorText){
            print("[ViewController] System Error: \(errorText)")
            errorLabel.text = "[ViewController] System Error: \(errorText)"
        } catch {
            print("[ViewController] Unhandled Error: \(error)")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "Battery Webhook Core version " + String(describing: BatteryWebhookUtilities.getVersion())
        
        // Do any additional setup after loading the view.
    }


}

