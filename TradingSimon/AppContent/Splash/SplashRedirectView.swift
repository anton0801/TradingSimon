import SwiftUI

struct SplashRedirectView: View {
    
    @EnvironmentObject var stockApiManager: StocksApiManager
    
    var body: some View {
        VStack {
            if !UserDefaults.standard.bool(forKey: "is_not_first_launched_app") {
                PaywallView()
                    .environmentObject(stockApiManager)
                    .onAppear {
                        UserDefaults.standard.set(true, forKey: "is_not_first_launched_app")
                    }
            } else {
                ContentView()
                    .environmentObject(stockApiManager)
            }
        }
    }
}

#Preview {
    SplashRedirectView()
        .environmentObject(StocksApiManager())
}
