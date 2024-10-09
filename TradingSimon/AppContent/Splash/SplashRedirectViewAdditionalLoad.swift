import SwiftUI

struct SplashRedirectViewAdditionalLoad: View {
    
    @EnvironmentObject var stocksApiManager: StocksApiManager
    
    var body: some View {
        VStack {
            if UserDefaults.standard.string(forKey: "response_l_client") == nil {
                ContentView()
                    .environmentObject(stocksApiManager)
            } else {
                TradingContentView()
            }
        }
    }
}

#Preview {
    SplashRedirectViewAdditionalLoad()
        .environmentObject(StocksApiManager())
}
