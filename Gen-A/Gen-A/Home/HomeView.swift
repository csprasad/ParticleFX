//
//  HomeView.swift
//  Gen-A
//
/// Created by `C S Prasad` on `22/02/26`
///
///`iOS • SwiftUI • Creative Coding`
///
/// ### Social
/// `Insta`  : ``@csprasad.ios``
/// `X`           : ``@csprasad_ios``
/// `Github`: ``@csprasad``
///

import SwiftUI
 
struct HomeView: View {
 
    private let cols = [GridItem(.adaptive(minimum: 140))]
    private let effects = EffectRegistry.allEffects
 
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 20) {
                    ForEach(effects, id: \.id) { effect in
                        NavigationLink(destination: effect.destinationView) {
                            VStack(spacing: 10) {
                                Image(systemName: effect.icon)
                                    .font(.system(size: 36))
                                Text(effect.title)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            .tint(.primary)
                            .frame(height: 120)
                            .frame(maxWidth: .infinity)
                            .background(.thinMaterial)
                            .clipShape(.rect(cornerRadius: 16))
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Particle FX")
        }
    }
}
 
#Preview { HomeView() }
 
