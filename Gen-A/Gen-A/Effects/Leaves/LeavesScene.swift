//
//
//  LeavesScene.swift
//  Gen-A
//
/// Created by `C S Prasad` on `15/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI
 
struct LeavesScene: EffectScene {
    let id    = "leaves"
    let title = "Falling Leaves"
    let icon  = "leaf"
 
    var destinationView: AnyView {
        AnyView(LeavesView())
    }
}
 
// MARK: - View
 
struct LeavesView: View {
    @State private var engine: ParticleEngine?
    @State private var particles: [ParticleModel] = []
 
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
 
            TimelineView(.periodic(from: .now, by: 1/30)) { timeline in
                ZStack(alignment: .bottom) {
 
                    Image("fall")
                        .resizable()
                        .ignoresSafeArea()
 
                    Canvas { context, _ in
                        for p in particles {
                            var ctx = context
                            ctx.translateBy(x: p.position.x, y: p.position.y)
                            ctx.rotate(by: Angle(degrees: p.rotation))
                            ctx.fill(leafPath(size: 10.0 * p.scale), with: .color(p.color.opacity(0.85)))
                        }
                    }
                    .onChange(of: timeline.date) { _, _ in
                        engine?.update(size: size)
                        particles = engine?.particles ?? []
                    }
 
                    Image("kids_playin")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 400)
                }
            }
            .onAppear {
                guard engine == nil else { return }
                engine = Self.makeEngine(size: size)
                particles = engine?.particles ?? []
            }
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Falling Leaves")
    }
 
    private func leafPath(size: Double) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: -size))
            path.addQuadCurve(to: CGPoint(x: 0, y: size),  control: CGPoint(x:  size, y: 0))
            path.addQuadCurve(to: CGPoint(x: 0, y: -size), control: CGPoint(x: -size, y: 0))
        }
    }
 
    @MainActor
    static func makeEngine(size: CGSize) -> ParticleEngine {
        let colors: [Color] = [
            .orange, .red, .yellow,
            Color(red: 0.8, green: 0.3, blue: 0.0),
            Color(red: 0.6, green: 0.2, blue: 0.0)
        ]
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
                rotation:      .random(in: 0...360),
                rotationSpeed: .random(in: -3...3),
                scale:         .random(in: 0.6...1.8),
                color:         colors.randomElement()!,
                phase:         .random(in: 0...Double.pi * 2)
            )
        }
        return ParticleEngine(particles: particles, behaviour: LeafBehaviour())
    }
}
 
#Preview { LeavesView() }
 
