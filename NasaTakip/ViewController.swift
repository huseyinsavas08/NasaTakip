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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let networkController = NetworkController()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setInitView()
    }
    
    private func setInitView() {
        descriptionText.text = ""
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePicker.maximumDate = .now
    }
    
    @IBAction func datePickerChange(_ sender: UIDatePicker) {
        let selectedDate = dateFormatter.string(from: sender.date)
        
        networkController.fetchPhotoInfo(date: selectedDate) { [weak self] photoInfo in
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
