//
//  ViewController.swift
//  AYHorindar
//
//  Created by antonyereshchenko@gmail.com on 08/19/2019.
//  Copyright (c) 2019 antonyereshchenko@gmail.com. All rights reserved.
//

import UIKit
import AYHorindar

class ViewController: UIViewController {
  
  @IBOutlet weak var lblText: UILabel!
  @IBOutlet weak var containerView: UIView!
  
  private let horindarViewController = AYHorindarViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    horindarViewController.delegate = self
    horindarViewController.dataSource = self
    horindarViewController.uiDelegate = self
    
    containerView.addSubview(horindarViewController.view)
    containerView.addAllSidesAnchors(to: horindarViewController.view)
  }
}

extension ViewController: AYHorindarDelegate {
  func current(date: Date) {
    lblText.text = date.log
  }
}

extension ViewController: AYHorindarDataSource { }

extension ViewController: AYHorindarUIDelegate { }

