import Foundation

public struct EMail: Hashable, Codable, Sendable, RawRepresentable {

    public let rawValue: String

    public init?(rawValue: String) {
        // HTML Living Standardに準拠したバリデーション
        guard Self.isValid(email: rawValue) else {
            return nil
        }
        self.rawValue = rawValue.lowercased()
    }

    /// メールアドレスの形式がHTML Living Standardの基準で有効かどうかを判定します。
    /// - Parameter email: チェックする文字列
    /// - Returns: 有効な場合はtrue、そうでない場合はfalse
    internal static func isValid(email: String) -> Bool {
        // WHATWG HTML Living Standardで推奨されている正規表現
        // https://html.spec.whatwg.org/multipage/input.html#e-mail-state-(type=email)
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

// MARK: - 使いやすさのための準拠

extension EMail: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}

// MARK: - ドメインやローカルパートの取得

public extension EMail {
    var localPart: String {
        // @で分割した最初の要素を返す。@が含まれていることはisValidで保証済み。
        return rawValue.components(separatedBy: "@")[0]
    }

    var domain: String {
        // @で分割した2番目の要素を返す。
        return rawValue.components(separatedBy: "@")[1]
    }
}
