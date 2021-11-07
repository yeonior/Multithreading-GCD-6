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
    private var pickerNumber = 5000
    private var number = 0 {
        didSet {
            print(number)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectsPickerView.dataSource = self
        objectsPickerView.delegate = self
        objectsPickerView.selectRow(pickerNumber - 1, inComponent: 0, animated: false)
        noBarrierButton.layer.cornerRadius = 15
        barrierButton.layer.cornerRadius = 15
        receivedObjectsLabel.adjustsFontSizeToFitWidth = true
        receivedObjectsLabel.minimumScaleFactor = 0.7
    }
    
    // race condition example
    private func sendWithNoBarrier(objectsNumber: Int) {
        DispatchQueue.concurrentPerform(iterations: objectsNumber) { index in
            self.number += 1
            DispatchQueue.main.async {
                self.receivedObjectsLabel.text = "Received objects: \(self.number)"
            }
        }
    }
    
    @IBAction func noBarrierButtonAction(_ sender: UIButton) {
        number = 0
        sendWithNoBarrier(objectsNumber: pickerNumber)
    }
    
    // safe writing with barrier
    private func sendWithBarrier(objectsNumber: Int) {
        DispatchQueue.concurrentPerform(iterations: objectsNumber) { index in
            queue.async(flags: .barrier) { [unowned self] in
                self.number += 1
            }
        }
    }
    
    // safe reading
    private func getObjects() -> String {
        var result = "Received objects: N/A"
        queue.sync {
            result = "Received objects: \(self.number)"
        }
        return result
    }
    
    @IBAction func barrierButtonAction(_ sender: UIButton) {
        number = 0
        sendWithBarrier(objectsNumber: pickerNumber)
        receivedObjectsLabel.text = getObjects()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerNumber
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerNumber = row + 1
    }
}

