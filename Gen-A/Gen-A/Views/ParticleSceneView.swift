//
//
//  ParticleSceneView.swift
//  Gen-A
//
/// Created by `C S Prasad` on `22/02/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct ParticleSceneView: View {
    let effect: Effect
    @State private var engine: ParticleEngine?
    @State private var particles: [ParticleModel] = []

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            TimelineView(.periodic(from: .now, by: 1/30)) { timeline in
                ZStack(alignment: .bottom) {
                    backgroundView()
                    Canvas { context, _ in
                        for p in particles {
                            var leafContext = context
                            leafContext.translateBy(x: p.position.x, y: p.position.y)
                            leafContext.rotate(by: Angle(degrees: p.rotation))

                            switch effect {
                            case .rain:
                                let angle = atan2(p.velocity.dx, p.velocity.dy)
                                leafContext.rotate(by: Angle(radians: -angle))
                                let rect = CGRect(x: -1, y: -5, width: 2, height: 10)
                                let opacity = Double(p.velocity.dy / 8.0).clamped(to: 0.3...0.8)
                                leafContext.fill(Path(rect), with: .color(.white.opacity(opacity)))

                            case .leaves:
                                let size = 10.0 * p.scale
                                let path = leafPath(size: size)
                                leafContext.fill(path, with: .color(p.color.opacity(0.85)))
                            }
                        }
                    }
                    .onChange(of: timeline.date) { _, _ in
                        let umbrellaRect = CGRect(
                                x: size.width / 2 - 100,
                                y: size.height - 320,
                                width: 200,
                                height: 100
                            )
                        engine?.update(size: size, umbrella: umbrellaRect)
                        particles = engine?.particles ?? []
                    }

                    effect.characterView
                        .frame(width: 200, height: 400)
                }
            }
            .onAppear {
                if engine == nil {
                    engine = effect.makeEngine(size: size)
                    particles = engine?.particles ?? []
                }
            }
        }
        .background(effect.background)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(effect.title)
        .ignoresSafeArea()
    }
    // Leaf shape path
    func leafPath(size: Double) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: -size))
            path.addQuadCurve(
                to: CGPoint(x: 0, y: size),
                control: CGPoint(x: size, y: 0)
            )
            path.addQuadCurve(
                to: CGPoint(x: 0, y: -size),
                control: CGPoint(x: -size, y: 0)
            )
        }
    }
    
    @ViewBuilder
    private func backgroundView() -> some View {
        switch effect {
        case .rain:
            Color.black
                .ignoresSafeArea()
        case .leaves:
            Image("fall")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}


#Preview {
    ParticleSceneView(effect: .rain)
}

