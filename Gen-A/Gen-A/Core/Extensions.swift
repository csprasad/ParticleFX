//
//
//  Extensions.swift
//  Gen-A
//
/// Created by `C S Prasad` on `15/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

extension Comparable {
   func clamped(to limits: ClosedRange<Self>) -> Self {
       min(max(self, limits.lowerBound), limits.upperBound)
   }
}
