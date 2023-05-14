//
//  SecondSettingsViewController.swift
//  ScrollView
//
//  Created by Aleksei Permiakov on 12.05.2023.
//

import UIKit

class SecondSettingsViewController: UIViewController {
    
    weak var delegate: SettingsControllerDelegate?
    
    lazy var tapMeButton: UIButton = {
        let button = UIButton(
            configuration: .filled(),
            primaryAction: .init(
                handler: {[weak self] _ in
                    self?.delegate?.toggleColorSwitch()
                }))
        button.setTitle("Tap me", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Toggle previous"
        
        view.addSubview(tapMeButton)
        tapMeButton.frame = .init(origin: .zero, size: .init(width: 150, height: 40))
        tapMeButton.center = view.center
    }
}
