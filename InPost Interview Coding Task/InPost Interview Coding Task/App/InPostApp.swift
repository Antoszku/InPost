import Pack
import SwiftUI
import UI

@main
struct InPostApp: App {
    init() {
        FontRegistration().register()
    }

    var body: some Scene {
        WindowGroup {
            PackListView()
        }
    }
}
