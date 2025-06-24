import CxxStdlib
// import func src_sample_library.MyFunction
import PrintHello
import SwiftUI

@main
struct BazelApp: App {
    var body: some Scene {
        WindowGroup {
            Text(String(hermes.PrintHello()))
        }
    }
}
