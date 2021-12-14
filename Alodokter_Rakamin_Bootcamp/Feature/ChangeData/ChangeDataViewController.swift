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
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ktpTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var changeButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true){
            
        }
    }
    @IBAction func changeButtonPressed(_ sender: Any) {
        nameTextField.isUserInteractionEnabled = true
        emailTextField.isUserInteractionEnabled = true
        birthdayTextField.isUserInteractionEnabled = true
        genderTextField.isUserInteractionEnabled = true
        ktpTextField.isUserInteractionEnabled = true
        addressTextField.isUserInteractionEnabled = true
        nameTextField.backgroundColor = UIColor.white
        emailTextField.backgroundColor = UIColor.white
        genderTextField.backgroundColor = UIColor.white
        ktpTextField.backgroundColor = UIColor.white
        addressTextField.backgroundColor = UIColor.white
        birthdayTextField.backgroundColor = UIColor.white
        saveButton.isHidden = false
        changeButton.isEnabled = false
        changeButton.tintColor = UIColor.clear
        
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        genderTextField.isUserInteractionEnabled = false
        ktpTextField.isUserInteractionEnabled = false
        addressTextField.isUserInteractionEnabled = false
        nameTextField.backgroundColor = UIColor.systemGray6
        emailTextField.backgroundColor = UIColor.systemGray6
        genderTextField.backgroundColor = UIColor.systemGray6
        ktpTextField.backgroundColor = UIColor.systemGray6
        addressTextField.backgroundColor = UIColor.systemGray6
        birthdayTextField.backgroundColor = UIColor.systemGray6
        saveButton.isHidden = true
        changeButton.isEnabled = true
        changeButton.tintColor = UIColor.white
    }
    
    
    let data = ["Pria", "Wanita"]
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        genderTextField.inputView  = picker
        
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        genderTextField.isUserInteractionEnabled = false
        ktpTextField.isUserInteractionEnabled = false
        addressTextField.isUserInteractionEnabled = false
        nameTextField.backgroundColor = UIColor.systemGray6
        emailTextField.backgroundColor = UIColor.systemGray6
        genderTextField.backgroundColor = UIColor.systemGray6
        ktpTextField.backgroundColor = UIColor.systemGray6
        addressTextField.backgroundColor = UIColor.systemGray6
        
        saveButton.isHidden = true
        
        picker.dataSource = self
        picker.delegate = self
        
        if UserDefaults().checkSession() == Session.loggedIn.rawValue{
            loadData()
        }
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
        birthdayTextField.isUserInteractionEnabled = false
        birthdayTextField.backgroundColor = UIColor.systemGray6
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
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "userdata"){
            do{
                let decoder = JSONDecoder()
                let userdata = try decoder.decode(UserProfile.self, from: data)
                nameTextField.text = userdata.fullname
                emailTextField.text = userdata.email
                birthdayTextField.text = userdata.birthdate
                genderTextField.text = userdata.gender
                ktpTextField.text = userdata.identity
                addressTextField.text = userdata.address
            }catch{
                print(error) //OUTPUT ERROR
            }
        }
        
    }
    

}

