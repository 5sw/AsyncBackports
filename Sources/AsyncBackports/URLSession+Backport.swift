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
        return try await original.data(for: request, delegate: delegate)
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
        return try await original.data(from: url, delegate: delegate)
    }
}
