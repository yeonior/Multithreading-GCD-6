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
    private var number = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectsPickerView.dataSource = self
        objectsPickerView.delegate = self
        objectsPickerView.selectRow(0, inComponent: 0, animated: false)
        noBarrierButton.layer.cornerRadius = 15
        barrierButton.layer.cornerRadius = 15
    }
    
    // race condition example
    private func sendWithNoBarrier(objectsNumber: Int) {
        DispatchQueue.concurrentPerform(iterations: objectsNumber) { index in
            array.append(index)
            DispatchQueue.main.async {
                self.receivedObjectsLabel.text = "Received objects: \(self.array.count)"
                print(self.array)
            }
        }
    }
    
    @IBAction func noBarrierButtonAction(_ sender: UIButton) {
        array.removeAll()
        sendWithNoBarrier(objectsNumber: number)
    }
    
    // safe writing with barrier
    private func sendWithBarrier(objectsNumber: Int) {
        DispatchQueue.concurrentPerform(iterations: objectsNumber) { index in
            queue.async(flags: .barrier) { [unowned self] in
                self.array.append(index)
            }
        }
    }
    
    // safe reading
    private func getObjects() -> String {
        var result = "Received objects: N/A"
        queue.sync {
            result = "Received objects: \(self.array.count)"
        }
        return result
    }
    
    @IBAction func barrierButtonAction(_ sender: UIButton) {
        array.removeAll()
        sendWithBarrier(objectsNumber: number)
        receivedObjectsLabel.text = getObjects()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        20
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        number = row + 1
    }
}

