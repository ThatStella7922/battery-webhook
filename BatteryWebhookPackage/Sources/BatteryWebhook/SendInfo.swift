//
//  SendInfo.swift
//  BatteryWebhook
//
//  Created by Stella Luna on 12/14/23.
//

import Foundation
import BatteryWebhookCore

public class BatteryWebhookSendInfo {
    public static func sendDiscord(sendUrl: String, dataToPost: DiscordService.DiscordMessageObj) {
        try! _ = BatteryWebhookNetworking.jsonPost(sendUrl: sendUrl, dataToPost: dataToPost)
    }
}
