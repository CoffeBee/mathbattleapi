//
//  Chat.swift
//  mathbattleapi
//
//  Created by Podvorniy Ivan on 05.06.2020.
//

import Foundation
import AsyncHTTPClient

open class Chat {
    
    var bot: Bot
    
    public init(bot: Bot) {
        self.bot = bot
    }
    
    final public func sendMessage(httpClient: HTTPClient, text: String) throws {
        
    }
    
    final public func addMember(httpClient: HTTPClient, user: User) throws {
        var request = try HTTPClient.Request(url: "http://\(self.bot.api_url)/bot/chats/add", method: .POST)
        request.headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        self.bot.httpClient!.execute(request: request).whenComplete { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                if response.status == .ok {
                    
                } else {
                    print("Error occures while sending message", response.body)
                }
            }
        }
    }
    
    
}
