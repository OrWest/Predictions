import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let serverBaseURL = URL(string: "https://api.myjson.com/bins/")!
    static let shared = UIApplication.shared.delegate as! AppDelegate
    
    var window: UIWindow?
    var network: NetworkManager!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Code injection (http://injectionforxcode.com)
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle")?.load()
        #endif
        
        initializeManagers()
        
        return true
    }

    private func initializeManagers() {
        network = NetworkManager(baseURL: serverBaseURL)
    }
    
}

