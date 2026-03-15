//
//
//  RainScene.swift
//  Gen-A
//
/// Created by `C S Prasad` on `15/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI
 
struct RainScene: EffectScene {
    let id    = "rain"
    let title = "Rain"
    let icon  = "cloud.rain"
 
    var destinationView: AnyView {
        AnyView(RainView())
    }
}
 
// MARK: - View
 
struct RainView: View {
    @State private var engine: ParticleEngine?
    @State private var particles: [ParticleModel] = []
 
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
 
            TimelineView(.periodic(from: .now, by: 1/30)) { timeline in
                ZStack(alignment: .bottom) {
  
                    Canvas { context, _ in
                        for p in particles {
                            var ctx = context
                            ctx.translateBy(x: p.position.x, y: p.position.y)
                            let angle = atan2(p.velocity.dx, p.velocity.dy)
                            ctx.rotate(by: Angle(radians: -angle))
                            let rect = CGRect(x: -1, y: -5, width: 2, height: 10)
                            let opacity = Double(p.velocity.dy / 8.0).clamped(to: 0.3...0.8)
                            ctx.fill(Path(rect), with: .color(.white.opacity(opacity)))
                        }
                    }
                    .onChange(of: timeline.date) { _, _ in
                        let umbrellaRect = CGRect(
                            x: size.width / 2 - 100,
                            y: size.height - 320,
                            width: 200, height: 100
                        )
                        engine?.update(
                            size: size,
                            context: UpdateContext(umbrellaRect: umbrellaRect)
                        )
                        particles = engine?.particles ?? []
                    }
 
                    Image("umbrella_kid")
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
        .background(Color.black)
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Rain")
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
 
    @MainActor
    static func makeEngine(size: CGSize) -> ParticleEngine {
        let particles = (0..<150).map { _ in
            ParticleModel(
                position: CGPoint(
                    x: .random(in: -size.width...size.width),
                    y: .random(in: -size.height...0)
                ),
                velocity: CGVector(
                    dx: .random(in: 0.5...2.5),
                    dy: .random(in: 4...7)
                )
            )
        }
        return ParticleEngine(particles: particles, behaviour: RainBehaviour())
    }
}
 
#Preview { RainView() }
 
