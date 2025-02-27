//
//  Destination.swift
//  Domain
//
//  Created by Anjar Harimurti on 27/02/25.
//

import Foundation
import Domain

public enum Destination: Hashable {
    case dashboard
    case gameDetail(Game)
    case profile
    case favorite
}
