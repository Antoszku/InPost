import PackService
import Foundation

final class PackViewModel: ObservableObject {

    enum State {
        case loading
        case data(packs: [PackPresentable])
    }

    private let packNetworking = PackNetworking()

    @Published var state = State.loading

    func onAppear() {
        packNetworking.getPacks { result in
            switch result {
            case .success(let packs):
                // TODO: remove task after change to async await
                Task {
                    await self.setState(.data(packs: packs.map { PackPresentable.init(id: $0.id, status: $0.status, sender: $0.sender) }))
                }

            case .failure:
                break
                // TODO: Handle Error
            }
        }
    }

    @MainActor
    private func setState(_ state: State) {
        self.state = state
    }
}
