//
//  EventDetailsView.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import SwiftUI

///
///  Display Event Details
///
struct EventDetailsView: View {
    /// Presentator
    @ObservedObject var favoriteManager = FavoriteManager()
    var event : EventsResponse.Event?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Rectangle()
                        .fill(Color.darkGray)
                        .frame(width: geometry.size.width, height: Constants.TopColorHeight)
                    Spacer()
                }
                VStack {
                    Text(Constants.EventDetailsTitle)
                        .font(.system(size: Constants.BodyFont))
                        .foregroundColor(Color.white)
                        .padding(.top, Constants.HeaderTopPadding)
                        .padding(.bottom, Constants.HeaderBottomPadding)

                    self.titleSection
                    self.heartButtonSection

                    .padding(.leading, Constants.SidePadding)
                    .padding(.trailing, Constants.SidePadding)

                    self.imageSection
                    VStack(alignment: .leading) {
                        self.datetimeSection
                        self.locationSection
                    }
                    Spacer()
                }
            }
        }
        .onAppear() {
            if event == nil {
                return
            }
            self.favoriteManager.setId(id: event!.id)
        }
        .foregroundColor(Color.white)
        .edgesIgnoringSafeArea(.top)
    }
}

///
/// Display Each Sections
///
private extension EventDetailsView {
    /// Display Title
    var titleSection : some View {
        Text(event!.title)
            .font(.system(size: Constants.TitleFont))
            .frame(height: Constants.TitleHeight)
            .foregroundColor(Color.black)
    }
    /// Display Image
    var imageSection : some View {
        URLImage(url: event!.performers[0].image, height: Constants.DetailsImageHeight, ratio: Constants.EventImageRatio)
            .padding(.top, Constants.ImageTopPadding)
    }
    /// Display Local Date & Time
    var datetimeSection : some View {
        // Todo: update modify time format
        Text(event!.datetime_local.eventDateFormat())
        .font(.system(size: Constants.BodyFont))
        .foregroundColor(Color.darkGray)
    }
    /// Display City, State
    var locationSection : some View {
        Text(event!.venue.display_location)
        .font(.system(size: Constants.CaptionFont))
        .foregroundColor(Color.darkGray)
    }
    /// Display Heart Button for Favorite
    var heartButtonSection : some View {
        Button(action: {
            favoriteManager.updateFavorite()
        }) {
            if self.favoriteManager.isFavorite {
                Image(systemName: Constants.HeartButtonOnImage)
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width: Constants.HeartWidth, height: Constants.HeartHeight)
            }
            else {
                Image(systemName: Constants.HeartButtonOffImage)
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width: Constants.HeartWidth, height: Constants.HeartHeight)
            }
        }
    }
}


struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(event: nil)
    }
}
