import XCTest
@testable import Crickos

final class CountryDecodingTests: XCTestCase {
    func testDecodeCountry() throws {
        let json = """
        {
            "resource": "countries",
            "id": 1,
            "continent_id": 5,
            "name": "Testland",
            "image_path": "https://example.com/test.png",
            "updated_at": "2023-01-01T00:00:00+00:00"
        }
        """.data(using: .utf8)!

        let country = try JSONDecoder().decode(Country.self, from: json)
        XCTAssertEqual(country.id, 1)
        XCTAssertEqual(country.name, "Testland")
        XCTAssertEqual(country.image_path, "https://example.com/test.png")
    }
}
