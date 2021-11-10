import Foundation

public extension URLSession {
    var backport: Backport<URLSession> { .init(original: self) }
}

public extension Backport where Original: URLSession {
    /// Convenience method to load data using an URLRequest, creates and resumes an URLSessionDataTask internally.
    ///
    /// - Parameter request: The URLRequest for which to load data.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    @available(macOS, deprecated: 12.0, message: "No need for .backport any more")
    @available(iOS, deprecated: 15.0, message: "No need for .backport any more")
    @available(tvOS, deprecated: 15.0, message: "No need for .backport any more")
    @available(watchOS, deprecated: 8.0, message: "No need for .backport any more")
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        if #available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *) {
            return try await original.data(for: request, delegate: delegate)
        } else {
            precondition(delegate == nil, "Cannot set delegate")
            return try await withUnsafeThrowingContinuation { continuation in
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data, let response = response {
                        continuation.resume(returning: (data, response))
                    } else if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        fatalError("Neither response nor error")
                    }
                }
                task.resume()
            }
        }
    }

    /// Convenience method to load data using an URL, creates and resumes an URLSessionDataTask internally.
    ///
    /// - Parameter url: The URL for which to load data.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    @available(macOS, deprecated: 12.0, message: "No need for .backport any more")
    @available(iOS, deprecated: 15.0, message: "No need for .backport any more")
    @available(tvOS, deprecated: 15.0, message: "No need for .backport any more")
    @available(watchOS, deprecated: 8.0, message: "No need for .backport any more")
    func data(from url: URL, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        if #available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *) {
            return try await original.data(from: url, delegate: delegate)
        } else {
            return try await data(for: URLRequest(url: url), delegate: delegate)
        }
    }
}
