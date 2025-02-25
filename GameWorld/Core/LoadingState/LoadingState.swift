//
//  LoadingState.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case success(T)
    case error(Error)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var error: Error? {
        if case .error(let error) = self { return error }
        return nil
    }

    var value: T? {
        if case .success(let value) = self { return value }
        return nil
    }
}
