//
//  ColorfulView.swift
//
//
//  Created by QAQ on 2023/12/3.
//

import SwiftUI
import ColorVector

public struct ColorfulView: View {
    @Binding var color: [Color]
    @Binding var speed: Double
    @Binding var bias: Double
    @Binding var noise: Double
    @Binding var transitionSpeed: Double

    @State var isPaused: Bool = false
    @Environment(\.scenePhase) var scenePhase

    let frameLimit: Int
    let interpolationOption: MulticolorGradientView.InterpolationOption

    public init(
        color: Binding<[Color]>,
        speed: Binding<Double> = .constant(1.0),
        bias: Binding<Double> = .constant(0.01),
        noise: Binding<Double> = .constant(0),
        transitionSpeed: Binding<Double> = .constant(5),
        frameLimit: Int = 0,
        interpolationOption: MulticolorGradientView.InterpolationOption = .lab
    ) {
        _color = color
        _speed = speed
        _bias = bias
        _noise = noise
        _transitionSpeed = transitionSpeed
        self.frameLimit = frameLimit
        self.interpolationOption = interpolationOption
    }

    public var body: some View {
        AnimatedMulticolorGradientViewRepresentable(
            color: .init(get: {
                color.map { ColorVector(ColorElement($0)) }
            }, set: { _ in }),
            speed: $speed,
            bias: $bias,
            noise: $noise,
            transitionSpeed: $transitionSpeed,
            isPaused: $isPaused,
            frameLimit: frameLimit,
            interpolationOption: interpolationOption
        )
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                isPaused = false
            } else {
                isPaused = true
            }
        }
    }
}
