//
//  Result.swift
//  RExtension
//
//  Created by Quentin on 03/03/2022.
//

import Foundation

extension Result where Success == Void {
    public static func success() -> Self { .success(()) }
}
