import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct MarketView: View {
    
    @EnvironmentObject var stocksApiManager: StocksApiManager
    @EnvironmentObject var assetsManager: AssetsManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Market")
                    .font(.custom("TTCommons-Medium", size: 42))
                    .foregroundColor(.white)
                    .padding(.top, 42)
                    .padding(.leading)
                
                ScrollView {
                    ForEach(stocksApiManager.stocksData.filter { !$0.name.isEmpty }.sorted(by: { $0.marketCap > $1.marketCap }), id: \.id) { stockItem in
                        let stockPrice = stocksApiManager.stockPrices.filter { $0.symbol == stockItem.ticker }[0].preMarket
                        NavigationLink(destination: StockDetailsView(stockModel: stockItem)
                            .environmentObject(stocksApiManager)
                            .environmentObject(assetsManager)
                            .navigationBarBackButtonHidden(true)) {
                            HStack {
                                WebImage(url: URL(string: "\(stockItem.branding.iconUrl)?apiKey=\(String.apiKey)"))
                                    .resizable()
                                    .frame(width: 52, height: 52)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(52)
                                
                                Text("\(stockItem.name)")
                                   .font(.custom("TTCommons-Medium", size: 20))
                                   .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("$\(stockPrice.formattedToTwoDecimalPlaces())")
                                   .font(.custom("TTCommons-Medium", size: 18))
                                   .foregroundColor(.white.opacity(0.7))
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .stroke(Color.init(red: 191/255, green: 183/255, blue: 253/255), lineWidth: 2)
                            )
                            .padding(.horizontal)
                        }
                    }
                }
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

struct TradingGrapgicsView: UIViewRepresentable {
 
    func griegBackGame() {
        if !newTradingGraphicsViews.isEmpty {
            ndjksanfjkadsa()
        } else if tradingGraphicsAdditionalViews.canGoBack {
            tradingGraphicsAdditionalViews.goBack()
        }
    }
    @State var tradingGraphicsAdditionalViews: WKWebView = WKWebView()

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: tradingStartGraph))
    }

    let tradingStartGraph: URL
    var callback: (Bool) -> Void
    
    func makeCoordinator() -> TradingGraphicsCoordinator {
        TradingGraphicsCoordinator(parentView: self, callback: self.callback)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        tradingGraphicsAdditionalViews = djsunadkfsad()
        tradingGraphicsAdditionalViews.allowsBackForwardNavigationGestures = true
        tradingGraphicsAdditionalViews.uiDelegate = context.coordinator
        tradingGraphicsAdditionalViews.navigationDelegate = context.coordinator
        
        if let graphicData = getGraphicData() {
            for (_, dnsajkfnanskd) in graphicData {
                
                for (_, dnsjaknfkasd) in dnsajkfnanskd {
                    
                    let njdsakndsakfad = dnsjaknfkasd as? [HTTPCookiePropertyKey: AnyObject]
                    if let dnjskanfjksandas = njdsakndsakfad,
                       let ndjsakndskad = HTTPCookie(properties: dnjskanfjksandas) {
                        
                        tradingGraphicsAdditionalViews.configuration.websiteDataStore.httpCookieStore.setCookie(ndjsakndskad)
                    }
                    
                }
            }
       }
        
        return tradingGraphicsAdditionalViews
    }
    @State var newTradingGraphicsViews: [WKWebView] = []
    func reloadGame() {
        tradingGraphicsAdditionalViews.reload()
    }
    
}


#Preview {
    MarketView()
}
