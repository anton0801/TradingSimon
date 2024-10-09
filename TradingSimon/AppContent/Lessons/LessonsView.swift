import SwiftUI

struct LessonsView: View {
    
    @EnvironmentObject var stockApiManager: StocksApiManager
    @State var isPremium = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: ContentView()
                        .environmentObject(stockApiManager)
                        .navigationBarBackButtonHidden()) {
                            Text("Skip")
                                .font(.custom("TTCommons-Bold", size: 20))
                                .foregroundColor(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                        }
                }
                .padding(.horizontal)
                
                Text("Choose a lesson")
                    .multilineTextAlignment(.center)
                    .font(.custom("TTCommons-Bold", size: 32))
                    .foregroundColor(.white)
                    .padding(.top, 42)
                
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
                                        .environmentObject(stockApiManager)
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
                                        .environmentObject(stockApiManager)
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

#Preview {
    LessonsView()
        .environmentObject(StocksApiManager())
}
