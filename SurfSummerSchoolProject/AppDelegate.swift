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
    var splashPresenter: SplashPresenterProtocol? = SplashPresenter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        CoreDataManager.shared.load()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        startApplicationProccess()
        
        return true
    }
    
    func startApplicationProccess() {
        presentSplashScreen()
        
        if let credentials = try? UserCredentialsManager.shared.getCredentials() {
            guard credentials.token.isExpired else {
                dismissSplashScreen()
                Coordinator.runMainFlow(.now() + 2.5)
                return
            }

            let requestCredentials = AuthRequestModel(phone: credentials.login,
                                                      password: credentials.password)

            AuthService().performLoginRequestAndSaveCredentials(credentials: requestCredentials) { [weak self] result in
                switch result {
                case .success:
                    self?.dismissSplashScreen()
                    Coordinator.runMainFlow(.now() + 2.5)
                case .failure(let error):
                    print("Ошибка автоматической авторизации по причине: \(error)")
                    self?.dismissSplashScreen()
                    Coordinator.runAuthFlow(.now() + 2.5, isNeedShowErrorState: true)
                }
            }

        } else {
            dismissSplashScreen()
            Coordinator.runAuthFlow(.now() + 2.5)
        }
    }
    
    func presentSplashScreen() {
        window?.rootViewController = splashPresenter?.getSplashScreen()
        splashPresenter?.startAnimatingSplashScreen()
    }
    
    func dismissSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.splashPresenter?.stopAnimatingSplashScreen()
            self.splashPresenter = nil
        }
    }
    
}
