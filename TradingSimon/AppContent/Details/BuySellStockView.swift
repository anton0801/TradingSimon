import SwiftUI
import SDWebImageSwiftUI

enum TypeMode {
    case buy
    case sell
}

struct BuySellStockView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var stocksApiManager: StocksApiManager
    @EnvironmentObject var assetsManager: AssetsManager
    var stockModel: StockModel
    var type: TypeMode
    @State var alertVisible = false
    
    var keyboardSymbols = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "X"
    ]
    
    @State var countStocksText = ""
    
    var body: some View {
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
            
            Text(countStocksText.isEmpty ? "Stocks" : countStocksText)
                .font(.custom("TTCommons-Regular", size: 32))
                .foregroundColor(countStocksText.isEmpty ? Color.init(red: 160/255, green: 160/255, blue: 160/255) : .white)
            
            LazyVGrid(columns: [
                GridItem(.fixed(110)),
                GridItem(.fixed(110)),
                GridItem(.fixed(110))
            ]) {
                ForEach(keyboardSymbols, id: \.self) { keyboardItem in
                    Button {
                        if keyboardItem == "X" {
                            if !countStocksText.isEmpty {
                                countStocksText = String(countStocksText.dropLast())
                            }
                        } else {
                            countStocksText += keyboardItem
                        }
                    } label: {
                        Text(keyboardItem)
                            .font(.custom("TTCommons-Bold", size: 24))
                            .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                            .frame(width: 70, height: 40)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 42.0, style: .continuous)
                                    .fill(Color.init(red: 233/255, green: 230/255, blue: 247/255))
                            )
                            .padding(.horizontal, 32)
                            .padding(.vertical, 4)
                    }
                }
            }
            
            if type == .buy {
                Button {
                    assetsManager.buyStocks(from: stocksApiManager, stockItem: stockModel, with: Double(countStocksText) ?? 0.0)
                    presMode.wrappedValue.dismiss()
                } label: {
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
            } else {
                Button {
                    let sellResult = assetsManager.sellStocks(from: stocksApiManager, stockItem: stockModel, for: Double(countStocksText) ?? 0.0)
                    if !sellResult {
                        alertVisible = true
                    } else {
                        presMode.wrappedValue.dismiss()
                    }
                } label: {
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
            }
        }
        .alert(isPresented: $alertVisible, content: {
            Alert(title: Text("Alert"),
            message: Text("Something went wrong! Looks like you doesn't have enought stocks for sell"))
        })
        .background(
            Image("main_assets_bg")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    BuySellStockView(stockModel: .default, type: .buy)
        .environmentObject(StocksApiManager())
        .environmentObject(AssetsManager())
}
