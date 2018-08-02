
import Foundation
import Charts

open class BalloonMarkerXY: MarkerImage
{
    open var color: UIColor
    open var arrowSize = CGSize(width: 15, height: 11)
    open var font: UIFont
    open var textColor: UIColor
    open var insets: UIEdgeInsets
    open var minimumSize = CGSize()
    
    fileprivate var labelx: String?
    fileprivate var labely: String?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedStringKey : AnyObject]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }
        
        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0
        
        var origin = point
        origin.x -= width / 2
        origin.y -= height
        
        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }
        
        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }
        
        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let labelx = labelx else { return }
        guard let labely = labely else { return }
        
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        
        var rectx = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: 474 + offset.y),
            size: size)
        rectx.origin.x -= size.width / 2.0
        rectx.origin.y -= size.height
        
        var recty = CGRect(
            origin: CGPoint(
                x: 28 + offset.x,
                y: point.y  ),
            size: size)
//        recty.origin.x -= size.width / 2.0
        recty.origin.y -= size.height / 2.0
        
        
        
        context.saveGState()
        
        context.setFillColor(color.cgColor)
        
        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rectx.origin.x,
                y: rectx.origin.y ))
            context.addLine(to: CGPoint(
                x: rectx.origin.x + rectx.size.width,
                y: rectx.origin.y ))
            context.addLine(to: CGPoint(
                x: rectx.origin.x + rectx.size.width,
                y: rectx.origin.y + rectx.size.height))
            context.addLine(to: CGPoint(
                x: rectx.origin.x + rectx.size.width / 2,
                y: rectx.origin.y + rectx.size.height + 10))
            context.addLine(to: CGPoint(
                x: rectx.origin.x,
                y: rectx.origin.y + rectx.size.height))
            context.addLine(to: CGPoint(
                x: rectx.origin.x,
                y: rectx.origin.y ))
            
            
            context.move(to: CGPoint(
                x: recty.origin.x,
                y: recty.origin.y ))
            context.addLine(to: CGPoint(
                x: recty.origin.x + recty.size.width,
                y: recty.origin.y ))
            context.addLine(to: CGPoint(
                x: recty.origin.x + recty.size.width,
                y: recty.origin.y + recty.size.height))
            context.addLine(to: CGPoint(
                x: recty.origin.x,
                y: recty.origin.y + recty.size.height))
            context.addLine(to: CGPoint(
                x: recty.origin.x,
                y: recty.origin.y ))
            
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rectx.origin.x,
                y: rectx.origin.y))
            context.addLine(to: CGPoint(
                x: rectx.origin.x + rectx.size.width,
                y: rectx.origin.y))
            context.addLine(to: CGPoint(
                x: rectx.origin.x + rectx.size.width,
                y: rectx.origin.y + rectx.size.height ))
            context.addLine(to: CGPoint(
                x: rectx.origin.x + rectx.size.width / 2,
                y: rectx.origin.y + rectx.size.height + 10))
            context.addLine(to: CGPoint(
                x: rectx.origin.x,
                y: rectx.origin.y + rectx.size.height ))
            context.addLine(to: CGPoint(
                x: rectx.origin.x,
                y: rectx.origin.y))
            

            context.move(to: CGPoint(
                x: recty.origin.x,
                y: recty.origin.y + recty.size.height / 2))
            context.addLine(to: CGPoint(
                x: recty.origin.x + 10,
                y: recty.origin.y
            ))
            context.addLine(to: CGPoint(
                x: recty.origin.x + recty.size.width,
                y: recty.origin.y))
            context.addLine(to: CGPoint(
                x: recty.origin.x + recty.size.width,
                y: recty.origin.y + recty.size.height))
            context.addLine(to: CGPoint(
                x: recty.origin.x + 10,
                y: recty.origin.y + recty.size.height))
            context.addLine(to: CGPoint(
                x: recty.origin.x,
                y: recty.origin.y + recty.size.height / 2))
            context.fillPath()
        }
        
        if offset.y > 0 {
            rectx.origin.y += self.insets.top + arrowSize.height
            recty.origin.y += self.insets.top + arrowSize.height
        } else {
            rectx.origin.y += self.insets.top
            recty.origin.y += self.insets.top
        }
        
        
        rectx.size.height -= self.insets.top + self.insets.bottom
        recty.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        labelx.draw(in: rectx, withAttributes: _drawAttributes)
        labely.draw(in: recty, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        setLabelX(String(entry.x))
        setLabelY(String(entry.y))
    }
    
    open func setLabelX(_ newLabel: String)
    {
        labelx = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _labelSize = labelx?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
    
    open func setLabelY(_ newLabel: String)
    {
        labely = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _labelSize = labely?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
}
