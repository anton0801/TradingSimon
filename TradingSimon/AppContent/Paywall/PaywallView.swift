import SwiftUI

struct PaywallView: View {
    
    @EnvironmentObject var stockApiManager: StocksApiManager
    @StateObject var subscriptionManager = SubscriptionsManager()
    @State var alertVisible = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: LessonsView()
                        .environmentObject(stockApiManager)
                        .navigationBarBackButtonHidden()) {
                        Image("close")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal)
                
                Text("Learn how\nto trade now!")
                    .multilineTextAlignment(.center)
                    .font(.custom("TTCommons-Bold", size: 32))
                    .foregroundColor(.white)
                    .padding(.top, 42)
                
                HStack {
                    Image("check")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("+3 Lessons")
                        .font(.custom("TTCommons-Medium", size: 20))
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal, 42)
                .padding(.top, 32)
                
                HStack {
                    Image("check")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Learning from scratch")
                        .font(.custom("TTCommons-Medium", size: 20))
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal, 42)
                .padding(.top, 4)
                
                HStack {
                    Image("check")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Practical exercises")
                        .font(.custom("TTCommons-Medium", size: 20))
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal, 42)
                .padding(.top, 4)
                
                HStack {
                    Image("check")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Explanation of the approach")
                        .font(.custom("TTCommons-Medium", size: 20))
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal, 42)
                .padding(.top, 4)
                
                
                HStack {
                    Image("check")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Explanation of the strategy")
                        .font(.custom("TTCommons-Medium", size: 20))
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal, 42)
                .padding(.top, 4)
                
                Spacer()
                
                Button {
                    if !subscriptionManager.products.isEmpty {
                        Task {
                            await subscriptionManager.buyProduct(subscriptionManager.products[0])
                        }
                    } else {
                        
                    }
                } label: {
                    Text("Try it for Free")
                        .font(.custom("TTCommons-Bold", size: 24))
                        .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                        .frame(width: 300)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 42, style: .continuous)
                                .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                        )
                }
                
                Text("3 Days free, then 3$ per month. Easily cancel anytime on app store. You won't be charge now.")
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .font(.custom("TTCommons-Medium", size: 12))
                    .foregroundColor(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                    .padding(.leading)
                    .padding(.top, 4)
            }
            .background(
                Rectangle()
                    .fill(Color(red: 0, green: 0, blue: 31/255))
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
            .alert(isPresented: $alertVisible, content: {
                Alert(title: Text("Failed buy subscription"),
                message: Text("Subscription doen't loaded! Try it again more later!"))
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    PaywallView()
        .environmentObject(StocksApiManager())
}
