//
//  SettingsViewController.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var birthdateTextField: UITextField!
    @IBOutlet private weak var currencySegmentedControl: UISegmentedControl!
    @IBOutlet private weak var saveButton: UIButton!
    
    private let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initVM()
    }
    
    @IBAction func saveWarrior(_ sender: Any) {
        endEditing()
        viewModel.saveWarrior(name: nameTextField.text ?? "",
                              surname: surnameTextField.text ?? "",
                              birthdate: (birthdateTextField.inputView as? UIDatePicker)?.date ?? Date(),
                              currency: currencySegmentedControl.titleForSegment(at: currencySegmentedControl.selectedSegmentIndex) ?? "EUR")
    }
    
    private func setupView() {
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(updateDate(sender:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        birthdateTextField.inputView = datePicker
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGR)
    }
    
    private func initVM() {
        viewModel.updateState = { [weak self] state in
            guard let strongSelf = self else { return }
            switch state {
            case .error(let error):
                strongSelf.showError(error)
            case .loaded(let warrior, let availableCurrencies):
                strongSelf.fillForm(warrior: warrior, availableCurrencies: availableCurrencies)
            case .saved(let warrior):
                strongSelf.showMessage("Saved warrior \(warrior.name)")
            }
        }
        viewModel.viewDidLoad()
    }
    
    @objc private func updateDate(sender: UIDatePicker) {
        birthdateTextField.text = sender.date.shortDate
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    private func fillForm(warrior: Warrior?, availableCurrencies: [Currency]) {
        nameTextField.text = warrior?.name
        surnameTextField.text = warrior?.surname
        birthdateTextField.text = warrior?.birthdate.shortDate
        currencySegmentedControl.removeAllSegments()
        availableCurrencies.enumerated().forEach { (index, element) in
            currencySegmentedControl.insertSegment(withTitle: element.rawValue, at: index, animated: false)
        }
        currencySegmentedControl.selectedSegmentIndex = 0
        guard let warrior = warrior else { return }
        for i in 0...currencySegmentedControl.numberOfSegments - 1 {
            if let titleSegment = currencySegmentedControl.titleForSegment(at: i), titleSegment == warrior.currency.rawValue  {
                currencySegmentedControl.selectedSegmentIndex = i
            }
        }
    }
}
