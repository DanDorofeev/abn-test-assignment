//
//  LocationsListView.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import SwiftUI

struct LocationsListView<VM: LocationsListViewModelProtocol>: View {
  
  @ObservedObject var viewModel: VM
  
    var body: some View {
      List {
        Section {
          ForEach(viewModel.locations) { location in
            LocationCell(location: location)
          }
        }
      }
      .onAppear {
        viewModel.loadLocations()
      }
    }
}

#Preview {
  LocationsListView(viewModel: MockLocationsListViewModel())
}
