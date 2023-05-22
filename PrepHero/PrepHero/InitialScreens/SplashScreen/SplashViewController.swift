//
//  SplashViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            /*
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController else {
                print("CreateAccountViewController is nil")
                return
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            */
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController else {
                print("IntroViewController is nil")
                return
            }
            vc.model = IntroModel(count: 1)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
