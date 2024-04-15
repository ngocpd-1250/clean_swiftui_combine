//
//  RSwift+.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import RswiftResources
import Defaults

extension StringResource {
    public func callAsFunction() -> String {
        String(resource: self, preferredLanguages: [Defaults[.language]])
    }
}
