//
//  DetailedPersonVC.swift
//  NetApp
//
//  Created by Роман Корсак on 20.04.22.
//

import MapKit
import UIKit

final class DetailedPersonVC: UIViewController {
    var person: User?
    
    @IBOutlet private var map: MKMapView!
    @IBOutlet private var nameLBL: UILabel!
    @IBOutlet private var userNameLBL: UILabel!
    @IBOutlet private var emailLBL: UILabel!
    @IBOutlet private var phoneLBL: UILabel!
    @IBOutlet private var webLBL: UILabel!
    @IBOutlet private var companyLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPointOnMap()
        setupUI()
    }
    
    private func setupUI() {
        map.delegate = self
        
        showPointOnMap()
        nameLBL.text = person?.name
        userNameLBL.text = person?.username
        emailLBL.text = person?.email
        phoneLBL.text = person?.phone
        webLBL.text = person?.website
        companyLBL.text = person?.company?.name
    }
}

extension DetailedPersonVC: MKMapViewDelegate {
    func showPointOnMap() {
        guard let long = Double(person?.address?.geo?.lng ?? "55"),
              let lat = Double(person?.address?.geo?.lat ?? "55") else { return }
        let sourseLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let soursePlaceMark = MKPlacemark(coordinate: sourseLocation, addressDictionary: nil)
        let sourseAnnotation = MKPointAnnotation()
        
        if let location = soursePlaceMark.location {
            sourseAnnotation.coordinate = location.coordinate
        }
        let destinationAnnotation = MKPointAnnotation()
        map.showAnnotations([sourseAnnotation, destinationAnnotation], animated: true)
    }
}
