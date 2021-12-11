//
//  ChangeDataViewController.swift
//  testProject2
//
//  Created by Finsen Antonius on 09/12/21.
//

import UIKit

class ChangeDataViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    @IBOutlet weak var cancelMyData: UIBarButtonItem!
    @IBOutlet weak var changeMyData: UIBarButtonItem!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    let data = ["Pria", "Wanita"]
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true){
            
        }
    }
    @IBOutlet weak var genderPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cancelMyData.tintColor = .white
        self.changeMyData.tintColor = .white
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
    }
    

}

