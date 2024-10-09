import Foundation
import StoreKit

class SubscriptionsManager: ObservableObject {
    
    let productIds = [
        "com.tradingsimon.TradingSimon.subscription"
    ]
    var purchasedProductIDs: Set<String> = []
    
    @Published var products: [Product] = []
    @Published var bought = false
    
    init() {
        Task {
            await loadProducts()
        }
    }
    
    func buyProduct(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            case let .success(.verified(transaction)):
                await transaction.finish()
                await updatePurchasedProducts()
            case let .success(.unverified(_, error)):
                break
            case .pending:
                break
            case .userCancelled:
                break
            @unknown default:
                break
            }
        } catch {
        }
    }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
        
        bought = !self.purchasedProductIDs.isEmpty
        UserDefaults.standard.set(bought, forKey: "is_premium_bought")
    }
    
}

extension SubscriptionsManager {
    func loadProducts() async {
        do {
            self.products = try await Product.products(for: productIds)
                .sorted(by: { $0.price > $1.price })
        } catch {
            print("Failed to fetch products!")
        }
    }
}
