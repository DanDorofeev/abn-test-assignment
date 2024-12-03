//
//  LocationsRouter.swift
//  Places
//
//  Created by Daniil Dorofieiev on 02/12/2024.
//

import Foundation
import UIKit
import SwiftUI

protocol LocationsRouterProtocol {
  func openExternalUrl(_ url: URL)
}

final class LocationsRouter: LocationsRouterProtocol {
    
  func openExternalUrl(_ url: URL) {
    guard UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url)
  }
}
