//
//  mathbattleapi.swift
//  mathbattleapi
//
//  Created by Podvorniy Ivan on 04.06.2020.
//


import WebSocketKit
import AsyncHTTPClient
import NIO

enum BotAuthError: Error {
    case invalidToken
    case notCorrectToken
}

enum BotConfigError: Error {
    case noInitialState
}

public final class Bot {
    
    let token: String
    let api_url: String
    var ws: WebSocket?
    var httpClient: HTTPClient?
    var initialState: BotState?
    var authCompleted: Bool = false
    
    public init(token: String, api_url: String = "api.math.silaeder.ru") {
        self.token = token
        self.api_url = api_url
    }
    
    public func setInitialState(_ botState: BotState) {
        self.initialState = botState
    }
    
    public func run() throws {
        if (self.initialState == nil) {
            throw BotConfigError.noInitialState
        }
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        let promise = eventLoopGroup.next().makePromise(of: String.self)
        WebSocket.connect(to: "ws://\(self.api_url)/bot/ws", on: eventLoopGroup) { ws in
            ws.send(self.token)
            ws.onText { ws, text in
                if (text == "AUTH_FAILED") {
                    print("Auth failed")
                    ws.close()
                }
                else {
                    self.authCompleted = true
                    print("Auth success")
                }
            }
            self.ws = ws
        }.cascadeFailure(to: promise)
        self.httpClient = HTTPClient(eventLoopGroupProvider: .shared(eventLoopGroup))
        defer {
            try? self.httpClient?.syncShutdown()
        }
        _ = try promise.futureResult.wait()
        if (!self.authCompleted) {
            throw BotAuthError.notCorrectToken
        }
    }
}
