//
//  TransbankLandingRoutingLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank
import Foundation

class TransbankLandingRoutingLogicSpy: NSObject, TransbankLandingRoutingLogic, TransbankLandingDataPassing {
    var dataStore: TransbankLandingDataStore?
    
    var routeToTransbankCalled = false
    
    func routeToTransbank() {
        routeToTransbankCalled = true
    }
}
