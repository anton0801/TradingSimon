import SwiftUI

@main
struct TradingSimonApp: App {
    
    @UIApplicationDelegateAdaptor(TradingSimonDelegate.self) var tradingSimonDelegate

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
