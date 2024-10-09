import Foundation

struct AssetItem: Codable {
    let tiker: String
    var count: Double
}

class AssetsManager: ObservableObject {
    
    @Published var assets: [AssetItem] = []
    private let assetsKey = "holdings"
    
    init() {
        self.assets = retrieveHoldings()
    }
    
    func calculateTotalFundHoldings(from stocksManager: StocksApiManager) -> Double {
        guard !assets.isEmpty else {
            return 0.0
        }
        
        return assets.reduce(0.0) { result, holding in
            let price = stocksManager.stockPrices.first { $0.symbol == holding.tiker }?.preMarket ?? 0.0
            return result + (holding.count * price)
        }
    }
    
    private func retrieveHoldings() -> [AssetItem] {
        let decoder = JSONDecoder()
        if let savedData = UserDefaults.standard.data(forKey: assetsKey),
           let decodedHoldings = try? decoder.decode([AssetItem].self, from: savedData) {
            return decodedHoldings
        }
        return []
    }
    
    func buyStocks(from stocksManager: StocksApiManager, stockItem: StockModel, with money: Double) {
        guard let stockPrice = stocksManager.stockPrices.first(where: { $0.symbol == stockItem.ticker }) else {
            return
        }
        
        let stocksToBuy = money / stockPrice.preMarket
        if let existingHoldingIndex = assets.firstIndex(where: { $0.tiker == stockItem.ticker }) {
            assets[existingHoldingIndex].count += stocksToBuy
        } else {
            assets.append(AssetItem(tiker: stockItem.ticker, count: stocksToBuy))
        }
        persistHoldings()
    }
    
    func sellStocks(from stocksManager: StocksApiManager, stockItem: StockModel, for money: Double) -> Bool {
        guard let holdingIndex = assets.firstIndex(where: { $0.tiker == stockItem.ticker }),
              let stockPrice = stocksManager.stockPrices.first(where: { $0.symbol == stockItem.ticker }),
              money >= stockPrice.preMarket else {
            return false
        }
        
        let holding = assets[holdingIndex]
        let totalValueOfHolding = holding.count * stockPrice.preMarket
        
        guard money <= totalValueOfHolding else {
            return false
        }
        
        let stocksToSell = money / stockPrice.preMarket
        assets[holdingIndex].count -= stocksToSell
        persistHoldings()
        
        return true
    }
    
    private func persistHoldings() {
        let encoder = JSONEncoder()
        if let encodedHoldings = try? encoder.encode(assets) {
            UserDefaults.standard.set(encodedHoldings, forKey: assetsKey)
        }
    }
}
