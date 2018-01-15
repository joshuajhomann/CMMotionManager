//
//  MotionService.swift
//  CMMotionManger
//
//  Created by Joshua Homann on 1/15/18.
//  Copyright © 2018 com.josh. All rights reserved.
//

import UIKit
import CoreMotion

class MotionService {
    static let shared = MotionService()
    let manager = CMMotionManager()
    private init() {
    }

}
