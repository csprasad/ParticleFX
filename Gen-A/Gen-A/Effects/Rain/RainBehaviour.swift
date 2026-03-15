//
//
//  RainBehaviour.swift
//  Gen-A
//
/// Created by `C S Prasad` on `22/02/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import CoreGraphics
 
struct RainBehaviour: ParticleBehaviour {
 
    func update(_ p: inout ParticleModel, in size: CGSize, context: UpdateContext) {
        p.velocity.dy += 0.1
 
        let nextX = p.position.x + p.velocity.dx
        let nextY = p.position.y + p.velocity.dy
 
        // Umbrella collision
        if let rect = context.umbrellaRect {
            let centerX = rect.midX
            let centerY = rect.midY + 20
            let radius  = rect.width / 2
            let dx = nextX - centerX
            let dy = nextY - centerY
            let distance = sqrt(dx*dx + dy*dy)
 
            if distance < radius && nextY < centerY {
                let angle = atan2(dy, dx)
                p.position.x = centerX + cos(angle) * radius
                p.position.y = centerY + sin(angle) * radius
                p.velocity.dx += cos(angle) * 1.5
                p.velocity.dy = 1.0
                return
            }
        }
 
        p.position.x = nextX
        p.position.y = nextY
 
        if p.position.y > size.height || p.position.x > size.width + 50 {
            p.position.y = -20
            p.position.x = .random(in: -size.width...size.width)
            p.velocity.dx = .random(in: 0.5...2.5)
            p.velocity.dy = .random(in: 4...7)
        }
    }
}
 
