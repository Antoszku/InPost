import Foundation
import PackService

final class PackListViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case data(sections: [PacksSectionPresentable])
    }

    private let interactor: PackListInteractor

    init(interactor: PackListInteractor) {
        self.interactor = interactor
    }

    @Published var state = State.loading

    func onAppear() async {
        await loadData()
    }

    func onPullToRefresh() async {
        await loadData()
    }

    @MainActor
    private func setState(_ state: State) {
        self.state = state
    }

    private func loadData() async {
        do {
            await setState(.loading)
            let packs = try await interactor.getPacks()
            let sections = buildSection(from: packs)
            await setState(.data(sections: sections))
        } catch {
            // TODO: Handle Error
        }
    }

    private func buildSection(from packs: [PackPresentable]) -> [PacksSectionPresentable] {
        let sortedPacks = sortPacks(packs)
        var sections = [PacksSectionPresentable]()
        let inTransitPacks = sortedPacks.filter { $0.packState == .inTransit }
        let deliveryCompletedPacks = sortedPacks.filter { $0.packState == .deliveryCompleted }

        if inTransitPacks.count > 0 {
            sections.append(PacksSectionPresentable(packState: .inTransit, packs: inTransitPacks))
        }

        if deliveryCompletedPacks.count > 0 {
            sections.append(PacksSectionPresentable(packState: .deliveryCompleted, packs: deliveryCompletedPacks))
        }
        return sections
    }

    private func sortPacks(_ packs: [PackPresentable]) -> [PackPresentable] {
        packs.sorted(by: {
            $0.sortOrderNumber < $1.sortOrderNumber
                || $0.pickupDate ?? .distantPast > $1.pickupDate ?? .distantPast
                || $0.expiryDate ?? .distantPast < $1.expiryDate ?? .distantPast
                || $0.storedDate ?? .distantPast > $1.storedDate ?? .distantPast
                || $0.id < $1.id
        })
    }
}
