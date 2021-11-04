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
    @IBOutlet weak var objectsTextField: UITextField!
    @IBOutlet weak var noBarrierButton: UIButton!
    @IBOutlet weak var barrierButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noBarrierButton.layer.cornerRadius = 15
        barrierButton.layer.cornerRadius = 15
    }
    
    @IBAction func noBarrierButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func barrierButtonAction(_ sender: UIButton) {
        
    }
}

