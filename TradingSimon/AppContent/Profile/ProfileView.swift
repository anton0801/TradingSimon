import SwiftUI

extension Notification.Name {
    static let ndjksanksad = Notification.Name("jupiter_back")
    static let dsadsafada = Notification.Name("jupiter_dsabdhjas")
    static let dsandjsad = Notification.Name("jupiter_reload")
}

struct ProfileView: View {
    
    @State private var showingImagePicker = false
    @StateObject var userManager: UserManager = UserManager()
    @State private var inputImage: UIImage?
    
    @State var userName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Profile")
                    .font(.custom("TTCommons-Medium", size: 42))
                    .foregroundColor(.white)
                    .padding(.top, 42)
                    .padding(.leading)
                
                Spacer()
            }
            
            TextInputField(text: $userName, label: "Username", isSecure: false)
                .padding(.horizontal)
            
            if userManager.profileImagePath.isEmpty {
                Button {
                    showingImagePicker = true
                } label: {
                    Image("no_profile_image")
                        .resizable()
                        .frame(width: 350, height: 250)
                        .padding(.vertical)
                        .padding(.top, 6)
                }
            } else {
                let imagePath = URL(fileURLWithPath: userManager.profileImagePath)
                    
                if let imageData = try? Data(contentsOf: imagePath),
                   let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 250)
                        .cornerRadius(32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .stroke(Color.init(red: 191/255, green: 183/255, blue: 253/255), lineWidth: 2)
                        )
                } else {
                    Button {
                        showingImagePicker = true
                    } label: {
                        Image("no_profile_image")
                            .resizable()
                            .frame(width: 350, height: 250)
                            .padding(.vertical)
                            .padding(.top, 6)
                    }
                }
            }
            
            Spacer()
            
            Button {
                userManager.updateUsername(userName)
            } label: {
                Text("Save")
                    .font(.custom("TTCommons-Bold", size: 24))
                    .foregroundColor(Color.init(red: 21/255, green: 21/255, blue: 33/255))
                    .frame(width: 300)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 42, style: .continuous)
                            .fill(Color.init(red: 191/255, green: 183/255, blue: 253/255))
                    )
            }
            .opacity(userName.isEmpty || userName == userManager.username ? 0.4 : 1)
            .disabled(userName.isEmpty || userName == userManager.username ? true : false)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { newValue in
            loadImage()
        }
        .background(
            Image("main_assets_bg")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
        .onAppear {
            userName = userManager.username
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        if let imageData = inputImage.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
            do {
                try imageData.write(to: filename)
            } catch {
                print("Error save image \(error.localizedDescription)")
            }
            
            userManager.updateProfileImagePath(with: filename.path)
        }
    }
    
    // Метод для получения директории документов приложения
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}

struct TextInputField: View {
    @Binding var text: String
    var label: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("TTCommons-Medium", size: 18))
                .foregroundColor(.white.opacity(0.6))
            
            TextField("", text: $text)
                .font(.custom("TTCommons-Medium", size: 20))
                .foregroundColor(.white)
                .padding()
                .cornerRadius(5)
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .stroke(Color.init(red: 191/255, green: 183/255, blue: 253/255), lineWidth: 2)
                )
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ProfileView()
}

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
    }
    
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
