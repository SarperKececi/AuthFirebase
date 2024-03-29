//
//  SettingRowView.swift
//  AuthFirebase
//
//  Created by Sarper Kececi on 24.12.2023.
//

import SwiftUI

struct SettingRowView: View {
    let imageName : String
    let title : String
    let tintColor : Color
    
    var body: some View {
        HStack(spacing : 20 ) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
        }
    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
    }
}
