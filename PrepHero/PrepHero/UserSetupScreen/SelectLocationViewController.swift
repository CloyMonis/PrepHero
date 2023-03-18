//
//  SelectLocationViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit
import GoogleMaps

class SelectLocationViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    var stackView: UIStackView?
    var heading: UILabel?
    var previousButton: UIButton?
    var nextButton: UIButton?
    var skipButton: UIButton?
    @IBOutlet weak var viewForMaps: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        displayMap()
    }
    @objc func actionNext(){
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: ConfirmDetailViewController.self) {
            self.present(nextVC, animated: true)
        }
    }
    @objc func actionPrevious(){
        self.dismiss(animated: true)
    }
}

extension SelectLocationViewController {
    func setUpViews() {
        let stackAndSkip = viewFactory.getProcessAndSkip(view: view, currentStep: 8, totalSteps: 9)
        stackView = stackAndSkip.0
        skipButton = stackAndSkip.1
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.location.rawValue
        heading?.frame = CGRect(x: 20, y: 100, width: view.frame.width , height: 150)
        heading?.numberOfLines = 0
        previousButton = viewFactory.getPreviousButton(view: view)
        nextButton = viewFactory.getNextButton(view: view)
        previousButton?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
    }
    func displayMap() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.viewForMaps.addSubview(mapView)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
}
