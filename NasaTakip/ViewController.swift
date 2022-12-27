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
    @IBOutlet var dateTextField: UITextField!
    
    let networkController = NetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setInitView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchData()
        
        return true
    }
    
    func searchData() {
        dateTextField.resignFirstResponder()
        
        guard let text = dateTextField.text, !text.isEmpty else { return }
        networkController.fetchPhotoInfo(date: text) { photoInfo in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }
    
    private func setInitView() {
        descriptionLabel.text = ""
        copyrightLabel.text = ""
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

extension ViewController: UITextFieldDelegate {
    
}
