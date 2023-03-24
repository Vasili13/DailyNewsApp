//
//  UserProfile.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 23.03.23.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .clipShape(Circle())
                .frame(width: 200, height: 200)
                .shadow(radius: 10)
            List {
                Section(header: Text("Info")) {
                    Text("Name")
                    Text("email@email")
                }
                Section(header: Text("Settings")) {
                    HStack {
                        Image(systemName: "bookmark")
                        Text("Saved News")
                    }
                    HStack {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }.foregroundColor(.red)
                }
                
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
