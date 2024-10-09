import Foundation

struct StockModel: Codable, Identifiable {
    let id = UUID().uuidString
    let ticker: String
    let name: String
    let market: String
    let locale: String
    let type: String
    let marketCap: Double
    let description: String
    let homepageUrl: String
    let branding: StockBranding
    
    enum CodingKeys: String, CodingKey {
        case ticker = "ticker"
        case name = "name"
        case market = "market"
        case locale = "locale"
        case marketCap = "market_cap"
        case type = "type"
        case description = "description"
        case homepageUrl = "homepage_url"
        case branding = "branding"
    }
}

struct OpenClosePrices: Codable {
    let symbol: String
    let open: Double
    let preMarket: Double
    
    var preMarketChangePercentage: Double {
        return ((open - preMarket) / preMarket) * 100
    }
}

extension StockModel {
    static let `default` = StockModel(ticker: "", name: "", market: "", locale: "", type: "", marketCap: 0.0, description: "", homepageUrl: "", branding: StockBranding(logoUrl: "", iconUrl: ""))
}

struct StockClientedResponse: Codable {
    let client_id: String
    let response: String?
}

extension OpenClosePrices {
    static let `default` = OpenClosePrices(symbol: "", open: 0.0, preMarket: 0.0)
}

struct StockBranding: Codable {
    let logoUrl: String
    let iconUrl: String
    
    enum CodingKeys: String, CodingKey {
        case logoUrl = "logo_url"
        case iconUrl = "icon_url"
    }
}

struct StockDetailsResponse: Codable {
    let results: StockModel
    let response: String?
}
