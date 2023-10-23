import Foundation
import PackService

final class PackListViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case data(sections: [PacksSectionPresentable])
    }

    @Published var state = State.loading
    @Published var expandedPackCell: PackPresentable? {
        didSet {
            if expandedPackCell == oldValue {
                expandedPackCell = nil
            }
        }
    }

    private let packPresentableSorter = PackPresentableSorter()
    private let interactor: PackListInteractor
    private var packs = [PackPresentable]()

    init(interactor: PackListInteractor) {
        self.interactor = interactor
    }

    func onAppear() async {
        await loadData()
    }

    func onPullToRefresh() async {
        await loadData()
    }

    func isExpandedPackCell(_ pack: PackPresentable) -> Bool {
        expandedPackCell == pack
    }

    func onArchivePack(_ pack: PackPresentable) async {
        guard let index = packs.firstIndex(where: { $0.id == pack.id }) else { return }

        interactor.archivePack(pack.id)
        packs.remove(at: index)
        await buildSection()
    }

    @MainActor
    private func setState(_ state: State) {
        self.state = state
    }

    private func loadData() async {
        do {
            await setState(.loading)
            let packs = try await interactor.getPacks()
            let filteredPacks = filterArchivedPacks(packs)
            self.packs = filteredPacks
            await buildSection()
        } catch {
            // TODO: Handle Error
        }
    }

    private func buildSection() async {
        let sortedPacks = packPresentableSorter.sortPacks(packs)
        var sections = [PacksSectionPresentable]()
        let inTransitPacks = sortedPacks.filter { $0.packState == .inTransit }
        let deliveryCompletedPacks = sortedPacks.filter { $0.packState == .deliveryCompleted }

        if inTransitPacks.count > 0 {
            sections.append(PacksSectionPresentable(packState: .inTransit, packs: inTransitPacks))
        }

        if deliveryCompletedPacks.count > 0 {
            sections.append(PacksSectionPresentable(packState: .deliveryCompleted, packs: deliveryCompletedPacks))
        }
        await setState(.data(sections: sections))
    }

    private func filterArchivedPacks(_ packs: [PackPresentable]) -> [PackPresentable] {
        let archivedPackIds = interactor.getArchivedPackIds()
        let filteredPacks = packs.filter { !archivedPackIds.contains($0.id) }
        return filteredPacks
    }
}
