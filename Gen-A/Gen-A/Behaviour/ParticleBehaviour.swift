//
//
//  ParticleBehaviour.swift
//  Gen-A
//
/// Created by `C S Prasad` on `22/02/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

protocol ParticleBehaviour {
    // umbrellaRect as an optional parameter only used in .rain effect
    func update(_ particle: inout ParticleModel, in size: CGSize, umbrellaRect: CGRect?)
}
