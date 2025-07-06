import Foundation

public struct User: Sendable, Identifiable {
    public struct ID: Sendable, Hashable, Codable, RawRepresentable, ExpressibleByStringLiteral {
        public let rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        public init(stringLiteral value: String) {
            self.init(rawValue: value)
        }
    }
    public var id: ID
    public var name: String
    public var isSetupCompleted: Bool
    public var setupCompletedAt: Date?

    public init(id: ID, name: String, isSetupCompleted: Bool = false, setupCompletedAt: Date? = nil) {
        self.id = id
        self.name = name
        self.isSetupCompleted = isSetupCompleted
        self.setupCompletedAt = setupCompletedAt
    }
}
