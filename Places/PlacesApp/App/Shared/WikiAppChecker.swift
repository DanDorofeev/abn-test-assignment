//
//  Coordinator.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation
import UIKit

protocol WikiAppCheckerProtocol {
  func isWikiAppInstalled() -> Bool
}

final class WikiAppChecker: WikiAppCheckerProtocol {
  func isWikiAppInstalled() -> Bool {
    guard let url = URL(string: "wikipedia://") else {
        return false
    }
    return UIApplication.shared.canOpenURL(url)
  }
}
