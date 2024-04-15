// https://github.com/devxoul/CancelBag

import Combine
import class Foundation.NSLock

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public final class CancelBag: Cancellable {
    private let lock = NSLock()
    private var cancellables: [Cancellable] = []

    public init() {}

    internal func add(_ cancellable: Cancellable) {
        lock.lock()
        defer { self.lock.unlock() }
        cancellables.append(cancellable)
    }

    public func cancel() {
        lock.lock()
        let cancellables = cancellables
        self.cancellables.removeAll()
        lock.unlock()

        for cancellable in cancellables {
            cancellable.cancel()
        }
    }

    deinit {
        self.cancel()
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Cancellable {
    func cancel(with cancellable: CancelBag) {
        cancellable.add(self)
    }
}
