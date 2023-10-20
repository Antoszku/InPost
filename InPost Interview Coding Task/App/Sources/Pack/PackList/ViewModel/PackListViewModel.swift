import Foundation
import PackService

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
            case let .success(packs):
                // TODO: remove task after change to async await
                Task {
                    await self.setState(.data(packs: packs.map { PackPresentable(dto: $0) }))
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
