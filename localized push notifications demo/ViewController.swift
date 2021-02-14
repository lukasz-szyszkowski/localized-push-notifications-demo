//
//  ViewController.swift
//  localized push notifications demo
//
//  Created by Łukasz Szyszkowski on 09/02/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var languageControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedController()
        languageControl.addTarget(self, action: #selector(didChangeLanguage), for: .valueChanged)
    }
    
    private func setupSegmentedController() {
        languageControl.removeAllSegments()
        
        for (index, language) in LanguageController.shared.availableLanguages.enumerated() {
            languageControl.insertSegment(withTitle: language.name, at: index, animated: false)
        }
        
        if let selectedIndex = LanguageController.shared.index(for: LanguageController.shared.getLanguage()) {
            languageControl.selectedSegmentIndex = selectedIndex
        } else {
            languageControl.selectedSegmentIndex = .zero
        }
    }

    @objc private func didChangeLanguage(_ control: UISegmentedControl) {
        guard let language = LanguageController.shared.getLanguage(at: control.selectedSegmentIndex) else {
            fatalError("Incorrect language index")
        }
        
        LanguageController.shared.setLanguage(language.code)
    }
}

