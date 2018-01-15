//
//  AccelerometerViewController.swift
//  CMMotionManger
//
//  Created by Joshua Homann on 1/15/18.
//  Copyright © 2018 com.josh. All rights reserved.
//

import UIKit

class AccelerometerViewController: UIViewController {
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
        Constant.motionManger.stopAccelerometerUpdates()
    }

    // MARK: - Instance Methods
    @objc private func activate() {
        guard tabBarController?.selectedViewController == navigationController else {
            Constant.motionManger.stopAccelerometerUpdates()
            return
        }
        guard Constant.motionManger.isAccelerometerAvailable else {
            return
        }
        Constant.motionManger.accelerometerUpdateInterval = Constant.updateInterval
        Constant.motionManger.startAccelerometerUpdates(to: .main) { [unowned self] data, error in
            guard let data = data else {
                return
            }
            self.xLabel.text = Constant.decimalFormatter.string(for: data.acceleration.x)
            self.yLabel.text = Constant.decimalFormatter.string(for: data.acceleration.y)
            self.zLabel.text = Constant.decimalFormatter.string(for: data.acceleration.z)
        }
    }
}
