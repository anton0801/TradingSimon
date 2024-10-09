import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct StockDetailsView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var stocksApiManager: StocksApiManager
    @EnvironmentObject var assetsManager: AssetsManager
    
    var stockModel: StockModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        presMode.wrappedValue.dismiss()
                    } label: {
                        Image("back_button")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    
                    Spacer()
                    
                    Text(stockModel.name)
                        .multilineTextAlignment(.center)
                        .font(.custom("TTCommons-Bold", size: 26))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                let stockPrice = stocksApiManager.stockPrices.filter { $0.symbol == stockModel.ticker }[0].preMarket
                HStack {
                    WebImage(url: URL(string: "\(stockModel.branding.iconUrl)?apiKey=\(String.apiKey)"))
                        .resizable()
                        .frame(width: 52, height: 52)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(52)
                    
                    let assetSaved = assetsManager.assets.filter { $0.tiker == stockModel.ticker }
                    
                    VStack(alignment: .leading) {
                        Text("\(stockModel.name)")
                           .font(.custom("TTCommons-Medium", size: 24))
                           .foregroundColor(.white)
                        
                        if assetSaved.count > 0 {
                            Text("\(assetsManager.assets.filter { $0.tiker == stockModel.ticker }[0].count)")
                               .font(.custom("TTCommons-Medium", size: 18))
                               .foregroundColor(.white.opacity(0.7))
                        } else {
                            Text("0 stocks")
                               .font(.custom("TTCommons-Medium", size: 18))
                               .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    
                    Spacer()
                    
                    if assetSaved.count > 0 {
                        Text("$\((assetSaved[0].count * stockPrice).formattedToTwoDecimalPlaces())")
                           .font(.custom("TTCommons-Medium", size: 18))
                           .foregroundColor(.white.opacity(0.7))
                    } else {
                        Text("$0")
                           .font(.custom("TTCommons-Medium", size: 18))
                           .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(Color.init(red: 191/255, green: 183/255, blue: 253/255), lineWidth: 2)
                )
                .padding(.horizontal)
                
                TradingViewWebView(ticker: stockModel.ticker)
                    .frame(width: 350, height: 400)
                    .padding(.top)
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: BuySellStockView(stockModel: stockModel, type: .sell)
                        .navigationBarBackButtonHidden()
                        .environmentObject(assetsManager)
                        .environmentObject(stocksApiManager)) {
                            Text("SELL")
                                .font(.custom("TTCommons-Bold", size: 24))
                                .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 42, style: .continuous)
                                        .fill(Color.init(red: 253/255, green: 183/255, blue: 183/255))
                                )
                        }
                    NavigationLink(destination: BuySellStockView(stockModel: stockModel, type: .buy)
                        .navigationBarBackButtonHidden()
                        .environmentObject(assetsManager)
                        .environmentObject(stocksApiManager)) {
                            Text("BUY")
                                .font(.custom("TTCommons-Bold", size: 24))
                                .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 42, style: .continuous)
                                        .fill(Color.init(red: 183/255, green: 253/255, blue: 190/255))
                                )
                        }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(
                Image("main_assets_bg")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TradingViewWebView: UIViewRepresentable {
    
    var ticker: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.loadHTMLString(GraphicViewGenerator().getGraphicCode(ticker: ticker), baseURL: nil)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    StockDetailsView(stockModel: .default)
        .environmentObject(StocksApiManager())
        .environmentObject(AssetsManager())
}
