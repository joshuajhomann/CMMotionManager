//
//  GyroscopeViewController.swift
//  CMMotionManger
//
//  Created by Joshua Homann on 1/15/18.
//  Copyright © 2018 com.josh. All rights reserved.
//

import UIKit

class GyroscopeViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(activate), name: .tabBarSelected, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activate()
    }

    deinit {
        Constant.motionManger.stopGyroUpdates()
    }
    
    // MARK: - Instance Methods
    @objc private func activate() {
        guard tabBarController?.selectedViewController == navigationController else {
            Constant.motionManger.stopGyroUpdates()
            return
        }
        guard Constant.motionManger.isGyroAvailable else {
            return
        }
        Constant.motionManger.gyroUpdateInterval = Constant.updateInterval
        Constant.motionManger.startGyroUpdates(to: .main) { [unowned self] data, error in
            guard let data = data else {
                return
            }
            self.xLabel.text = Constant.decimalFormatter.string(for: data.rotationRate.x)
            self.yLabel.text = Constant.decimalFormatter.string(for: data.rotationRate.y)
            self.zLabel.text = Constant.decimalFormatter.string(for: data.rotationRate.z)
        }
    }
}

