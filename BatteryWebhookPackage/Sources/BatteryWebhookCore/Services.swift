//
//  BatteryWebhookServices.swift
//  BatteryWebhookCore
//
//  Created by Stella Luna on 12/11/23.
//

import Foundation

public class DiscordService {
    init() {
        print("in init()")
    }
    
    /**
     Author block to be used in a `DiscordEmbed`
     
     Supply `name` and `icon_url` as strings.
     [View on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/structure/embed/author.html)
     */
    public struct DiscordAuthor: Encodable {
        public init(name: String? = nil, icon_url: String? = nil) {
            self.name = name
            self.icon_url = icon_url
        }
        
        var name: String?
        var icon_url: String?
    }
    
    /**
     DiscordEmbed to be used in a `DiscordMessageObj`.
     
     This object can contain a `DiscordAuthor`, `DiscordFooter`, title, decimal color value, and more. See the struct definition and the link below for more.
     
     You can supply multiple `DiscordEmbed`s in a `DiscordMessageObj` to provide multiple embeds with a single web request.
     
     [View on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/structure/embeds.html)
     */
    public struct DiscordEmbed: Encodable {
        public init(author: DiscordAuthor? = nil, footer: DiscordFooter? = nil, title: String? = nil, description: String? = nil, color: Int? = nil, fields: [DiscordEmbedField]? = nil) {
            self.author = author
            self.footer = footer
            self.title = title
            self.description = description
            self.color = color
            self.fields = fields
        }
        
        var author: DiscordAuthor?
        var footer: DiscordFooter?
        var title: String?
        var description: String?
        var color: Int?
        var fields: [DiscordEmbedField]?
    }
    
    /**
     Field block to be used in a `DiscordEmbed`
     
     [See on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/structure/embed/fields.html)
     */
    public struct DiscordEmbedField: Encodable {
        public init(name: String? = nil, value: String? = nil, inline: Bool? = nil) {
            self.name = name
            self.value = value
            self.inline = inline
        }
        
        var name: String?
        var value: String?
        var inline: Bool?
    }
    
    /**
     Footer block to be used in a `DiscordEmbed`
     
     Supply `text` and `icon_url` as strings.
     [View on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/structure/embed/footer.html)
     */
    public struct DiscordFooter: Encodable {
        public init(text: String? = nil, icon_url: String? = nil) {
            self.text = text
            self.icon_url = icon_url
        }
        
        var text: String?
        var icon_url: String?
    }
    
    /**
     Footer block to be used in a `DiscordEmbed`
     
     Supply `text` and `icon_url` as strings.
     [View on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/discord_webhook.html)
     */
    public struct DiscordMessageObj: Encodable {
        public init(embeds: [DiscordEmbed]? = nil, content: String? = nil, username: String? = nil, avatar_url: String? = nil) {
            self.embeds = embeds
            self.content = content
            self.username = username
            self.avatar_url = avatar_url
        }
        
        var embeds: [DiscordEmbed]?
        var content: String?
        var username: String? // overrides the predefined username of the webhook
        var avatar_url: String? // overrides the predefined avatar of the webhook
    }
}
