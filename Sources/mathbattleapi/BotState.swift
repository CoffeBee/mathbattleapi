//
//  BotState.swift
//  mathbattleapi
//
//  Created by Podvorniy Ivan on 05.06.2020.
//

import Foundation
import WebSocketKit

public protocol BotState {
    var bot: Bot { get }
    mutating func onEvent(ws: WebSocket, data: Codable)
}
