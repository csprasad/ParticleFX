//
//
//  ParticleEngine.swift
//  Gen-A
//
/// Created by `C S Prasad` on `22/02/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI
import Observation
 
//@Observable
@MainActor
final class ParticleEngine {
 
    var particles: [ParticleModel]
    private let behaviour: ParticleBehaviour
 
    init(particles: [ParticleModel], behaviour: ParticleBehaviour) {
        self.particles = particles
        self.behaviour = behaviour
    }
 
    func update(size: CGSize, context: UpdateContext = UpdateContext(umbrellaRect: nil)) {
        for i in particles.indices {
            behaviour.update(&particles[i], in: size, context: context)
        }
    }
}
