import SwiftUI
import FirebaseCore

@main
struct PULSEApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
