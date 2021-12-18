//
//  PilihJadwalViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class PilihJadwalViewController: UIViewController {

    @IBOutlet weak var pilihJadwalView: PilihJadwalView!
    let datePicker = UIDatePicker()
    let data = ["08:00", "11:00", "15:00", "19:00"]
    let picker = UIPickerView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
        self.addKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        createDatePicker()
        picker.dataSource = self
        picker.delegate = self
        pilihJadwalView.jamTextField.inputView = picker
        pilihJadwalView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IsiDataPasien") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PilihJadwalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pilihJadwalView.jamTextField.text = data[row]
        pilihJadwalView.jamTextField.resignFirstResponder()
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        pilihJadwalView.tanggalTextField.inputView =  datePicker
        pilihJadwalView.tanggalTextField.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        pilihJadwalView.tanggalTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}
