//
//
//  GalaxyScene.swift
//  Gen-A
//
/// Created by `C S Prasad` on `15/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct GalaxyScene: EffectScene {
    let id    = "galaxy"
    let title = "Galaxy Spiral"
    let icon  = "tropicalstorm"
 
    var destinationView: AnyView {
        AnyView(GalaxyView())
    }
}
 
// MARK: - Static star field (computed once)
 
private struct StarPoint {
    let x, y, opacity: Double
}
 
private let starField: [StarPoint] = (0..<300).map { _ in
    StarPoint(
        x:       .random(in: 0...1),
        y:       .random(in: 0...1),
        opacity: .random(in: 0.2...0.9)
    )
}
 
// MARK: - View
 
struct GalaxyView: View {
    @State private var engine: ParticleEngine?
    @State private var tick: Bool = false  //tiny toggle, triggers redraw so no particle copy

 
    var body: some View {
        GeometryReader { proxy in
            let size   = proxy.size
            // center calculated from GeometryReader, passed into Canvas via capture
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
                
                ZStack {
                    // Layer 1; deep space radial gradient
                    RadialGradient(
                        colors: [
                            Color(red: 0.05, green: 0.0, blue: 0.1),
                            Color(red: 0.0,  green: 0.0, blue: 0.03),
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: size.width
                    )
                    .ignoresSafeArea()
                    
                    // Layer 2; static star field
                    StarFieldView()
                        .drawingGroup()
                    
                    // Layer 3; galaxy particles + galactic core
                    // TimelineView wraps only the Canvas that needs to animate
                    TimelineView(.periodic(from: .now, by: 1/30)) { timeline in
                        Canvas { context, _ in
                            let _ = tick

                            // Particles; exact reference math
                            for p in engine?.particles ?? []  {
                                let spiralAngle  = p.angle + p.armOffset
                                // zDepth applied to both x and y
                                let x = center.x + cos(spiralAngle) * p.radius * p.zDepth
                                let y = center.y + sin(spiralAngle) * p.radius * p.zDepth * 0.4
                                
                                // particleSize scaled by zDepth for depth perception
                                let particleSize = p.scale * p.zDepth * 4.0
                                
                                // Outer glow
                                let glowRect = CGRect(
                                    x: x - particleSize * 2,
                                    y: y - particleSize * 2,
                                    width:  particleSize * 4,
                                    height: particleSize * 4
                                )
                                context.fill(
                                    Path(ellipseIn: glowRect),
                                    with: .color(p.color.opacity(p.opacity * 0.15 * p.zDepth))
                                )
                                
                                // Bright core dot
                                let coreRect = CGRect(
                                    x: x - particleSize / 2,
                                    y: y - particleSize / 2,
                                    width:  particleSize,
                                    height: particleSize
                                )
                                context.fill(
                                    Path(ellipseIn: coreRect),
                                    with: .color(p.color.opacity(p.opacity * p.zDepth))
                                )
                            }
                            
                            // Galactic core; drawn once outside particle loop
                            for i in 0..<5 {
                                let coreSize = Double(60 - i * 10)
                                let coreRect = CGRect(
                                    x: center.x - coreSize / 2,
                                    y: center.y - coreSize / 2 * 0.4,
                                    width:  coreSize,
                                    height: coreSize * 0.4
                                )
                                context.fill(
                                    Path(ellipseIn: coreRect),
                                    with: .color(.white.opacity(Double(i) * 0.04))
                                )
                            }
                            
                            // Bright center dot
                            let dotRect = CGRect(x: center.x - 4, y: center.y - 4, width: 12, height: 12)
                            context.fill(Path(ellipseIn: dotRect), with: .color(.white.opacity(0.9)))
                        }
                        .onChange(of: timeline.date) { _, _ in
                            engine?.update(size: size)
                            tick.toggle()  //flips a Bool, triggers redraw
                        }
                }
                .onAppear {
                    guard engine == nil else { return }
                    engine = Self.makeEngine(size: size)
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Galaxy Spiral")
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
 
    @MainActor
    static func makeEngine(size: CGSize) -> ParticleEngine {
        let maxRadius = min(size.width, size.height) * 0.55
 
        let galaxyColors: [Color] = [
            .white,
            Color(red: 0.6, green: 0.8, blue: 1.0),  // blue white
            Color(red: 1.0, green: 0.9, blue: 0.7),  // warm yellow
            Color(red: 0.9, green: 0.6, blue: 1.0),  // purple
            Color(red: 0.6, green: 1.0, blue: 0.9),  // teal
        ]
 
        let armCount  = 3
        let particles = (0..<300).map { i in
            let arm       = i % armCount
            let armOffset = Double(arm) * (Double.pi * 2 / Double(armCount))
            let radius    = Double.random(in: 10...maxRadius)
            // spiral angle depends on radius! outer particles further along arm
            let angle     = (radius / maxRadius) * Double.pi * 3 + Double.random(in: -0.3...0.3)
 
            return ParticleModel(
                scale:     .random(in: 0.3...1.2),
                color:     galaxyColors.randomElement()!,
                opacity:   .random(in: 0.4...1.0),
                angle:     angle,
                radius:    radius,
                speed:     0.0008 + (1.0 - radius / maxRadius) * 0.002, // inner orbits faster
                armOffset: armOffset,
                zDepth:    .random(in: 0.6...1.0)
            )
        }
        return ParticleEngine(particles: particles, behaviour: GalaxyBehaviour())
    }
}

// MARK: - StarFieldView
struct StarFieldView: View {
    var body: some View {
        Canvas { context, canvasSize in
            for star in starField {
                let rect = CGRect(
                    x: star.x * canvasSize.width  - 0.8,
                    y: star.y * canvasSize.height - 0.8,
                    width: 1.5, height: 1.5
                )
                context.fill(Path(ellipseIn: rect), with: .color(.white.opacity(star.opacity * 0.5)))
            }
        }
    }
}
 
#Preview { GalaxyView() }
 
