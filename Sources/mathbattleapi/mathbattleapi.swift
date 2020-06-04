import WebSocketKit
import NIO

public final class APIWebSocketController {
    
    let token: String
    let api_url: String
    
    public init(token: String, api_url: String = "api.math.silaeder.ru") {
        self.token = token
        self.api_url = api_url
    }
    public func run() throws {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        let promise = eventLoopGroup.next().makePromise(of: String.self)

        WebSocket.connect(to: "ws://\(self.api_url)/bot/ws", on: eventLoopGroup) { ws in
            ws.send(self.token)
            ws.onText { ws, text in
                if (text == "AUTH_FAILED") {
                    print("Auth failed")
                }
                else {
                    print("Auth success")
                }
            }
        }.cascadeFailure(to: promise)
        _ = try promise.futureResult.wait()
    }
}
