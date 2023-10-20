@testable import Pack
import XCTest

final class PackPresentableTests: XCTestCase {
    func test_init_status() {
        XCTAssertEqual(PackPresentable(dto: .build(status: .unsupported)).status, "Inne")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.created))).status, "Przesyłka utworzona")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.notReady))).status, "W trakcie przygotowania")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.confirmed))).status, "Odebrana od Nadawcy")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.adoptedAtSourceBranch))).status, "Przyjęta w Oddziale")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.sentFromSourceBranch))).status, "Wysłana z Oddziału")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.adoptedAtSortingCenter))).status, "Przyjęta w sortowni")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.sentFromSortingCenter))).status, "Wysłana z sortowni")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.other))).status, "Inne")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.delivered))).status, "Odebrana")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.returnedToSender))).status, "Zwrócona do Nadawcy")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.avizo))).status, "Awizo")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.outForDelivery))).status, "Wydana do doręczenia")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.readyToPickup))).status, "Gotowa do odbioru")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.pickupTimeExpired))).status, "Upłynął termin odbioru")
    }
}
