//
//  PrepareResultViewController.swift
//  PrepHero
//
//  Created by Admin_Vserv on 10/04/23.
//

import UIKit

class PrepareResultViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    let httpCient = HttpClient()
    var signUpResult = SignUpResult()
    @IBOutlet weak var prepareResultImg: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subHeaderView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareResultImg.image = UIImage.gifImageWithName("prepare_result")
        updateHeaders()
        getSignUpResult()
        
    }
    
    func updateHeaders() {
        headerView.layoutIfNeeded()
        let header = viewFactory.getLabel(font: .bold, size: 26)
        header.text = "PREPARING RESULTS"
        header.textAlignment = .center
        header.numberOfLines = 0
        header.frame = CGRect(x: 0, y: 0, width: headerView.bounds.width, height: headerView.bounds.height)
        headerView.addSubview(header)
        
        subHeaderView.layoutIfNeeded()
        let subHeader = viewFactory.getLabel(font: .regular, size: 16)
        subHeader.text = "Our nutritional enhanced AI will prepare the right macro's needed for you healthy lifestyle!"
        subHeader.textAlignment = .center
        subHeader.numberOfLines = 0
        subHeader.frame = CGRect(x: 0, y: 0, width: subHeaderView.bounds.width, height: subHeaderView.bounds.height)
        subHeaderView.addSubview(subHeader)
    }
    
    func getSignUpResult() {
        httpCient.request(api: .signUpResult, httpMethod: .post, body: createSignUpResultParam()) { result in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let obj):
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(PrepareResult.self, from: obj) {
                    print("Response",response)
                    self.actionNext(response)
                }
            }
        }
    }
    
    func createSignUpResultParam() -> Data? {
        return try? JSONEncoder().encode(signUpResult)
    }
    
    func actionNext(_ prepareResult: PrepareResult) {
        DispatchQueue.main.async {
            if let nextVC = self.viewControllerPresenter.getNextViewController(current: self, nextVC: ResultViewController.self) as? ResultViewController {
                if let result = prepareResult.Result {
                    nextVC.prepareResult = result
                }
                self.present(nextVC, animated: true)
            }
        }
    }
    
}
