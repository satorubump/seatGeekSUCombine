//
//  SearchEventsView.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import SwiftUI

///
///  Search events form & Display events list
///
struct SearchEventsView: View {
    /// View Model
    @ObservedObject var viewModel : SearchEventsViewModel
    /// Event
    @State var event_name : String = ""
    @State var showClearButton = false
    @State var width : CGFloat = 0.0
    
    init(viewModel: SearchEventsViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Rectangle()
                            .fill(Color.darkGray)
                            .frame(width: geometry.size.width, height: Constants.TopColorHeight
                            )
                        Spacer()
                    }
                    VStack(alignment: .center) {
                        self.searchFieldSection
                            .padding(.top, Constants.SearchFieldTopPadding)
                        if viewModel.eventsResponse != nil {
                            self.eventsListSection
                        }
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .onAppear() {
                    self.width = geometry.size.width
                    self.viewModel.isUpdate.toggle()
                }
            }
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.top)

    }
}

///
/// View Sections for SearchEventsView
///
private extension SearchEventsView {
    ///  Text Field for Search Events
    var searchFieldSection : some View {
        
        HStack {
            Image(systemName: Constants.Iconfinder)
                    .resizable()
                    .frame(width: Constants.FieldIconWidth, height: Constants.FieldIconHeight)
                    .aspectRatio(contentMode: .fit)
                    .background(Color.darkGray)
                    .foregroundColor(Color.white)
            ZStack {
                if self.event_name.count == 0 {
                    VStack(alignment: .leading) {
                        Text(Constants.FieldPlaceHolder).foregroundColor(Color.gray)
                    }
                }
                TextField(Constants.FieldPlaceHolder, text: $event_name, onEditingChanged: { editing in
                    self.showClearButton = editing
                }, onCommit: {
                    viewModel.searchEvents(event: event_name)
                })
                .modifier( ClearButton(text: $event_name, visible: $showClearButton))
                .offset(x: 5)
                .keyboardType(.default)
                .font(.system(size: Constants.TitleFont))
                .foregroundColor(Color.white)
                .background(Color.black)
                .frame(width: Constants.FieldWidth)
                .autocapitalization(.none)
            }
        }
        .padding(.bottom, Constants.SearchFieldBottomPadding)
        .background(Color.darkGray)
    }
    ///
    var eventsListSection : some View {
        GeometryReader { _p in
            List {
                ForEach(self.viewModel.eventsResponse!.events, id: \.id) { event in
                    NavigationLink(destination: EventDetailsView(event: event)) {
                        HStack(alignment: .top) {
                            VStack {
                                URLImage(url: event.performers[0].image)
                            }
                            VStack(alignment: .leading) {
                                Text(event.title.prefix(Constants.TitleLengthLimit))
                                    .font(.system(size: Constants.ListFont))
                                    .foregroundColor(Color.black)
                                Text(event.datetime_local.eventDateFormat())
                                Text(event.venue.display_location)
                            }
                            .font(.system(size: Constants.CaptionFont))
                            .foregroundColor(Color.gray)
                            if self.viewModel.isFavorite(id: event.id) {
                                Image(systemName: Constants.HeartButtonOnImage)
                                            .resizable()
                                            .foregroundColor(Color.red)
                                            .frame(width: Constants.ListHeartWidth, height: Constants.ListHeartHeight)
                                .frame(width: Constants.ListHeartWidth, height: Constants.ListHeartHeight)
                            }
                        
                        }
                    }
                    .frame(width: _p.size.width)
                }
            }
        }
    }
}

struct SearchEventsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEventsView(viewModel: SearchEventsViewModel())
    }
}

///
struct ClearButton: ViewModifier {
    @Binding var text: String
    @Binding var visible: Bool
    public func body(content: Content) -> some View {
        HStack {
            content
            Image(systemName: Constants.ClearButtonImage)
                .foregroundColor(Color.gray)
                .opacity(visible ? 1 : 0)
                .onTapGesture {
                    self.text = ""
                }
        }
    }
}
extension Color {
    static let darkGray = Color(red: 50 / 255, green: 66 / 255, blue: 76 / 255)
}
