import UIKit

public struct LayoutEngine {

  public static func stackViews(views: [ViewLayout], metric: ViewMetric = ViewDefaultMetric(), width: CGFloat) -> CGFloat {

    let insets = metric.insets
    var frame = CGRect(x: 0, y: 0, width: width, height: 0)
    frame = frame.inset(by: insets)
    frame.size.height = 0

    let insetWidth = frame.width

    for layout in views {

      if let view = layout.view {
        layout.setHidden(layout.metric.hidden, view)
      }
      var viewFrame = frame

      viewFrame.size = layout.size(insetWidth)
      viewFrame.origin.y += layout.insets.top

      if let view = layout.view {
        switch layout.direction {
        case .Left:
          viewFrame.origin.x = insets.left + layout.insets.left
        case .Right:
          viewFrame.origin.x = width - viewFrame.width - insets.right - layout.insets.right
        }
          view.frame = viewFrame
      }
      if layout.metric.hidden == false {
        viewFrame.origin.y += layout.insets.bottom
        viewFrame.origin.y += viewFrame.size.height
        frame = viewFrame
      }
    }

    return frame.origin.y + insets.bottom

  }
  
}
