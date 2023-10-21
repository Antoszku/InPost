import Foundation
import PackService

final class PackListViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case data(packs: [PackPresentable])
    }

    private let interactor: PackListInteractor

    init(interactor: PackListInteractor) {
        self.interactor = interactor
    }

    @Published var state = State.loading

    func onAppear() async {
        do {
            let packs = try await interactor.getPacks()
            await setState(.data(packs: packs))
        } catch {
            // TODO: Handle Error
        }
    }

    @MainActor
    private func setState(_ state: State) {
        self.state = state
    }
}
