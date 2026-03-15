//
//
//  EffectScene.swift
//  Gen-A
//
/// Created by `C S Prasad` on `15/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

/// ## How to add a new effect
/// 1. Create a new folder under `Effects/YourEffect/`
/// 2. Create `YourBehaviour.swift` conforming to `ParticleBehaviour`
/// 3. Create `YourScene.swift` conforming to `EffectScene`
/// 4. Register it in `EffectRegistry.all`
/// That's it, HomeView picks it up automatically.
 
import SwiftUI
 
protocol EffectScene: Identifiable {
    var id: String { get }
    var title: String { get }
    var icon: String { get }
    var destinationView: AnyView { get }
}
