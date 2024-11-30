//
//  AddLocationView.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import SwiftUI
import Combine

struct AddLocationView<VM: AddLocationViewModelProtocol>: View {
  
  @ObservedObject var viewModel: VM
  
  var body: some View {
    List {
      Section(header: Text(LocalizedStringKey("add.location.section.title"))) {
        TextField(LocalizedStringKey("add.location.name.label"), text: .constant(""))
        TextField(LocalizedStringKey("add.location.lat.label"), text: .constant(""))
        TextField(LocalizedStringKey("add.location.long.label"), text: .constant(""))
      }
      .headerProminence(.increased)
    }
  }
}

#Preview {
  AddLocationView(viewModel: MockAddLocationViewModel())
}
