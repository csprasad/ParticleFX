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

    var id: Self { self }

    var title: String {
        switch self {
        case .rain: "Rain"
        case .leaves: "Falling Leaves"
        }
    }

    var icon: String {
        switch self {
        case .rain: "cloud.rain"
        case .leaves: "leaf"
        }
    }

    var background: Color {
        switch self {
        case .rain: .black
        case .leaves: Color(red: 0.1, green: 0.08, blue: 0.05)
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
        }
    }
}
