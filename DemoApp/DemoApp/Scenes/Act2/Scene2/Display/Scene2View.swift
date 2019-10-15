import Anchorage
import Commons
import CustomViews
import Shared
import UIKit

/**
 The scene's root view.
 The root view is responsible for creating the view hierarchy and holds all subview references.
 */
final class Scene2View: BaseView {
	override func configureView() {
		super.configureView()
		accessibilityIdentifier = Const.Scene2Tests.mainView

		// Position the headline at the top.
		add(headlineLabel) { headlineLabel in
			headlineLabel.topAnchor == layoutMarginsGuide.topAnchor
			headlineLabel.leadingAnchor == layoutMarginsGuide.leadingAnchor
			headlineLabel.trailingAnchor == layoutMarginsGuide.trailingAnchor
		}

		// The switch goes under the headline.
		add(rotationLockSwitch) { rotationLockSwitch in
			rotationLockSwitch.topAnchor == headlineLabel.bottomAnchor + Const.Size.gap
			rotationLockSwitch.leadingAnchor == layoutMarginsGuide.leadingAnchor
		}

		// The dismiss button goes under the dismiss button.
		add(dismissButton) { dismissButton in
			dismissButton.topAnchor == rotationLockSwitch.bottomAnchor + Const.Size.gap
			dismissButton.leadingAnchor == layoutMarginsGuide.leadingAnchor
			dismissButton.trailingAnchor <= layoutMarginsGuide.trailingAnchor
		}

		// Set default styles.
		backgroundColor = R.color.scene2Background()
		directionalLayoutMargins = Const.Margin.default.directional
	}

	// MARK: - Subviews

	/// The headline label shown at the top.
	let headlineLabel = configure(UILabel()) { _ in
	}

	/// The rounded dismiss button under the headline.
	let dismissButton = configure(RoundedButton()) { button in
		button.setTitle(R.string.scene2.dismissButtonTitle(), for: .normal)
	}

	/// The switch for locking the rotation.
	let rotationLockSwitch = configure(UISwitch()) { _ in
	}

	// MARK: - View changes

	/**
	 Adds the embedded view of a sub-controller to the view hierarchy.

	 - parameter subView: The sub-controller's view.
	 */
	func addEmbeddedView(_ subView: UIView) {
		add(subView) { subView in
			subView.topAnchor == dismissButton.bottomAnchor + Const.Size.gap
			subView.leadingAnchor == layoutMarginsGuide.leadingAnchor
			subView.trailingAnchor == layoutMarginsGuide.trailingAnchor
			subView.bottomAnchor == layoutMarginsGuide.bottomAnchor
		}
	}

	// MARK: - Interface Builder

	@IBInspectable private lazy var ibBackgroundColor: UIColor = .white
	@IBInspectable private lazy var ibHeadlineTitle: String = "Headline title"
	@IBInspectable private lazy var ibRotationSwitchState: Bool = false

	override func prepareForInterfaceBuilder() {
		// For crash reports look at '~/Library/Logs/DiagnosticReports/'.
		super.prepareForInterfaceBuilder()
		backgroundColor = ibBackgroundColor

		headlineLabel.text = ibHeadlineTitle
		rotationLockSwitch.isOn = ibRotationSwitchState
	}
}
