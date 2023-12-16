//
//  SendInfo.swift
//  BatteryWebhook
//
//  Created by Stella Luna on 12/14/23.
//

import Foundation
import BatteryWebhookCore

/**
 BatteryWebhookPkg's way of sending power info to a supported service
 */
public class BatteryWebhookSendInfo {
    
    public static func sendDiscord(sendUrl: String, payload: BatteryWebhookServices.DiscordService.DiscordPayload) {
        try! _ = BatteryWebhookNetworking.jsonPost(sendUrl: sendUrl, dataToPost: payload)
    }
}
