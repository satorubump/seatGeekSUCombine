//
//  FavoritManager.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import Foundation

///
///
///
class FavoriteManager : ObservableObject {
    ///
    @Published var isFavorite = false
    var id : Int?
    ///
    func setId(id: Int) -> Void {
        self.id = id
        if let favors = UserDefaults.standard.array(forKey: "favorites") {
            let favorites = favors as! [Int]
            self.isFavorite = favorites.contains(id)
        }
        else {
            self.isFavorite = false
        }
    }
    ///
    func updateFavorite() -> Void {
        if self.id == nil {
            return
        }
        if let favors = UserDefaults.standard.array(forKey: "favorites") {
            var favorites = favors as! [Int]
            if self.isFavorite {
                if let index = favorites.firstIndex(of: self.id!) {
                    favorites.remove(at: index)
                }
                self.isFavorite = false
            }
            else {
                favorites.append(self.id!)
                self.isFavorite = true
            }
            UserDefaults.standard.set(favorites, forKey: "favorites")
        }
        else {
            self.isFavorite = true
            var favorites = [Int]()
            favorites.append(self.id!)
            UserDefaults.standard.set(favorites, forKey: "favorites")
        }
    }
}
