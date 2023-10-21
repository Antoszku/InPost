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
        var sections = [PacksSectionPresentable]()
        let inTransitPacks = packs.filter { $0.packState == .inTransit }
        let deliveryCompletedPacks = packs.filter { $0.packState == .deliveryCompleted }

        if inTransitPacks.count > 0 {
            sections.append(PacksSectionPresentable(packState: .inTransit, packs: inTransitPacks))
        }

        if deliveryCompletedPacks.count > 0 {
            sections.append(PacksSectionPresentable(packState: .deliveryCompleted, packs: deliveryCompletedPacks))
        }
        return sections
    }
}
