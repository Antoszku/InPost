@testable import DataStorage
import XCTest

final class DataStorageTests: XCTestCase {
    func test_getStringSet_callUserDefaultsWithCorrectKey() {
        let defaults = UserDefaultsStub()
        let sut = makeSut(defaults: defaults)

        _ = sut.getStringSet(forKey: .ArchivedPacks)

        XCTAssertEqual(defaults.stringArrayCalledWithKey, "ArchivedPacks")
    }

    func test_getStringSet_returnSetOfStrings() {
        let defaults = UserDefaultsStub()
        let sut = makeSut(defaults: defaults)
        defaults.stringArrayReturn = ["1", "2", "3"]

        let result = sut.getStringSet(forKey: .ArchivedPacks)

        let exptectedResult: Set<String> = ["1", "2", "3"]
        XCTAssertEqual(result, exptectedResult)
    }

    func test_addValueToSet_callDefaultsSet() {
        let defaults = UserDefaultsStub()
        let sut = makeSut(defaults: defaults)

        sut.addValueToSet("1", forKey: .ArchivedPacks)

        XCTAssertEqual(defaults.setCalledWithValues?.0, "ArchivedPacks")
        XCTAssertEqual(defaults.setCalledWithValues?.1, ["1"])
    }

    func test_addValueToSet_callDefaultsSet_withValuesThatWasSetBefore() {
        let defaults = UserDefaultsStub()
        let sut = makeSut(defaults: defaults)
        defaults.stringArrayReturn = ["1"]

        sut.addValueToSet("2", forKey: .ArchivedPacks)

        XCTAssertEqual(defaults.setCalledWithValues?.0, "ArchivedPacks")
        XCTAssertEqual(defaults.setCalledWithValues?.1.sorted(), ["1", "2"].sorted())
    }

    func test_addValueToSet_callDefaultsSet_withUniqueValues() {
        let defaults = UserDefaultsStub()
        let sut = makeSut(defaults: defaults)
        defaults.stringArrayReturn = ["2"]

        sut.addValueToSet("2", forKey: .ArchivedPacks)

        XCTAssertEqual(defaults.setCalledWithValues?.0, "ArchivedPacks")
        XCTAssertEqual(defaults.setCalledWithValues?.1, ["2"])
    }

    private func makeSut(defaults: UserDefaultsProtocol = UserDefaultsStub()) -> DataStorage {
        DefaultDataStorage(defaults: defaults)
    }
}
