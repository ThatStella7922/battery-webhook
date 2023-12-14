//
//  SendInfo.swift
//
//
//  Created by Stella Luna on 12/14/23.
//

import Foundation
import BatteryWebhookCore

public class BatteryWebhookSendInfo {
    public static func sendDiscord() {
        let test = DiscordService.DiscordMessageObj(content: "the crinkly")
        
        try! BatteryWebhookNetworking.jsonPost(sendUrl: "https://discord.com/api/webhooks/1031569089157681152/MV9_sStrZbjGQVA_MFdPE2i5a6SBvRTfkZSIig2fB28ADnzYsEankfvJH8VriNTivrBe", dataToPost: test)
    }
}
