//
//  SettingsViewController.swift
//  ScrollView
//
//  Created by Aleksei Permiakov on 12.05.2023.
//

import UIKit

protocol SettingsControllerDelegate: AnyObject {
    func toggleColorSwitch()
}

class SettingsViewController: UIViewController {
    
    var switchIsOn = false {
        didSet {
            colorSwitch.isOn = switchIsOn
            UIView.animate(withDuration: 0.5) {
                self.squareView.backgroundColor = self.switchIsOn ? .systemMint : .systemIndigo
                self.squareView.layer.cornerRadius = self.switchIsOn ? 75 : 16
            }
        }
    }
    
    lazy var colorSwitch = UISwitch(frame: .zero,
                          primaryAction: .init(handler: { _ in
            self.switchIsOn.toggle()
        }))
    
    lazy var squareView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupNavBar() {
        let rightBarButton = UIBarButtonItem(
            title: "Next",
            image: UIImage(systemName: "cross"),
            primaryAction: .init(handler: { _ in
                let vc = SecondSettingsViewController()
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }))
        rightBarButton.tintColor = .systemTeal
        
        navigationItem.setRightBarButton(rightBarButton, animated: false)
    }
    
    func setupViews() {
        title = "Settings"
        view.backgroundColor = .systemBackground
        colorSwitch.onTintColor = .systemMint
        
        [colorSwitch, squareView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            colorSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            
            squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            squareView.widthAnchor.constraint(equalToConstant: 150),
            squareView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension SettingsViewController: SettingsControllerDelegate {
    func toggleColorSwitch() {
        colorSwitch.sendActions(for: .valueChanged)
    }
}
