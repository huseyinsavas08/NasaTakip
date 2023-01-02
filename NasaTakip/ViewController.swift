//
//  ViewController.swift
//  NasaTakip
//
//  Created by Hüseyin Savaş on 27.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    
    let networkController = NetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setInitView()
    }
    
    private func setInitView() {
        descriptionText.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchData()
        
        return true
    }
    
    func searchData() {
        dateTextField.resignFirstResponder()
        
        guard let text = dateTextField.text, !text.isEmpty else { return }
        networkController.fetchPhotoInfo(date: text) { [weak self] photoInfo in
            if let photoInfo = photoInfo {
                self?.updateUI(with: photoInfo)
            }
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        networkController.fetchPhoto(from: photoInfo.url!) { [weak self] image in
            DispatchQueue.main.async {
                self?.posterImageView.image = image
                self?.title = photoInfo.title
                self?.descriptionText.text = photoInfo.description
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
}
