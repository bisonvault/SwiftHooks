public protocol Plugin: class { }

extension Plugin {
    var commands: [Command] {
        return Mirror(reflecting: self)
            .children
            .compactMap { child in
                if let value = child.value as? Command {
                    return value
                }
                return nil
            }
    }
    
    func registerListeners(to h: SwiftHooks) {
        Mirror(reflecting: self)
            .children
            .compactMap { $0.value as? _Listener }
            .forEach { listener in
                listener.register(to: h)
        }
    }
}