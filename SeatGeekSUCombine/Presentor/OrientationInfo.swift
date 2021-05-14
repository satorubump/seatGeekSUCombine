//
//  OrientationInfo.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import Foundation
import SwiftUI

///
///  Observable Device Orientation Status
///
final class OrientationInfo: ObservableObject {
    /// Portrait  or  Landscape Status
    enum Orientation {
        case portrait
        case landscape
    }
    /// Observed Orientation
    @Published var orientation : Orientation
    @Published var iconHeight : CGFloat
    
    private var _observer: NSObjectProtocol?
    
    init() {
        if UIDevice.current.orientation.isLandscape {
            self.orientation = .landscape
        }
        else {
            self.orientation = .portrait
        }

        self.iconHeight = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

        ///
        ///  Device Orientation Receiver
        ///
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { [weak self] note in
            
            guard let device = note.object as? UIDevice else {
                return
            }
            if device.orientation.isPortrait {
                self!.orientation = .portrait
            }
            else if device.orientation.isLandscape {
                self!.orientation = .landscape
            }
            self!.iconHeight = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        }
    }
    
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
