//
//  ViewController.swift
//  NasaTakip
//
//  Created by Hüseyin Savaş on 27.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var descriptionLabel:UILabel!
    @IBOutlet var copyrightLabel:UILabel!
    
    let networkController = NetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setInitView()
    }
    
    private func setInitView() {
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        networkController.fetchPhotoInfo { photoInfo in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        networkController.fetchPhoto(from: photoInfo.url) { image in
            DispatchQueue.main.async {
                self.posterImageView.image = image
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
                
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = copyright
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
        }
    }
}

