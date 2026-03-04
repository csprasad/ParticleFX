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

import Observation
import SwiftUI

@Observable
@MainActor
final class ParticleEngine {

    var particles: [ParticleModel]
    private let behaviour: ParticleBehaviour

    init(particles: [ParticleModel], behaviour: ParticleBehaviour) {
        self.particles = particles
        self.behaviour = behaviour
    }

    func update(size: CGSize, umbrella: CGRect?) {
        for i in particles.indices {
            behaviour.update(&particles[i], in: size, umbrellaRect: umbrella)
        }
    }
}
