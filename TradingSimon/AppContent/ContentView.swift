import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var stockApiManager: StocksApiManager
    @StateObject var assetsManager = AssetsManager()
    
    init() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Image("main_assets_bg")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height + 25)
                .ignoresSafeArea()
            
            TabView {
                AssetsView()
                    .environmentObject(stockApiManager)
                    .environmentObject(assetsManager)
                    .tabItem {
                        Image("home")
                    }
//                AssetsView()
//                    .environmentObject(stockApiManager)
//                    .environmentObject(portfolioManager)
//                    .tabItem {
//                        Image("analytics")
//                    }
                CoursesView()
                    .tabItem {
                        Image("lessons")
                    }
                MarketView()
                    .environmentObject(stockApiManager)
                    .environmentObject(assetsManager)
                    .tabItem {
                        Image("market")
                    }
                ProfileView()
                    .tabItem {
                        Image("profile")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(StocksApiManager())
}
