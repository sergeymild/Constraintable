
import UIKit

public protocol Constrainable {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var superview: UIView? { get }
    
    
    // position
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>) where Anchor: NSLayoutAnchor<Axis>
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  offset: CGFloat) where Anchor: NSLayoutAnchor<Axis>

    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  to: Constrainable) where Anchor: NSLayoutAnchor<Axis>
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  to: Constrainable,
                                  offset: CGFloat) where Anchor: NSLayoutAnchor<Axis>
    
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  to: KeyPath<Constrainable, Anchor>,
                                  of: Constrainable) where Anchor: NSLayoutAnchor<Axis>
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  to: KeyPath<Constrainable, Anchor>,
                                  of: Constrainable,
                                  offset: CGFloat) where Anchor: NSLayoutAnchor<Axis>
    
    func constraint<Anchor, Axis>(_ originKeyPath: KeyPath<Constrainable, Anchor>,
                                  toSafeArea: UIView) where Anchor: NSLayoutAnchor<Axis>
    func constraint<Anchor, Axis>(_ originKeyPath: KeyPath<Constrainable, Anchor>,
                                  toSafeArea: UIView,
                                  offset: CGFloat) where Anchor: NSLayoutAnchor<Axis>
    
    func edges()
    func edges(to: Constrainable)
    
    // size
    func constraint(_ keyPath: KeyPath<Constrainable, NSLayoutDimension>, to: CGFloat)
    func constraint(_ keyPath: KeyPath<Constrainable, NSLayoutDimension>, to: Constrainable)
    func size(_ to: CGFloat)
    func size(to: Constrainable)
}

public extension Constrainable {
    var top: NSLayoutYAxisAnchor { return topAnchor }
    var bottom: NSLayoutYAxisAnchor { return bottomAnchor }
    var left: NSLayoutXAxisAnchor { return leftAnchor }
    var right: NSLayoutXAxisAnchor { return rightAnchor }
    var leading: NSLayoutXAxisAnchor { return leadingAnchor }
    var trailing: NSLayoutXAxisAnchor { return trailingAnchor }
    var centerX: NSLayoutXAxisAnchor { return centerXAnchor }
    var centerY: NSLayoutYAxisAnchor { return centerYAnchor }
    var width: NSLayoutDimension { return widthAnchor }
    var height: NSLayoutDimension { return heightAnchor }
    
    // position
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>) where Anchor: NSLayoutAnchor<Axis> {
        constraint(keyPath, offset: 0)
    }
    
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  offset: CGFloat) where Anchor: NSLayoutAnchor<Axis> {
        guard let destination: Constrainable = superview else {
            fatalError("You must add view to superview before make constrains")
        }

        constraint(keyPath, to: keyPath, of: destination, offset: offset)
    }
    
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  to destination: Constrainable) where Anchor: NSLayoutAnchor<Axis> {
        constraint(keyPath, to: destination, offset: 0)
    }
    
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  to destination: Constrainable,
                                  offset: CGFloat) where Anchor: NSLayoutAnchor<Axis> {
        constraint(keyPath, to: keyPath, of: destination, offset: offset)
    }
    
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  to: KeyPath<Constrainable, Anchor>,
                                  of: Constrainable) where Anchor: NSLayoutAnchor<Axis> {
        constraint(keyPath, to: to, of: of, offset: 0)
    }
    
    func constraint<Axis, Anchor>(_ keyPath: KeyPath<Constrainable, Anchor>,
                                  to: KeyPath<Constrainable, Anchor>,
                                  of: Constrainable,
                                  offset: CGFloat) where Anchor: NSLayoutAnchor<Axis> {
        let constraintable: Constrainable = self
        constraintable[keyPath: keyPath]
            .constraint(equalTo: of[keyPath: to], constant: offset).isActive = true
    }
    
    func constraint<Anchor, Axis>(_ originKeyPath: KeyPath<Constrainable, Anchor>,
                                  toSafeArea: UIView) where Anchor: NSLayoutAnchor<Axis> {
        constraint(originKeyPath, toSafeArea: toSafeArea, offset: 0)
    }

    func constraint<Anchor, Axis>(_ originKeyPath: KeyPath<Constrainable, Anchor>,
                                  toSafeArea: UIView,
                                  offset: CGFloat) where Anchor: NSLayoutAnchor<Axis> {
        
        guard let destination = superview else {
            fatalError("You must add view to superview before make constrains")
        }

        let safe: Constrainable
        if #available(iOS 11.0, *) {
            safe = destination.safeAreaLayoutGuide
        } else {
            safe = destination
        }
        let constraintable: Constrainable = self
        constraintable[keyPath: originKeyPath]
            .constraint(equalTo: safe[keyPath: originKeyPath], constant: offset).isActive = true
    }
    
    // size
    func constraint(_ keyPath: KeyPath<Constrainable, NSLayoutDimension>, to: CGFloat) {
        let constraintable: Constrainable = self
        constraintable[keyPath: keyPath].constraint(equalToConstant: to).isActive = true
    }
    
    func constraint(_ keyPath: KeyPath<Constrainable, NSLayoutDimension>, to destination: Constrainable) {
        let constraintable: Constrainable = self
        constraintable[keyPath: keyPath].constraint(equalTo: destination[keyPath: keyPath]).isActive = true
    }
    
    func edges() {
        constraint(\.left)
        constraint(\.top)
        constraint(\.right)
        constraint(\.bottom)
    }
    
    func edges(to destination: Constrainable) {
        constraint(\.left, to: destination)
        constraint(\.top, to: destination)
        constraint(\.right, to: destination)
        constraint(\.bottom, to: destination)
    }
    
    func size(_ to: CGFloat) {
        constraint(\.width, to: to)
        constraint(\.height, to: to)
    }

    func size(to destination: Constrainable) {
        constraint(\.width, to: destination)
        constraint(\.height, to: destination)
    }
}

extension UIView: Constrainable {}
extension UILayoutGuide: Constrainable {
    public var superview: UIView? { return nil }
}

public extension Constrainable {

    public func activate(_ block: (Constrainable) -> Void) {
        if let view = self as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        block(self)
    }
}




