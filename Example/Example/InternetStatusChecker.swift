//
//  InternetStatusChecker.swift
//  Example
//
//  Created by Rizvan on 16/06/2019.
//  Copyright © 2019 R13App. All rights reserved.
//

import Foundation
import Alamofire

typealias MbInSec = Double

final class InternetStatusChecker {
    private static var instance: InternetStatusChecker!
    static var shared: InternetStatusChecker {
        if instance == nil {
            instance = InternetStatusChecker()
        }
        return instance
    }
    
    private var timer: Timer?
    private lazy var reachabilityManager = NetworkReachabilityManager()
    
    public var isReachable: Bool {
        return self.reachabilityManager?.isReachable ?? false
    }
    
    public var state: NetworkState = .unknown

    public var timeInterval: TimeInterval = 3 * 60 //3 min
    public var speed: MbInSec = 0
    
    enum InternetSpeedState {
        case low(speed: MbInSec), hight(speed: MbInSec), unknown
    }
    
    enum NetworkState {
        case reachable(speed: InternetSpeedState), unreachable, unknown
    }
    
    private init() {
        startInternetStatusCheckLoop()
    }
    
    private func startInternetStatusCheckLoop() {
        internetStatusCheck()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(internetStatusCheck), userInfo: nil, repeats: true)
    }
    
    @objc private func internetStatusCheck() {
        guard isReachable else {
                state = .unreachable
            return
        }
        DispatchQueue.global(qos: .default).async {
            let url = "https://www.pixelstalk.net/wp-content/uploads/2016/07/3D-HD-Nature-Images-For-Desktop.jpg"
            let startTime = Date()
            request(url).response { responseInfo in
                guard let response = responseInfo.response else { return }
                let length = CGFloat(response.expectedContentLength) / 1000000
                let elapsed = CGFloat( Date().timeIntervalSince(startTime))
                
                let speed = length / elapsed
                let actualSpeed = abs(speed)
                
                let _speed = actualSpeed * 10000000
                self.speed = MbInSec(String(format:"%.4f", _speed)) ?? 0.0
                let speedState: InternetSpeedState = actualSpeed > 7e-8 ? .hight(speed: self.speed) : .low(speed: self.speed)
                self.state = .reachable(speed: speedState)
                
                print("[\(Date().toString) Internet Status], IsReachable: \(true), Speed State: \(speedState), Speed: \(self.speed)Mb/s")
            }
        }
    }
}
