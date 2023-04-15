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
    let locationManager = CLLocationManager()
    let viewControllerPresenter = ViewControllerPresenter()
    var mapView: GMSMapView?
    let marker = GMSMarker()
    var stackView: UIStackView?
    var heading: UILabel?
    var previousButton: UIButton?
    var nextButton: UIButton?
    var skipButton: UIButton?
    var signUpResult = SignUpResult()
    @IBOutlet weak var viewForMaps: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.setMetalRendererEnabled(true)
        askPermission()
        setUpViews()
        displayMap()
    }
    @objc func actionNext() {
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: ConfirmDetailViewController.self) as? ConfirmDetailViewController {
            nextVC.signUpResult = signUpResult
            self.present(nextVC, animated: true)
        }
    }
    @objc func actionPrevious() {
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
    func askPermission() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    func displayMap() {
        viewForMaps.layoutIfNeeded()
        mapView = GMSMapView.map(withFrame: viewForMaps.bounds, camera: GMSCameraPosition())
        if let mapView = mapView {
            mapView.delegate = self
            viewForMaps.addSubview(mapView)
        }
        // marker.isDraggable = true
        marker.map = mapView
    }
}

extension SelectLocationViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
}

extension SelectLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView?.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        reverseGeocodeCoordinate(location.coordinate)
        locationManager.stopUpdatingLocation()
    }
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.signUpResult.Lat = coordinate.latitude.description
            self.signUpResult.Lng = coordinate.longitude.description
            self.marker.position = coordinate
            self.marker.title = lines.joined(separator: "\n")
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
