//
//  ViewController.swift
//  Multithreading-GCD6
//
//  Created by ruslan on 05.11.2021.
//

import UIKit

// practicing with dispatch barriers

final class ViewController: UIViewController {
    
    @IBOutlet weak var receivedObjectsLabel: UILabel!
    @IBOutlet weak var objectsPickerView: UIPickerView!
    @IBOutlet weak var noBarrierButton: UIButton!
    @IBOutlet weak var barrierButton: UIButton!
    
    private let queue = DispatchQueue(label: "X", attributes: .concurrent)
    private var array = [Int]()
    private var number = 1 {
        didSet {
            print(number)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectsPickerView.dataSource = self
        objectsPickerView.delegate = self
        objectsPickerView.selectRow(0, inComponent: 0, animated: false)
        noBarrierButton.layer.cornerRadius = 15
        barrierButton.layer.cornerRadius = 15
    }
    
    private func sendWithNoBarrier(objectsNumber: Int) {
        for i in 0...objectsNumber {
            array.append(i)
        }
    }
    
    @IBAction func noBarrierButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func barrierButtonAction(_ sender: UIButton) {
        
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        number = row + 1
    }
}

