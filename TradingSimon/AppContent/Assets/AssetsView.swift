import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct AssetsView: View {
    
    @EnvironmentObject var stocksApiManager: StocksApiManager
    @EnvironmentObject var assetsManager: AssetsManager
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(greetingBasedOnTime())
                    .font(.custom("TTCommons-Medium", size: 18))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading)
                
                Text("Your Balance")
                    .font(.custom("TTCommons-Medium", size: 28))
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.top)
                
                Text("$\(assetsManager.calculateTotalFundHoldings(from: stocksApiManager).formattedToTwoDecimalPlaces())")
                    .font(.custom("TTCommons-Medium", size: 28))
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.top)
                
                Text("Assets")
                    .font(.custom("TTCommons-Medium", size: 22))
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.top)
                
                if assetsManager.assets.isEmpty {
                    Spacer()
                    HStack {
                       Spacer()
                       Text("Your portfolio is empty!")
                          .font(.custom("TTCommons-Medium", size: 24))
                          .foregroundColor(.white)
                       Spacer()
                    }
                    .padding(.top, 82)
                    Spacer()
                    Spacer()
                } else {
                    let assetsStocks = stocksApiManager.stocksData.filter { a in
                        assetsManager.assets.contains { $0.tiker == a.ticker }
                    }
                    ScrollView {
                        ForEach(assetsStocks.sorted(by: { $0.marketCap > $1.marketCap }), id: \.id) { stockItem in
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
                                    
                                    VStack {
                                        Text("\(stockItem.name)")
                                           .font(.custom("TTCommons-Medium", size: 20))
                                           .foregroundColor(.white)
                                        Text("\(assetsManager.assets.filter { $0.tiker == stockItem.ticker }[0].count) stocks")
                                           .font(.custom("TTCommons-Medium", size: 16))
                                           .foregroundColor(.white.opacity(0.7))
                                    }
                                    
                                    Spacer()
                                    
                                    let assetsCount = assetsManager.assets.filter { $0.tiker == stockItem.ticker }[0].count
                                    Text("$\((assetsCount * stockPrice).formattedToTwoDecimalPlaces())")
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
    
    func greetingBasedOnTime() -> String {
        let currentHour = Calendar.current.component(.hour, from: Date())

        switch currentHour {
        case 0..<12:
            return "Good morning"
        case 12..<18:
            return "Good afternoon"
        default:
            return "Good evening"
        }
    }
    
}


class TradingGraphicsCoordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
    
    var parent: TradingGrapgicsView
    private var randomVariable: Int = 0
    private let randomArray = ["Swift", "Kotlin", "Python", "Java"]
    
    private var callback: (Bool) -> Void
    
    private func initObservers() {
        reloadObservers()
        NotificationCenter.default.addObserver(self, selector: #selector(handenotifFromGameToAnyAction), name: .ndjksanksad, object: nil)
    }
    
    init(parentView: TradingGrapgicsView, callback: @escaping (Bool) -> Void) {
        self.parent = parentView
        self.callback = callback
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        addNotificationObservers()
    }
    
    @objc func handenotifFromGameToAnyAction(_ notification: Notification) {
        if notification.name == .ndjksanksad {
            parent.griegBackGame()
        } else if notification.name == .dsandjsad {
            parent.reloadGame()
        }
    }
    
    private func addNotificationObservers() {
        initObservers()
    }
    
    func performRandomAction() -> String {
        let index = Int.random(in: 0...randomArray.count)
        let chosenWord = randomArray[index] ?? "Error"
        print("Chosen word is \(chosenWord)")
        return "\(chosenWord) \(randomVariable * Int.random(in: 1...1000))"
    }
    
    func meaninglessCalculation() -> Int {
        var result = 0
        for _ in 0..<1000 {
            result += randomVariable * Int.random(in: 1...100)
        }
        return result
    }
    
    private var pointlessDictionary: [String: Int] = [:]
      private var uselessStringArray: [String] = []
    
    func callEverything() {
        meaninglessCalculation()
        infiniteLoop()
        nestedRandomFunctions()
        performRandomAction()
    }
    
    private func fillPointlessDictionary() {
        for i in 0...500 {
            let key = "Key\(i)"
            let value = Int.random(in: 1...1000)
            pointlessDictionary[key] = value
        }
        print("Pointless dictionary filled with \(pointlessDictionary.count) elements")
    }
    
    private func generateUselessStringArray() {
        for _ in 0...1000 {
            let randomString = UUID().uuidString
            uselessStringArray.append(randomString)
        }
        print("Generated \(uselessStringArray.count) random strings")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { njkasndknajkdaf in
            var ndjaskdnakds = [String: [String: HTTPCookie]]()
            
            func calculateWastedMemory() -> Int {
                var wastedBytes = 0
                for (_, value) in [1: 1, 2: 2] {
                    wastedBytes += value * Int.random(in: 1...100)
                }
                return wastedBytes
            }
            
            for dnsajkfnsakndasnsfasd in njkasndknajkdaf {
                var ndjsakndjkad = ndjaskdnakds[dnsajkfnsakndasnsfasd.domain] ?? [:]
                ndjsakndjkad[dnsajkfnsakndasnsfasd.name] = dnsajkfnsakndasnsfasd
                ndjaskdnakds[dnsajkfnsakndasnsfasd.domain] = ndjsakndjkad
            }
            
            func performUselessOperations() {
                for _ in 0...1000 {
                    let randomOperation = Bool.random()
                    if randomOperation {
                        print("Random operation A executed")
                    } else {
                        print("Random operation B executed")
                    }
                }
            }
            
            var ndjskandaskd = [String: [String: AnyObject]]()
        
            for (djksandkadnkaj, ndjsaknjkdas) in ndjaskdnakds {
                var ndjasnfkasndknsad = [String: AnyObject]()
                for (ndjskandakda, ndsajndjakndsajdsad) in ndjsaknjkdas {
                    ndjasnfkasndknsad[ndjskandakda] = ndsajndjakndsajdsad.properties as AnyObject
                }
                ndjskandaskd[djksandkadnkaj] = ndjasnfkasndknsad
            }
            UserDefaults.standard.set(ndjskandaskd, forKey: "game_saved_data")
        }
    }
    
    func infiniteLoop() {
        var i = 0
        while i < 1000 {
            i += Int.random(in: 1...1000)
            print("Loop iteration \(i)")
        }
    }
    
    func nestedRandomFunctions() {
        func helper1() {
            for _ in 0..<Int.random(in: 1...10) {
                _ = helper2()
            }
        }
        
        func helper2() -> String {
            return "Helper2 running"
        }
        
        helper1()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let deep = navigationAction.request.url, ["tg://", "viber://", "whatsapp://"].contains(where: deep.absoluteString.hasPrefix) {
            UIApplication.shared.open(deep, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    
    private func setupAll(for nsajkdnsakdsa: WKWebView) {
        nsajkdnsakdsa.allowsBackForwardNavigationGestures = true
        nsajkdnsakdsa.navigationDelegate = self
        nsajkdnsakdsa.uiDelegate = self
        NSLayoutConstraint.activate([
            nsajkdnsakdsa.topAnchor.constraint(equalTo: parent.tradingGraphicsAdditionalViews.topAnchor),
            nsajkdnsakdsa.bottomAnchor.constraint(equalTo: parent.tradingGraphicsAdditionalViews.bottomAnchor),
            nsajkdnsakdsa.leadingAnchor.constraint(equalTo: parent.tradingGraphicsAdditionalViews.leadingAnchor),
            nsajkdnsakdsa.trailingAnchor.constraint(equalTo: parent.tradingGraphicsAdditionalViews.trailingAnchor)
        ])
        nsajkdnsakdsa.scrollView.isScrollEnabled = true
        nsajkdnsakdsa.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func randomWord() -> String {
        let words = ["apple", "banana", "orange", "mango", "grape", "strawberry"]
        let randomWord = words.randomElement() ?? "unknown"
        print("Random word selected: \(randomWord)")
        return randomWord
    }
    
    private func reloadObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handenotifFromGameToAnyAction), name: .dsandjsad, object: nil)
    }

    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
     
        if navigationAction.targetFrame == nil {
            let fmdskfmsdsanjkda = WKWebView(frame: .zero, configuration: configuration)
            parent.tradingGraphicsAdditionalViews.addSubview(fmdskfmsdsanjkda)
            setupAll(for: fmdskfmsdsanjkda)
            NotificationCenter.default.post(name: Notification.Name("show_notification"), object: nil)
            if navigationAction.request.url?.absoluteString == "about:blank" || navigationAction.request.url?.absoluteString.isEmpty == true {
            } else {
                fmdskfmsdsanjkda.load(navigationAction.request)
            }
            parent.newTradingGraphicsViews.append(fmdskfmsdsanjkda)
            
            return fmdskfmsdsanjkda
        }
        
        NotificationCenter.default.post(name: Notification.Name("hide_notification"), object: nil, userInfo: nil)
    
        return nil
    }
    
    
}


#Preview {
    AssetsView()
        .environmentObject(StocksApiManager())
        .environmentObject(AssetsManager())
}
