//
//  Utils.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation

func infoForKey(_ key: String) -> String {
    return (Bundle.main.infoDictionary?[key] as? String)?
        .replacingOccurrences(of: "\\", with: "") ?? ""
}

func formatDate(_ inputDate: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"

    guard let date = inputFormatter.date(from: inputDate) else {
        return ""
    }

    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMM dd, yyyy"

    return outputFormatter.string(from: date)
}

func formatDate(_ inputDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE(MM-dd) HH:mm"
    return dateFormatter.string(from: inputDate)
}
