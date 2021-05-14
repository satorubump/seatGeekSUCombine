//
//  Constants.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import Foundation
import SwiftUI

///
///  Constants Value Table
///
struct Constants {
    
    /// API
    static let ClientId = "MjE5MDc4MjN8MTYyMDg3NDgxNy4wODIwOTA5"
    static let Scheme = "https"
    static let Host = "api.seatgeek.com"
    static let Path = "/2/events"
    
    /// Auguments
    static let Client_Id = "client_id"
    static let Q = "q"
    
    /// Label, Title & Image Name
    static let PlaceholderImage = "icloud.and.arrow.down"
    static let Iconfinder = "magnifyingglass"
    static let EventDetailsTitle = "Details"
    static let FieldPlaceHolder = "Please type event"
    static let ClearButtonImage = "multiply.circle.fill"
    static let HeartButtonOnImage = "heart.fill"
    static let HeartButtonOffImage = "heart"

    /// Font Size
    static let TitleFont : CGFloat = 25.0
    static let ListFont : CGFloat = 18.0
    static let BodyFont : CGFloat = 21.0
    static let CaptionFont : CGFloat = 18.0
    static let TitleLengthLimit = 27

    /// View Layout
    
    /// Header
    static let TopColorHeight : CGFloat = 90.0
    static let HeaderTopPadding : CGFloat = 57.0
    static let HeaderBottomPadding : CGFloat = 35.0
    static let SearchFieldTopPadding : CGFloat = 48.0
    static let SearchFieldBottomPadding : CGFloat = 10.0

    /// List View
    static let FieldIconWidth : CGFloat = 20.0
    static let FieldIconHeight : CGFloat = 20.0
    static let FieldWidth : CGFloat = 300.0
    static let ImageSize : CGFloat = 100.0
    static let ImageAspectRatio : CGFloat = 1.0

    static let ListImageHeight : CGFloat = 60.0
    
    static let HeartWidth : CGFloat = 20.0
    static let HeartHeight : CGFloat = 20.0
    static let ListHeartWidth : CGFloat = 10.0
    static let ListHeartHeight : CGFloat = 10.0
    
    /// Details View
    static let SidePadding : CGFloat = 10.0
    static let TitleHeight : CGFloat = 30.0
    static let DetailsImageHeight : CGFloat = 300.0
    static let ImageTopPadding : CGFloat = 20.0
    static let EventImageRatio : CGFloat = 1.2
}
