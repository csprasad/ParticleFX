//
//
//  GalaxyBehaviour.swift
//  Gen-A
//
/// Created by `C S Prasad` on `14/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI
 
struct GalaxyBehaviour: ParticleBehaviour {
 
    func update(_ p: inout ParticleModel, in size: CGSize, context: UpdateContext) {
        // Orbital movement — inner particles move faster (Kepler's law)
        p.angle += p.speed
 
        // Subtle opacity pulse
        p.opacity += Double.random(in: -0.005...0.005)
        p.opacity = p.opacity.clamped(to: 0.3...1.0)
    }
}
