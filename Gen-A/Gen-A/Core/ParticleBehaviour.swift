//
//
//  ParticleBehaviour.swift
//  Gen-A
//
/// Created by `C S Prasad` on `22/02/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI
 
protocol ParticleBehaviour {
    func update(_ particle: inout ParticleModel, in size: CGSize, context: UpdateContext)
}
 
/// Contextual data passed to every behaviour update.
/// Add new fields here as effects need them; behaviours opt in via the context.
struct UpdateContext {
    let umbrellaRect: CGRect?
}
