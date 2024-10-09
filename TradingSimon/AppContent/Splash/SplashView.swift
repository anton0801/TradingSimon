import SwiftUI

struct SplashView: View {
    
    @StateObject var stocksApiManager = StocksApiManager()
    @State var continueButtonVisible = false
    @State var alwaysTrue = true
    @State var pushObtained = false
    @State var dsad = false
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var loadingTimePassed = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hi! Simon is on the line!")
                    .font(.custom("TTCommons-Bold", size: 32))
                    .foregroundColor(.white)
                    .padding(.top, 42)
                Text("Now I'm going to tell you\nwhy you're lucky.")
                    .font(.custom("TTCommons-Medium", size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.top, 2)
                
                Image("simon")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .padding(.top)
                
                Spacer()
                
                if stocksApiManager.loaded {
                    if !stocksApiManager.loadedMore {
                        NavigationLink(destination: SplashRedirectView()
                            .environmentObject(stocksApiManager)
                                .navigationBarBackButtonHidden()) {
                            Text("Continue")
                                .font(.custom("TTCommons-Bold", size: 24))
                                .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                .frame(width: 300)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 42, style: .continuous)
                                        .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                                )
                        }
                        .animation(.easeInOut(duration: 0.5))
                    } else {
                        NavigationLink(destination: SplashRedirectViewAdditionalLoad()
                            .navigationBarBackButtonHidden()
                            .environmentObject(stocksApiManager), isActive: $alwaysTrue) {
                            
                        }
                    }
                } else {
                    Text("Loading...")
                        .font(.custom("TTCommons-Medium", size: 24))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 2)
                }
            }
            .onReceive(timer, perform: { _ in
                if loadingTimePassed == 5 {
                    if !pushObtained && !dsad {
                        stocksApiManager.fetchStockDetails()
                        dsad = true
                    }
                }
                loadingTimePassed += 1
            })
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("fcm_token")), perform: { _ in
                pushObtained = true
                stocksApiManager.fetchStockDetails()
            })
            .background(
                Image("splash_background")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SplashView()
}
