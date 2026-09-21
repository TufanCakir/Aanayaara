//
//  LocalizationStore.swift
//  Aanayaara
//
//  Created by Tufan Cakir on 21.09.26.
//

import Foundation
import Observation

enum AppLanguage: String, CaseIterable, Identifiable {
    case german = "de"
    case english = "en"

    var id: Self { self }

    var displayName: String {
        switch self {
        case .german: "Deutsch"
        case .english: "English"
        }
    }
}

@MainActor
@Observable
final class LocalizationStore {
    private static let languageDefaultsKey = "selectedAppLanguage"

    var selectedLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(
                selectedLanguage.rawValue,
                forKey: Self.languageDefaultsKey
            )
            strings = Self.loadStrings(for: selectedLanguage)
        }
    }

    private(set) var strings: [String: String]

    init() {
        let savedCode = UserDefaults.standard.string(
            forKey: Self.languageDefaultsKey
        )
        let language = AppLanguage(rawValue: savedCode ?? "") ?? .german
        selectedLanguage = language
        strings = Self.loadStrings(for: language)
    }

    func text(_ key: String) -> String {
        strings[key] ?? key
    }

    private static func loadStrings(for language: AppLanguage) -> [String:
        String]
    {
        guard
            let url = Bundle.main.url(
                forResource: language.rawValue,
                withExtension: "json"
            ),
            let data = try? Data(contentsOf: url),
            let values = try? JSONDecoder().decode(
                [String: String].self,
                from: data
            )
        else {
            return [:]
        }

        return values
    }
}
