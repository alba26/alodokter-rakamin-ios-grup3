//
//  ChangeDataViewController.swift
//  testProject2
//
//  Created by Finsen Antonius on 09/12/21.
//

import UIKit

class ChangeDataViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ktpTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var changeButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true){
            
        }
    }
    
    let changeVM = ChangeDataViewModel()
    let data = ["Pria", "Wanita"]
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    let utils = Utility()
    var spinner = Utility().showSpinner()
    var id:Int?
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
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
        textFieldDelegate()
        phoneTextField.addDoneButtonOnKeyboard()
        ktpTextField.addDoneButtonOnKeyboard()
        phoneTextField.keyboardType = .numberPad
        createDatePicker()
        genderTextField.inputView  = picker
        changeTextField()
        setup()
        picker.dataSource = self
        picker.delegate = self
        if UserDefaults().checkSession() == Session.loggedIn.rawValue{
            loadData()
        }
        
        changeVM.changeDataSuccess = { [self] msg in
            spinner.dismiss(animated: true, completion: {
                utils.showAlertAction(title: "Ubah Data Berhasil", message: msg ?? "Ubah Data Berhasil.", uiview: self, action: true)
            })
            allFieldDisabled()
        }

        changeVM.changeDataFailed = { [self] msg in
            spinner.dismiss(animated: true, completion: {
                utils.showAlertAction(title: "Ubah Data Gagal", message: msg ?? "", uiview: self, action: true)
            })
        }
//
//        changeVM.emailValidationMsg = {[self] msg in
//            emailValidation.text = msg
//        }
//
//        changeVM.identityValidationMsg = {[self] msg in
//            ktpValidation.text = msg
//
//        }
//
    }
    

    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
        
    @IBAction func changeButtonPressed(_ sender: Any) {
        allFieldEnabled()
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        let birthdateConvert = Utility().convertDateToAPIFormat(date: birthdayTextField.text ?? "")
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            return
        }

        self.present(spinner, animated: true, completion: nil)
        changeVM.changeData(token: token , id: id ?? 0, email: emailTextField.text ?? "", fullname: nameTextField.text ?? "", birthdate: birthdateConvert , gender: genderTextField.text ?? "", phone: phoneTextField.text ?? "", identity: ktpTextField.text ?? "", address: addressTextField.text ?? "")
        
    }


    @IBAction func convertDates(_ sender: Any) {
        birthdayTextField.text = utils.convertDateFromDatePicker(date: self.datePicker.date)
    }
    
    @IBAction func test(_ sender: Any) {

    }
    
    
    
//    @IBAction func emailCheck(_ sender: Any) {
//        changeVM.emailValidation(email: emailTextField.text ?? "")
//    }
//
//    @IBAction func phoneCheck(_ sender: Any) {
//        changeVM.phoneValidation(phone: phoneTextField.text ?? "")
//    }
//
//
//    @IBAction func identityChec(_ sender: Any) {
//        changeVM.identityValidation(identity: ktpTextField.text ?? "")
//    }
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "userdata"){
            do{
                let decoder = JSONDecoder()
                let userdata = try decoder.decode(UserProfile.self, from: data)
                id = userdata.id
                nameTextField.text = userdata.fullname
                emailTextField.text = userdata.email
                birthdayTextField.text = Utility().convertDateToIOSFormat(date: userdata.birthdate ?? "")
                genderTextField.text = userdata.gender
                ktpTextField.text = userdata.identity
                addressTextField.text = userdata.address
                phoneTextField.text = userdata.phone
            }catch{
                print(error) //OUTPUT ERROR
            }
        }
        
    }

}

extension ChangeDataViewController{
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
        datePicker.locale = Locale(identifier: "id")
        
        birthdayTextField.isUserInteractionEnabled = false
        birthdayTextField.backgroundColor = UIColor.systemGray6
        birthdayTextField.inputView =  datePicker
        birthdayTextField.inputAccessoryView = createToolbar()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
}

extension ChangeDataViewController{
    private func changeTextField(){
        nameTextField.setCustomUI(withPlaceholder: "Nama")
        ktpTextField.setCustomUI(withPlaceholder: "No. KTP")
        emailTextField.setCustomUI(withPlaceholder: "Email")
        genderTextField.setCustomUI(withPlaceholder: "Pria/Wanita")
        addressTextField.setCustomUI(withPlaceholder: "Alamat")
        birthdayTextField.setCustomUI(withPlaceholder: "Tanggal Lahir")
        phoneTextField.setCustomUI(withPlaceholder: "No. Handphone")
    }
    
    private func setup(){
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
        ktpTextField.keyboardType = .numberPad
        phoneTextField.isUserInteractionEnabled = false
        phoneTextField.backgroundColor = .systemGray6
        saveButton.isHidden = true
        self.datePicker.locale = Locale(identifier: "id")
    }
    
    private func allFieldDisabled(){
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        genderTextField.isUserInteractionEnabled = false
        ktpTextField.isUserInteractionEnabled = false
        addressTextField.isUserInteractionEnabled = false
        phoneTextField.isUserInteractionEnabled = false
        nameTextField.backgroundColor = UIColor.systemGray6
        emailTextField.backgroundColor = UIColor.systemGray6
        genderTextField.backgroundColor = UIColor.systemGray6
        ktpTextField.backgroundColor = UIColor.systemGray6
        addressTextField.backgroundColor = UIColor.systemGray6
        birthdayTextField.backgroundColor = UIColor.systemGray6
        phoneTextField.backgroundColor = .systemGray6
        saveButton.isHidden = true
        changeButton.isEnabled = true
        changeButton.tintColor = UIColor.white
    }
    
    private func allFieldEnabled(){
        nameTextField.isUserInteractionEnabled = true
        emailTextField.isUserInteractionEnabled = true
        birthdayTextField.isUserInteractionEnabled = true
        genderTextField.isUserInteractionEnabled = true
        ktpTextField.isUserInteractionEnabled = true
        addressTextField.isUserInteractionEnabled = true
        phoneTextField.isUserInteractionEnabled = true
        nameTextField.backgroundColor = UIColor.white
        emailTextField.backgroundColor = UIColor.white
        genderTextField.backgroundColor = UIColor.white
        ktpTextField.backgroundColor = UIColor.white
        addressTextField.backgroundColor = UIColor.white
        birthdayTextField.backgroundColor = UIColor.white
        phoneTextField.backgroundColor = .white
        saveButton.isHidden = false
        changeButton.isEnabled = false
        changeButton.tintColor = UIColor.clear
        
    }
    
    private func textFieldDelegate(){

        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        emailTextField.delegate = self
        emailTextField.returnKeyType = .done
        addressTextField.delegate = self
        addressTextField.returnKeyType = .done
        
        
    }
    
    
}

