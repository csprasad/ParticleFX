//
//
//  ParticleModel.swift
//  Gen-A
//
/// Created by `C S Prasad` on `22/02/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI
 
struct ParticleModel {
 
    // MARK: - Common
    var position: CGPoint  = .zero
    var velocity: CGVector = .zero
    var rotation: Double   = 0
    var rotationSpeed: Double = 0
    var scale: Double      = 1
    var color: Color       = .white
    var phase: Double      = 0
    var opacity: Double    = 1
 
    // MARK: - Orbital (Galaxy etc.)
    var angle: Double      = 0
    var radius: Double     = 0
    var speed: Double      = 0
    var armOffset: Double  = 0
    var zDepth: Double     = 1  // fake 3D depth! affects position, size, and opacity

}

