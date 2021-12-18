//
//  DataPasienViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class DataPasienViewController: UIViewController {

    @IBOutlet weak var isiDataPasienView: IsiDataPasienView!
    let datePicker = UIDatePicker()
    let data = ["Pria", "Wanita"]
    let picker = UIPickerView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        picker.dataSource = self
        picker.delegate = self
        isiDataPasienView.jenisKelaminTextField.inputView = picker
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func nextButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DataPasienViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        isiDataPasienView.jenisKelaminTextField.text = data[row]
        isiDataPasienView.jenisKelaminTextField.resignFirstResponder()
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
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = yesterdayDate
        
        isiDataPasienView.tanggalLahirTextField.inputView =  datePicker
        isiDataPasienView.tanggalLahirTextField.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        isiDataPasienView.tanggalLahirTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}
