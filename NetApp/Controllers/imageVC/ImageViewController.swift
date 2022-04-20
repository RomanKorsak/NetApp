//
//  ViewController.swift
//  NetApp
//
//  Created by Роман Корсак on 15.04.22.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet var myImageView: UIImageView!

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: ApiConstants.urlwithImage) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.myImageView.image = image
                }
            }
        }.resume()
    }
}
