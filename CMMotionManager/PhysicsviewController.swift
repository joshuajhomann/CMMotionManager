//
//  PhysicsviewController.swift
//  CMMotionManger
//
//  Created by Joshua Homann on 1/15/18.
//  Copyright © 2018 com.josh. All rights reserved.
//

import UIKit

class PhysicsviewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var downLabel: UILabel!

    // MARK: - Variables
    private var gravity: UIGravityBehavior!
    private var collision: UICollisionBehavior!
    private var views: [UIView] = []
    private var dynamicAnimation: UIDynamicAnimator!

    // MARK: - Constants
    private let rowCount = 10
    private let columnCount = 10
    private let interItemSpacing: CGFloat = 10
    private let pollingInterval: TimeInterval = 1.0 / 30.0
    private let up = CGPoint(x: 0, y: 1)

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(activate), name: .tabBarSelected, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activate()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        views.forEach {$0.removeFromSuperview()}
        dynamicAnimation?.removeAllBehaviors()
        let width = (view.bounds.width - interItemSpacing * CGFloat(columnCount + 1)) / CGFloat(columnCount)
        views = (0..<rowCount * columnCount).map { index in
            let y = CGFloat(index / columnCount)
            let x = CGFloat(index % columnCount)
            let xCenter = interItemSpacing + (x * (interItemSpacing + width))
            let yCenter = interItemSpacing + (y * (interItemSpacing + width))
            let view = UIView(frame: CGRect(x: xCenter , y: yCenter, width: width, height: width))

            let color = UIColor(red: x.truncatingRemainder(dividingBy: 3) / 2.5, green:  (x + y + 1).truncatingRemainder(dividingBy:2.5), blue: ( y.truncatingRemainder(dividingBy: 3) + x).truncatingRemainder(dividingBy: 3)/2.5, alpha: 1)
            view.backgroundColor = color.withAlphaComponent(0.5)
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = 1
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
        views.forEach { self.view.addSubview($0) }
        collision = UICollisionBehavior(items: views)
        collision.translatesReferenceBoundsIntoBoundary = true
        gravity = UIGravityBehavior(items: views)
        dynamicAnimation = UIDynamicAnimator(referenceView: view)
        dynamicAnimation.addBehavior(collision)
        dynamicAnimation.addBehavior(gravity)
    }

    deinit {
        Constant.motionManger.stopDeviceMotionUpdates()
    }
    
    // MARK: - Instance Methods
    @objc private func activate() {
        guard tabBarController?.selectedViewController == self else {
            Constant.motionManger.stopDeviceMotionUpdates()
            return
        }
        guard Constant.motionManger.isAccelerometerAvailable else {
            return
        }
        Constant.motionManger.accelerometerUpdateInterval = pollingInterval
        Constant.motionManger.startDeviceMotionUpdates(to: .main) { [unowned self] data, error in
            guard let data = data else {
                return
            }
            let rotation = CGFloat(atan2(data.gravity.x, data.gravity.y)) - CGFloat.pi
            self.downLabel.transform = CGAffineTransform(rotationAngle: rotation)
            let transformedUp = self.up.applying(CGAffineTransform(rotationAngle: rotation))
            self.gravity.gravityDirection = CGVector(dx: transformedUp.x, dy: transformedUp.y)
        }
    }
}
