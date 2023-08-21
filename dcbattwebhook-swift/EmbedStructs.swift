//
//  EmbedStructs.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/25/22.
//

import Foundation


//
// Discord Structs
//
/**
 Author block to be used in a `DiscordEmbed`
 
 Supply `name` and `icon_url` as strings.
 [View on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/structure/embed/author.html)
 */
struct DiscordAuthor: Codable {
    var name: String?
    var icon_url: String?
}

/**
 DiscordEmbed to be used in a `DiscordMessageObj`.
 
 This object can contain a `DiscordAuthor`, `DiscordFooter`, title, decimal color value, and more. See the struct definition and the link below for more.
 
 You can supply multiple `DiscordEmbed`s in a `DiscordMessageObj` to provide multiple embeds with a single web request.
 
 [View on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/structure/embeds.html)
 */
struct DiscordEmbed: Codable {
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
struct DiscordEmbedField: Codable {
    var name: String
    var value: String
    var inline: Bool
}

/**
 Footer block to be used in a `DiscordEmbed`
 
 Supply `text` and `icon_url` as strings.
 [View on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/structure/embed/footer.html)
 */
struct DiscordFooter: Codable {
    var text: String?
    var icon_url: String?
}

/**
 Footer block to be used in a `DiscordEmbed`
 
 Supply `text` and `icon_url` as strings.
 [View on Discord Webhooks Guide](https://birdie0.github.io/discord-webhooks-guide/discord_webhook.html)
 */
struct DiscordMessageObj: Codable {
    var embeds: [DiscordEmbed]?
    var contents: String?
    var username: String? // overrides the predefined username of the webhook
    var avatar_url: String? // overrides the predefined avatar of the webhook
}


//
// Structs for other services below
//
