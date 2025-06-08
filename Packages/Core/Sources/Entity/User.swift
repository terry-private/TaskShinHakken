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

    public init(id: ID, name: String) {
        self.id = id
        self.name = name
    }
}
