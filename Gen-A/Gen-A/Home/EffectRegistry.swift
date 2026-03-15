//
//
//  EffectRegistry.swift
//  Gen-A
//
/// Created by `C S Prasad` on `15/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

/// ## To add a new effect
/// Just add it to the `all` array below. HomeView updates automatically.
 
import Foundation
 
enum EffectRegistry {
    static let allEffects: [any EffectScene] = [
        RainScene(),
        LeavesScene(),
        GalaxyScene(),
        // Add new effects here..
    ]
}
 
