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
 
struct LeafBehaviour: ParticleBehaviour {
 
    func update(_ p: inout ParticleModel, in size: CGSize, context: UpdateContext) {
        p.rotation += p.rotationSpeed
 
        // Sine wave horizontal drift
        p.phase += 0.05
        p.velocity.dx = sin(p.phase) * 1.2
 
        p.position.x += p.velocity.dx
        p.position.y += p.velocity.dy
 
        if p.position.y > size.height + 20 {
            p.position.y = -20
            p.position.x = .random(in: 0...size.width)
            p.velocity.dy = .random(in: 1.0...3.0)
            p.rotation = .random(in: 0...360)
            p.rotationSpeed = .random(in: -3...3)
            p.phase = .random(in: 0...Double.pi * 2)
        }
    }
}
 
