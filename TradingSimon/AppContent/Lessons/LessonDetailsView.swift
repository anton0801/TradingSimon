import SwiftUI

struct LessonDetailsView: View {
    
    @EnvironmentObject var stockApiManager: StocksApiManager
    @Environment(\.presentationMode) var presMode
    
    var lesson: LessonModel
    @State var currentIndexOfLesson = 0
    
    var body: some View {
        NavigationView {
            VStack {
                let lessonContent = lesson.lessonContent
                
                if lessonContent[currentIndexOfLesson].isFirstPreview {
                    HStack {
                        Button {
                            presMode.wrappedValue.dismiss()
                        } label: {
                            Image("back_button")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                        
                        Spacer()
                        
                        Text(lessonContent[currentIndexOfLesson].title)
                            .multilineTextAlignment(.center)
                            .font(.custom("TTCommons-Bold", size: 26))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            Image("simon_icon")
                                .resizable()
                                .frame(width: 52, height: 52)
                            VStack(alignment: .leading) {
                                Text("Simon")
                                    .multilineTextAlignment(.center)
                                    .font(.custom("TTCommons-Bold", size: 24))
                                    .foregroundColor(.white)
                                Text("Trader,investor")
                                    .multilineTextAlignment(.center)
                                    .font(.custom("TTCommons-Bold", size: 18))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            Spacer()
                        }
                        
                        ScrollView {
                            Text(lessonContent[currentIndexOfLesson].content)
                                .multilineTextAlignment(.leading)
                                .font(.custom("TTCommons-Medium", size: 18))
                                .foregroundColor(.white)
                        }
                        .frame(maxHeight: 400)
                    }
                    .frame(width: 300)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .stroke(Color.init(red: 191/255, green: 183/255, blue: 253/255), lineWidth: 2)
                    )
                    .padding(.top, 52)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            currentIndexOfLesson += 1
                        }
                    } label: {
                        Text("Go to the study!")
                            .font(.custom("TTCommons-Bold", size: 24))
                            .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                            .frame(width: 300)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 42, style: .continuous)
                                    .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                            )
                    }
                } else {
                    HStack {
                        Spacer()
                        
                        Text(lessonContent[currentIndexOfLesson].title)
                            .multilineTextAlignment(.center)
                            .font(.custom("TTCommons-Bold", size: 24))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            presMode.wrappedValue.dismiss()
                        } label: {
                            Image("close")
                                .resizable()
                                .frame(width: 18, height: 18)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        ScrollView {
                            Text(lessonContent[currentIndexOfLesson].content)
                                .multilineTextAlignment(.leading)
                                .font(.custom("TTCommons-Medium", size: 18))
                                .foregroundColor(.white)
                        }
                        .frame(maxHeight: 400)
                    }
                    .frame(width: 300)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255).opacity(0.2))
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .stroke(Color.init(red: 191/255, green: 183/255, blue: 253/255), lineWidth: 2)
                    )
                    .padding(.top, 52)
                    
                    Spacer()
                    
                    Text("\(currentIndexOfLesson)/3")
                        .multilineTextAlignment(.leading)
                        .font(.custom("TTCommons-Medium", size: 24))
                        .foregroundColor(.white.opacity(0.4))
                    
                    HStack {
                        Button {
                            if currentIndexOfLesson > 1 {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    currentIndexOfLesson -= 1
                                }
                            }
                        } label: {
                            Text("Back")
                                .font(.custom("TTCommons-Bold", size: 24))
                                .foregroundColor(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 42, style: .continuous)
                                        .stroke(Color.init(red: 191/255, green: 183/255, blue: 253/255), lineWidth: 2)
                                )
                        }
                        
                        if lesson.iconId == "lesson_free_3_icon" && currentIndexOfLesson == lessonContent.count - 1 {
                            NavigationLink(destination: ContentView()
                                .environmentObject(stockApiManager)
                                .navigationBarBackButtonHidden()) {
                                    Text("Complete")
                                        .font(.custom("TTCommons-Bold", size: 24))
                                        .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 42, style: .continuous)
                                                .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                                        )
                                }
                        } else {
                            Button {
                                if currentIndexOfLesson < lessonContent.count - 1 {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        currentIndexOfLesson += 1
                                    }
                                } else {
                                    presMode.wrappedValue.dismiss()
                                }
                            } label: {
                                Text(currentIndexOfLesson == lessonContent.count - 1 ? "Complete" : "Next")
                                    .font(.custom("TTCommons-Bold", size: 24))
                                    .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 42, style: .continuous)
                                            .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(
                Image("lessons_bg")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    LessonDetailsView(lesson: lessons[1])
        .environmentObject(StocksApiManager())
}
