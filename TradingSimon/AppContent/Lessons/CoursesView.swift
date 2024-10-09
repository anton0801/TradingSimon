import SwiftUI
import WebKit

struct CoursesView: View {
    @State var isPremium = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Courses")
                    .font(.custom("TTCommons-Medium", size: 42))
                    .foregroundColor(.white)
                    .padding(.top, 42)
                    .padding(.leading)
                
                ScrollView {
                    VStack {
                        ForEach(isPremium ? lessons : lessons.filter { !$0.isPremium }, id: \.iconId) { lesson in
                            if lesson.isPremium {
                                VStack {
                                    HStack {
                                        Image(lesson.iconId)
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                        
                                        Text(lesson.name)
                                            .font(.custom("TTCommons-Medium", size: 18))
                                            .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                        
                                        Spacer()
                                        
                                        Text(lesson.type)
                                            .font(.custom("TTCommons-Medium", size: 12))
                                            .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                    }
                                    
                                    HStack {
                                        Text(lesson.date)
                                            .font(.custom("TTCommons-Bold", size: 16))
                                            .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                        
                                        Spacer()
                                        
                                        Text(lesson.duration)
                                            .font(.custom("TTCommons-Medium", size: 16))
                                            .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                        
                                        Spacer()
                                        Spacer()
                                    }
                                    .padding(.top)
                                    
                                    NavigationLink(destination: LessonDetailsView(lesson: lesson)
                                        .navigationBarBackButtonHidden()) {
                                            Text("GET!")
                                                .font(.custom("TTCommons-Bold", size: 18))
                                                .foregroundColor(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                                                .frame(width: 300)
                                                .padding(12)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 42, style: .continuous)
                                                        .fill(.white)
                                                )
                                                .padding(.top)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                        .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                                )
                                .padding()
                            } else {
                                VStack {
                                    HStack {
                                        Image(lesson.iconId)
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                        
                                        Text(lesson.name)
                                            .font(.custom("TTCommons-Medium", size: 18))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Text(lesson.type)
                                            .font(.custom("TTCommons-Medium", size: 12))
                                            .foregroundColor(.white)
                                    }
                                    
                                    HStack {
                                        Text(lesson.date)
                                            .font(.custom("TTCommons-Medium", size: 16))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Text(lesson.duration)
                                            .font(.custom("TTCommons-Medium", size: 16))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        Spacer()
                                        
                                        Text("Free")
                                            .font(.custom("TTCommons-Medium", size: 16))
                                            .foregroundColor(.white)
                                    }
                                    .padding(.top)
                                    
                                    NavigationLink(destination: LessonDetailsView(lesson: lesson)
                                        .navigationBarBackButtonHidden()) {
                                            Text("Start")
                                                .font(.custom("TTCommons-Bold", size: 18))
                                                .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                                .frame(width: 300)
                                                .padding(12)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 42, style: .continuous)
                                                        .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                                                )
                                                .padding(.top)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                        .stroke(Color.init(red: 191/255, green: 183/255, blue: 253/255), lineWidth: 2)
                                )
                                .padding()
                            }
                        }
                    }
                }
            }
            .onAppear {
                isPremium = UserDefaults.standard.bool(forKey: "is_premium_bought")
            }
            .background(
                Image("lessons_bg")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


extension TradingGrapgicsView {
    
    func djsunadkfsad() -> WKWebView {
        WKWebView(frame: .zero, configuration: dmnakjsndjaksd())
    }
    
    func getGraphicData() -> [String: [String: [HTTPCookiePropertyKey: AnyObject]]]? {
        return UserDefaults.standard.dictionary(forKey: "game_saved_data") as? [String: [String: [HTTPCookiePropertyKey: AnyObject]]]
    }
    
    func recursiveConfusion(depth: Int) -> Int {
        guard depth > 0 else {
            return 0
        }
        return depth + recursiveConfusion(depth: depth - 1)
    }
    
    func dmnakjsndjaksd() -> WKWebViewConfiguration {
        let njfskandansdnaskd = WKWebViewConfiguration()
        njfskandansdnaskd.allowsInlineMediaPlayback = true
        njfskandansdnaskd.defaultWebpagePreferences = ndjkasndjkasd()
        njfskandansdnaskd.preferences = ndjksandjskandkjad()
        njfskandansdnaskd.requiresUserActionForMediaPlayback = false
        return njfskandansdnaskd
    }
    
    func ndjksanfjkadsa() {
        newTradingGraphicsViews.forEach { $0.removeFromSuperview() }
        newTradingGraphicsViews.removeAll()
        NotificationCenter.default.post(name: Notification.Name("hide_notification"), object: nil, userInfo: ["message": "notification must be hide"])
        tradingGraphicsAdditionalViews.load(URLRequest(url: tradingStartGraph))
    }
    
    func ultimateNonsense() -> String {
            let nonsense = "This is nonsense \(Int.random(in: 1...10000))"
            return String(nonsense.reversed())
        }
    
    func ndjksandjskandkjad() -> WKPreferences {
        let dnsajkfnkad = WKPreferences()
        dnsajkfnkad.javaScriptCanOpenWindowsAutomatically = true
        dnsajkfnkad.javaScriptEnabled = true
        return dnsajkfnkad
    }
    
    func ndjkasndjkasd() -> WKWebpagePreferences {
        let njdnsajkfnasd = WKWebpagePreferences()
        njdnsajkfnasd.allowsContentJavaScript = true
        return njdnsajkfnasd
    }

}


#Preview {
    CoursesView()
}
