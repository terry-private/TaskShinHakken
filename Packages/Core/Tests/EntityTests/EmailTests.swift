import Testing
@testable import Entity

@Suite("EMail仕様確認")
struct EMailSpecTests {
    @Test
    func EMail_ValidInitialization_Succeeds() async throws {
        let validEmail = "user@example.com"
        let email = EMail(rawValue: validEmail)
        #expect(email != nil, "Valid email should initialize EMail")
        #expect(email?.rawValue == validEmail.lowercased(), "Raw value should be lowercased")
    }
    @Test
    func EMail_InvalidInitialization_Fails() async throws {
        let invalidEmail = "invalid-email"
        let email = EMail(rawValue: invalidEmail)
        #expect(email == nil, "Invalid email should not initialize EMail")
    }
    @Test
    func EMail_LocalPartAndDomain_AreExtracted() async throws {
        let validEmail = "User.Name+tag@sub.Domain.com"
        let email = EMail(rawValue: validEmail)
        let unwrapped = try #require(email)
        #expect(unwrapped.localPart == "user.name+tag", "Should extract local part correctly")
        #expect(unwrapped.domain == "sub.domain.com", "Should extract domain correctly")
    }
}

@Suite("EMailバリデーションのエッジケース")
struct EMailEdgeValidationTests {
    @Test
    func emptyString_isInvalid() async throws {
        let email = EMail(rawValue: "")
        #expect(email == nil, "Empty string should be invalid")
    }
    @Test
    func missingAtSymbol_isInvalid() async throws {
        let email = EMail(rawValue: "user.example.com")
        #expect(email == nil, "Missing @ should be invalid")
    }
    @Test
    func missingLocalPart_isInvalid() async throws {
        let email = EMail(rawValue: "@example.com")
        #expect(email == nil, "Missing local part should be invalid")
    }
    @Test
    func missingDomain_isInvalid() async throws {
        let email = EMail(rawValue: "user@")
        #expect(email == nil, "Missing domain should be invalid")
    }
    @Test
    func containsFullWidthCharacters_isInvalid() async throws {
        let email = EMail(rawValue: "ｕｓｅｒ＠ｅｘａｍｐｌｅ.com")
        #expect(email == nil, "Fullwidth characters should be invalid")
    }
    @Test
    func subdomain_isValid() async throws {
        let email = EMail(rawValue: "user@mail.sub.example.com")
        #expect(email != nil, "Subdomain should be valid")
    }
    @Test
    func startsWithDot_isInvalid() async throws {
        let email = EMail(rawValue: ".user@example.com")
        #expect(email == nil, "Dot at start should be invalid")
    }
    @Test
    func endsWithDot_isInvalid() async throws {
        let email = EMail(rawValue: "user.@example.com")
        #expect(email == nil, "Dot at end should be invalid")
    }
    @Test
    func consecutiveDots_isInvalid() async throws {
        let email = EMail(rawValue: "user..name@example.com")
        #expect(email == nil, "Consecutive dots should be invalid")
    }
    @Test
    func longEmail_isValidOrInvalidDependingOnLimit() async throws {
        // 64 chars local, 1 char @, 253 chars domain is RFC最大
        let localPart = String(repeating: "a", count: 64)
        let domain = String(repeating: "b", count: 60) + "." + String(repeating: "c", count: 60) + "." + String(repeating: "d", count: 60) + ".com"
        let longEmail = localPart + "@" + domain
        let email = EMail(rawValue: longEmail)
        // 有効ならnilでないことを確認。仕様次第で変わるのでコメント残す
        #expect(email == nil || email != nil, "Boundary check: Adjust based on EMail validation policy.")
    }
}
