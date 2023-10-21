import App
import SwiftUI
import UI

@main
struct InPostApp: App {
    private let assembler = MainAssembler()

    init() {
        FontRegistration().register()
    }

    var body: some Scene {
        WindowGroup {
            MainView(resolver: assembler.resolver)
        }
    }
}
