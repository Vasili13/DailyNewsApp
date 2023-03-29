//
//  UserProfile.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 23.03.23.
//

import SwiftUI
import _PhotosUI_SwiftUI
import Firebase
import FirebaseAuth

struct UserProfile: View {
//
//    @State private var user: User
    
    @StateObject var imagePicker = ImagePicker()
    var body: some View {
        VStack {
            VStack {
                if let image = imagePicker.image {
                    image
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 200, height: 200)
                        .shadow(radius: 10)
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 200, height: 200)
                        .shadow(radius: 10)
                }
            }
                PhotosPicker(selection: $imagePicker.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Text("Add User Image")
            }
            List {
                Section(header: Text("Info")) {
                    Text("Name")
                    Text("text.email")
                }
//                Button("try") {
//                    guard let currentUser = Auth.auth().currentUser else {
//                        return
//                    }
//                    // сохраним currentUser
//                    user = User(user: currentUser)
//                    print(user)
//                }
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
