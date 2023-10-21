@testable import Pack
import XCTest

final class PackStateTests: XCTestCase {
    func test_sectionName() {
        XCTAssertEqual(PackState.inTransit.sectionName, "Gotowe do odbioru")
        XCTAssertEqual(PackState.deliveryCompleted.sectionName, "Pozostałe")
    }
}
