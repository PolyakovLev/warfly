//
//  LocatinManager.swift
//  WarFly
//
//  Created by гость on 04.11.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreLocation
import SMTPLite

class LocatinManager: NSObject, CLLocationManagerDelegate {
    var clManager = CLLocationManager()
    var region = CLCircularRegion(center: CLLocationCoordinate2DMake(55.805801, 37.845076), radius: 200, identifier: "петя хаус")
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        var message = SMTPMessage()
        message.from = "cllocation@yandex.ru"
        message.to = "www.goldfox@gmail.com"
        message.host = "smtp.yandex.ru"
        message.account = "cllocation@yandex.ru"
        message.pwd = "1234567Aa"
        message.subject = "Elon location"
        message.content = "приехала"
        message.send({ (_, _, _) in
        }, success: { (_) in
            print("message send")
        }) { (_, error) in
            print("error: \(error)")
        }
    }
     public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        var message = SMTPMessage()
        message.from = "cllocation@yandex.ru"
        message.to = "www.goldfox@gmail.com"
        message.host = "smtp.yandex.ru"
        message.account = "cllocation@yandex.ru"
        message.pwd = "1234567Aa"
        message.subject = "Elon location"
        message.content = "уехала"
        message.send({ (_, _, _) in
        }, success: { (_) in
            print("message send")
        }) { (_, error) in
            print("error: \(error)")
        }
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        startMonitoring()
    }
    func startMonitoring() {
        clManager.startMonitoring(for: region)

    }

    override init() {
        super.init()
        clManager.delegate = self
        clManager.requestAlwaysAuthorization()
        region.notifyOnEntry = true
        region.notifyOnExit = true
        startMonitoring()
    }
}
