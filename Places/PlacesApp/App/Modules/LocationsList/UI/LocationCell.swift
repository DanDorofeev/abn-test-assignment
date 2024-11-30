//
//  LocationCell.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import SwiftUI

struct LocationCell: View {
  
  let location: Location
  
  var body: some View {
    HStack {
      HStack(spacing: Constants.Spacing.medium) {
          Image(systemName: "mappin.circle.fill")
              .resizable()
              .frame(width: Constants.Icons.small,
                     height: Constants.Icons.small)
              .foregroundColor(.pin)
        
        VStack(alignment: .leading) {
          Text(location.locationName)
            .font(.headline)
            .foregroundColor(.label)
          
          
          Text(location.coordinatesString)
              .font(.subheadline)
              .foregroundColor(.label)
        }
      }
      .accessibilityLabel(location.locationName)
    }
  }
}

#Preview {
  LocationCell(location: Location.testLocation)
}
