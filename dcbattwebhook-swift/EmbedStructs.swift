//
//  EmbedStructs.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/25/22.
//

import Foundation

//Struct for the json contents
struct MsgAuthor: Codable {
    var name: String?
    var icon_url: String?
}

struct MsgEmbed: Codable {
    var author: MsgAuthor?
    var footer: MsgFooter?
    var title: String?
    var description: String?
    var color: Int?
    var fields: [MsgField]?
}

struct MsgField: Codable {
    var name: String
    var value: String
    var inline: Bool
}

struct MsgFooter: Codable {
    var text: String?
    var icon_url: String?
}

struct MessageObj: Codable {
    var embeds: [MsgEmbed]?
    var contents: String?
}
