//
//  Constant.swift
//  CMMotionManger
//
//  Created by Joshua Homann on 1/15/18.
//  Copyright © 2018 com.josh. All rights reserved.
//

import CoreMotion

struct Constant {
    static let motionManger = CMMotionManager()
    static let updateInterval: TimeInterval = 1.0 / 10.0
    static var decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.minimumIntegerDigits = 1
        return formatter
    }()
}
