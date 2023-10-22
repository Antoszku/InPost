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
        XCTAssertEqual(PackPresentable(dto: .build(shipmentType: .unsupported)).icon, nil)
        XCTAssertEqual(PackPresentable(dto: .build(shipmentType: .supported(.courier))).icon, PackListAssets.Images.courier)
        XCTAssertEqual(PackPresentable(dto: .build(shipmentType: .supported(.parcelLocker))).icon, PackListAssets.Images.parcelLocker)
    }

    func test_init_packState() {
        XCTAssertEqual(PackPresentable(dto: .build(status: .unsupported)).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.created))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.notReady))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.confirmed))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.adoptedAtSourceBranch))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.sentFromSourceBranch))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.adoptedAtSortingCenter))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.sentFromSortingCenter))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.other))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.delivered))).packState, .deliveryCompleted)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.returnedToSender))).packState, .deliveryCompleted)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.avizo))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.outForDelivery))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.readyToPickup))).packState, .inTransit)
        XCTAssertEqual(PackPresentable(dto: .build(status: .supported(.pickupTimeExpired))).packState, .deliveryCompleted)
    }

    func test_init_packDateIsNil_whenAllDatesAreNil() {
        XCTAssertEqual(PackPresentable(dto: .build(expiryDate: nil, pickupDate: nil, storedDate: nil)).packDateStatus, nil)
    }

    func test_init_packDate_whenPickupDateIsNotNil() {
        let calendar = Calendar.current
        let startOfYear2020 = calendar.date(from: DateComponents(year: 2020, month: 1, day: 2, hour: 15, minute: 20))!

        let expectedValue = PackPresentable.PackDateStatus(title: "Odebrana", date: "czw. | 02.01.20 | 15:20")
        XCTAssertEqual(PackPresentable(dto: .build(pickupDate: startOfYear2020)).packDateStatus, expectedValue)
    }

    func test_init_packDate_whenExpiryDateIsNotNil() {
        let calendar = Calendar.current
        let startOfYear2020 = calendar.date(from: DateComponents(year: 2021, month: 2, day: 3, hour: 11, minute: 15))!

        let expectedValue = PackPresentable.PackDateStatus(title: "Czeka na odbiór do", date: "śr. | 03.02.21 | 11:15")
        XCTAssertEqual(PackPresentable(dto: .build(expiryDate: startOfYear2020)).packDateStatus, expectedValue)
    }
}
