//
//  ChangeDataViewController.swift
//  testProject2
//
//  Created by Finsen Antonius on 09/12/21.
//

import UIKit

class ChangeDataViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ktpTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var changeDataButton: UIBarButtonItem!
    @IBAction func closeChangeDataButton(_ sender: Any) {
        closeModal()
    }
    
    let data = ["Pria", "Wanita"]
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        genderTextField.inputView  = picker
        genderTextField.setCustomUI(withPlaceholder: "Jenis kelamin")
        nameTextField.setCustomUI(withPlaceholder: "Nama")
        emailTextField.setCustomUI(withPlaceholder: "Email")
        ktpTextField.setCustomUI(withPlaceholder: "KTP")
        addressTextField.setCustomUI(withPlaceholder: "Alamat")
        
        picker.delegate = self
        picker.dataSource = self
        
        if UserDefaults().checkSession() == Session.loggedIn.rawValue{
            loadData()
        }
    }
    
    // gender picker function
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
        genderTextField.text = data[row]
        genderTextField.resignFirstResponder()
    }
    
    // birthday picker function
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
        birthdayTextField.setCustomUI(withPlaceholder: "Tanggal lahir")
        birthdayTextField.inputView =  datePicker
        birthdayTextField.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @objc func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "userdata"){
            do{
                let decoder = JSONDecoder()
                let userdata = try decoder.decode(UserProfile.self, from: data)
                nameTextField.text = userdata.firstname+" "+userdata.lastname
                emailTextField.text = userdata.email
                ktpTextField.text = userdata.identity
                addressTextField.text = userdata.address
            }catch{
                print(error)
            }
        }
        
    }
}

