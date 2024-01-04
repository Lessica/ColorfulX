import class Foundation.Bundle

extension Foundation.Bundle {
    static var module: Bundle = {
        return Bundle(for: MulticolorGradientView.self)
    }()
}
