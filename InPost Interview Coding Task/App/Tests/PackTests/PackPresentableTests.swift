@testable import Pack
import XCTest

final class PackPresentableTests: XCTestCase {
    func test_init_basicValues() {
        let sut = PackPresentable(dto: .build(id: "123", sender: "some sender"))

        XCTAssertEqual(sut.id, "123")
        XCTAssertEqual(sut.packageNumber, "123")
        XCTAssertEqual(sut.sender, "some sender")
    }

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
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.returnedToSender))).status, "Zwrot do Nadawcy")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.avizo))).status, "Pozostawiono Awizo")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.outForDelivery))).status, "Wydana do doręczenia")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.readyToPickup))).status, "Gotowa do odbioru")
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.pickupTimeExpired))).status, "Upłynął termin odbioru")
    }

    func test_init_image() {
        XCTAssertEqual(PackPresentable(dto: .build(shipmentType: .unsupported)).image, nil)
        XCTAssertEqual(PackPresentable(dto: .build(shipmentType: .supported(.courier))).image, PackListAssets.Images.courier)
        XCTAssertEqual(PackPresentable(dto: .build(shipmentType: .supported(.parcelLocker))).image, PackListAssets.Images.parcelLocker)
    }
}
