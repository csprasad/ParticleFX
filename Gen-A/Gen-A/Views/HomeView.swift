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

    private let cols = [GridItem(.adaptive(minimum: 120))]

    var body: some View {

        NavigationStack {

            ScrollView {

                LazyVGrid(columns: cols, spacing: 20) {

                    ForEach(Effect.allCases) { effect in

                        NavigationLink {

                            ParticleSceneView(effect: effect)

                        } label: {

                            VStack(spacing: 10) {

                                Image(systemName: effect.icon)
                                    .font(.system(size: 36))

                                Text(effect.title)
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
            .navigationTitle("Particle Effects")
        }
    }
}

#Preview {
    HomeView()
}
