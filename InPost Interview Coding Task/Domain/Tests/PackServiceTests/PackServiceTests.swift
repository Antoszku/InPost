@testable import DataStorage
@testable import Networking
@testable import PackService
import XCTest

final class PackServiceTests: XCTestCase {
    func test_getArchivedPackIds() {
        let dataStorage = DataStorageStub()
        let sut = makeSut(dataStorage: dataStorage)

        sut.archivePackId("123")

        XCTAssertEqual(dataStorage.addValueToSetCalled?.0, "123")
        XCTAssertEqual(dataStorage.addValueToSetCalled?.1, .ArchivedPacks)
    }

    func test_getArchivedPackIdsCalled() {
        let dataStorage = DataStorageStub()
        let sut = makeSut(dataStorage: dataStorage)

        _ = sut.getArchivedPackIds()

        XCTAssertEqual(dataStorage.getStringSetCalledWithKey, .ArchivedPacks)
    }

    private func makeSut(apiClient: APIClient = APIClientStub(),
                         dataStorage: DataStorage = DataStorageStub()) -> PackService {
        DefaultPackService(apiClient: apiClient, dataStorage: dataStorage)
    }
}
