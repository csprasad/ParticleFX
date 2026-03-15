//
//
//  Effect.swift
//  Gen-A
//
/// Created by `C S Prasad` on `22/02/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

enum Effect: CaseIterable, Identifiable {
    case rain
    case leaves
    case galaxy

    var id: Self { self }

    var title: String {
        switch self {
        case .rain: "Rain"
        case .leaves: "Falling Leaves"
        case .galaxy: "Galaxy Spiral"
        }
    }

    var icon: String {
        switch self {
        case .rain: "cloud.rain"
        case .leaves: "leaf"
        case .galaxy: "tropicalstorm"
        }
    }

    var background: Color {
        switch self {
        case .rain: .black
        case .leaves: Color(red: 0.1, green: 0.08, blue: 0.05)
        case .galaxy: .black
        }
    }

    @MainActor
    func makeEngine(size: CGSize) -> ParticleEngine {
        switch self {
        case .rain:
            let particles = (0..<150).map { _ in
                ParticleModel(
                    position: CGPoint(
                        x: .random(in: -size.width...size.width),
                        y: .random(in: -size.height...size.height)
                    ),
                    velocity: CGVector(
                        dx: .random(in: 0.5...2.5), // Different wind speeds
                        dy: .random(in: 4...7)      // Different fall speeds
                    ),
                    rotation: 0,
                    rotationSpeed: 0,
                    scale: 1,
                    color: .white,
                    phase: 0
                )
            }
            return ParticleEngine(particles: particles, behaviour: RainBehaviour())

        case .leaves:
            let leafColors: [Color] = [.orange, .red, .yellow, Color(red: 0.8, green: 0.3, blue: 0.0), Color(red: 0.6, green: 0.2, blue: 0.0)]
            let particles = (0..<40).map { _ in
                ParticleModel(
                    position: CGPoint(
                        x: .random(in: 0...size.width),
                        y: .random(in: -size.height...0)
                    ),
                    velocity: CGVector(
                        dx: .random(in: -0.5...0.5),
                        dy: .random(in: 0.8...2.0)
                    ),
                    rotation: .random(in: 0...360),
                    rotationSpeed: .random(in: -3...3),
                    scale: .random(in: 0.6...1.8),
                    color: leafColors.randomElement()!,
                    phase: .random(in: 0...Double.pi * 2)
                )
            }
            return ParticleEngine(particles: particles, behaviour: LeafBehaviour())
            
        case .galaxy:
            let maxR = min(size.width, size.height) * 0.55
            let galaxyColors: [Color] = [
                .white,
                Color(red: 0.6, green: 0.8, blue: 1.0),   // blue white
                Color(red: 1.0, green: 0.9, blue: 0.7),   // warm yellow
                Color(red: 0.9, green: 0.6, blue: 1.0),   // purple
                Color(red: 0.6, green: 1.0, blue: 0.9),   // teal
            ]
            let armCount = 3
            let particles = (0..<500).map { i in
                let arm = i % armCount
                let armOffset = Double(arm) * (Double.pi * 2 / Double(armCount))
                let radius = Double.random(in: 10...maxR)
                let angle = (radius / maxR) * Double.pi * 3 + Double.random(in: -0.3...0.3)
                return ParticleModel(
                    position: .zero,
                    velocity: .zero,
                    rotation: 0,
                    rotationSpeed: 0,
                    scale: Double.random(in: 0.3...1.2),
                    color: galaxyColors.randomElement()!,
                    opacity: Double.random(in: 0.4...1.0), angle: angle,       // actual angle field
                    radius: radius,     // actual radius field
                    speed: 0.0008 + (1.0 - radius / maxR) * 0.002,
                    armOffset: armOffset
                )
            }
            return ParticleEngine(particles: particles, behaviour: GalaxyBehaviour())
        
        }
    }

    @ViewBuilder
    var characterView: some View {
        switch self {
        case .rain:
            Image("umbrella_kid")
                .resizable()
                .scaledToFill()
        case .leaves:
            Image("kids_playin")
                .resizable()
                .scaledToFill()
            
        case .galaxy: EmptyView()
        }
    }
}
