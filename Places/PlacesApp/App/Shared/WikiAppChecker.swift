//
//  Coordinator.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation
import UIKit

protocol WikiAppCheckerProtocol {
  func canOpenWikiScheme() -> Bool
}

final class WikiAppChecker: WikiAppCheckerProtocol {
  func canOpenWikiScheme() -> Bool {
    guard let url = URL(string: "wikipedia://app") else {
        return false
    }    
    return UIApplication.shared.canOpenURL(url)
  }
}
