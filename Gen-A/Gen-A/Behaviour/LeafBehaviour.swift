//
//
//  LeafBehaviour.swift
//  Gen-A
//
/// Created by `C S Prasad` on `02/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

// MARK: - Leaf Behaviour
struct LeafBehaviour: ParticleBehaviour {
    func update(_ particle: inout ParticleModel, in size: CGSize, umbrellaRect: CGRect?) {
        // Tumble rotation
        particle.rotation += particle.rotationSpeed

        // Sine wave horizontal drift for natural floating
        particle.phase += 0.05
        particle.velocity.dx = sin(particle.phase) * 1.2

        particle.position.x += particle.velocity.dx
        particle.position.y += particle.velocity.dy

        // Recycle when off screen
        if particle.position.y > size.height + 20 {
            particle.position.y = -20
            particle.position.x = .random(in: 0...size.width)
            particle.velocity.dy = .random(in: 1.0...3.0)
            particle.rotation = .random(in: 0...360)
            particle.rotationSpeed = .random(in: -3...3)
            particle.phase = .random(in: 0...Double.pi * 2)
        }
    }
}
