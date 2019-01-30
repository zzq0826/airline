import UIKit

class AutolayoutProxy {
    @discardableResult static func layout(_ view: UIView) -> AutolayoutProxy {
        view.translatesAutoresizingMaskIntoConstraints = false
        return AutolayoutProxy(view: view)
    }
    
    let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    @discardableResult func centerHorizontallyInParentView() -> AutolayoutProxy {
        guard let superview = view.superview else {
            return self
        }
        view.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        return self
    }
    
    @discardableResult func centerVerticallyInParentView() -> AutolayoutProxy {
        guard let superview = view.superview else {
            return self
        }
        view.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        return self
    }
    
    @discardableResult func spanSuperview() -> AutolayoutProxy {
        guard let superview = view.superview else {
            return self
        }
        let constraints: [NSLayoutConstraint] = [
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ]
        constraints.forEach { $0.isActive = true }
        return self
    }
    
    @discardableResult func width(_ value: CGFloat) -> AutolayoutProxy {
        let constraints: [NSLayoutConstraint] = [
            view.widthAnchor.constraint(equalToConstant: value)
        ]
        constraints.forEach { $0.isActive = true }
        return self
    }
    
    @discardableResult func height(_ value: CGFloat) -> AutolayoutProxy {
        let constraints: [NSLayoutConstraint] = [
            view.heightAnchor.constraint(equalToConstant: value)
        ]
        constraints.forEach { $0.isActive = true }
        return self
    }
    
    @discardableResult func matchView(_ view: UIView) -> AutolayoutProxy {
        let constraints: [NSLayoutConstraint] = [
            view.topAnchor.constraint(equalTo: view.topAnchor),
            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        constraints.forEach { $0.isActive = true }
        return self
    }
    
    @discardableResult func topSpaceToSuperview(_ value: CGFloat) -> AutolayoutProxy {
        guard let superview = view.superview else {
            return self
        }
        let constraints: [NSLayoutConstraint] = [
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: value)
        ]
        constraints.forEach { $0.isActive = true }
        return self
    }
    
    @discardableResult func bottomSpaceToSuperview(_ value: CGFloat) -> AutolayoutProxy {
        guard let superview = view.superview else {
            return self
        }
        let constraints: [NSLayoutConstraint] = [
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: value)
        ]
        constraints.forEach { $0.isActive = true }
        return self
    }
    
    @discardableResult func leadingSpaceToSuperview(_ value: CGFloat) -> AutolayoutProxy {
        guard let superview = view.superview else {
            return self
        }
        let constraints = [
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: value)
        ]
        constraints.forEach { $0.isActive = true }
        return self
    }
    
    @discardableResult func trailingSpaceToSuperview(_ value: CGFloat) -> AutolayoutProxy {
        guard let superview = view.superview else {
            return self
        }
        let constraints: [NSLayoutConstraint] = [
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -value)
        ]
        constraints.forEach { $0.isActive = true }
        return self
    }
}
