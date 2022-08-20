//
//  AppDelegate.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 02.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        startApplicationProccess()
        
        return true
    }
    
    func startApplicationProccess() {
        runLaunchScreen()
        
        if let credentials = try? UserCredentialsManager.shared.getCredentials() {
            guard credentials.token.isExpired else {
                Coordinator.runMainFlow()
                return
            }
            
            let requestCredentials = AuthRequestModel(phone: credentials.login,
                                                      password: credentials.password)
            
            AuthService().performLoginRequestAndSaveCredentials(credentials: requestCredentials) { [weak self] result in
                switch result {
                case .success:
                    Coordinator.runMainFlow()
                case .failure(let error):
                    print("Ошибка автоматической авторизации по причине: \(error)")
                    DispatchQueue.main.async {
                        self?.window?.rootViewController?.showErrorState("Не удалось выполнить вход \nПовторите попытку позднее")
                    }
                    Coordinator.runAuthFlow()
                }
            }
            
        } else {
            Coordinator.runAuthFlow()
        }
    }
    
    func runLaunchScreen() {
        let lauchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main)
            .instantiateInitialViewController()
        window?.rootViewController = lauchScreenViewController
    }
    
}
