//
//  AppClipCodeManager.swift
//  AppClipped
//
//  Created by Matt Heaney on 02/03/2025.
//

import Cocoa

///Handles the process of generating and saving a new App Clip code
class AppClipCodeManager {

    let appClipSaveManager = AppClipSaveManager()
    let appClipToolManager = AppClipToolManager()
    let appClipCommandManager = AppClipCommandManager()

    ///Generates the App Clip Code, and launches the Save Panel
    func generateAppClipCode(url: String,
                             selectedColorMode: ColorType,
                             selectedMode: ModeType,
                             logoStyle: LogoType) async throws {

        guard let outputURL = await appClipSaveManager.promptUserForSaveLocation() else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User canceled save dialog"])
        }

        guard let toolPath = appClipToolManager.pathForAppClipCodeGenerator() else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "AppClipped requires AppClipCodeGenerator installed. Please download and install it from https://developer.apple.com/download."])
        }

        try await appClipCommandManager.executeCommand(toolPath: toolPath,
                                                       url: url,
                                                       selectedColorMode: selectedColorMode,
                                                       selectedMode: selectedMode,
                                                       logoStyle: logoStyle,
                                                       outputURL: outputURL)
    }
}
