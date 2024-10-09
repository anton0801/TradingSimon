import Foundation

class UserManager: ObservableObject {
    
    @Published var username: String {
        didSet {
            saveUsername()
        }
    }
    
    @Published var profileImagePath: String {
        didSet {
            saveProfileImagePath()
        }
    }
    
    private let usernameKey = "usernameKey"
    private let profileImageKey = "profileImageKey"
    
    init() {
        self.username = UserDefaults.standard.string(forKey: usernameKey) ?? ""
        self.profileImagePath = UserDefaults.standard.string(forKey: profileImageKey) ?? ""
    }
    
    private func saveUsername() {
        UserDefaults.standard.set(username, forKey: usernameKey)
    }
    
    private func saveProfileImagePath() {
        UserDefaults.standard.set(profileImagePath, forKey: profileImageKey)
    }
    
    func updateProfileImagePath(with path: String) {
        self.profileImagePath = path
    }
    
    func updateUsername(_ newName: String) {
        self.username = newName
    }
    
}

