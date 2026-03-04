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
    var position: CGPoint
    var velocity: CGVector
    
    // for falls effect's
    var rotation: Double
    var rotationSpeed: Double
    var scale: Double
    var color: Color
    var phase: Double // for sine wave drift
}

