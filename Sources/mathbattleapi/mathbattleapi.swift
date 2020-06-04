import WebSocketKit
import NIO

class APIWebSocketController {
    init() {
    }
    func run() throws {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        let promise = eventLoopGroup.next().makePromise(of: String.self)

        WebSocket.connect(to: "ws://127.0.0.1:8080", on: eventLoopGroup) { ws in
            ws.send("HI")
            ws.onText { ws, text in
                print(text)
            }
        }.cascadeFailure(to: promise)
        _ = try promise.futureResult.wait()
    }
}
