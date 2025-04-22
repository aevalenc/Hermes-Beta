import SwiftUI

import func src_sample_library.MyFunction

@main
struct BazelApp: App {
    var body: some Scene {
        WindowGroup {
            Text(MyFunction())
        }
    }
}
