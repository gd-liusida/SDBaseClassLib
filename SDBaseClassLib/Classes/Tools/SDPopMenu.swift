//
//  SDPopMenu.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/12.
//

import UIKit

public protocol SDPopMenuDelegate :NSObjectProtocol{
    func popMenuDidSelectIndex(index:Int)
}

public enum SDPopMenuConfigure {
    case textFont(UIFont)            //菜单文字字体
    case textColor(UIColor)          //菜单文字颜色
    case backgroudColor(UIColor)     //菜单背景色
    case cornorRadius(CGFloat)            //菜单圆角
    case itemHeight(CGFloat)          //菜单行高度
    case splitLineColor(UIColor)     //菜单分割线颜色
    case leftMargin(CGFloat)          //左间距
    case margin(CGFloat)              //菜单与屏幕边距
    case alpha(CGFloat)              //菜单背景透明度
}

class SDPopMenu: UIView {

    //delegate
    weak var delegate : SDPopMenuDelegate?
    //block
    public var didSelectMenuBlock:((_ index:Int)->Void)?
    
    //／*  -----------------------  外部参数 通过configure设置 ---------------------------- *／
    //区域外背景透明度
    private var outAlpha:CGFloat = 0.3
    //背景色
    private var bgColor:UIColor = UIColor.white
    //圆角弧度
    private var cornorRadius:CGFloat = 6
    //文字颜色
    private var textColor:UIColor = UIColor.black
    //字体大小等
    private var textFont:UIFont = UIFont.systemFont(ofSize: 17)
    //菜单高度
    private var itemHeight:CGFloat = 44.0
    //菜单分割线颜色
    private var splitLineColor:UIColor = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 0.5)
    //icon左间距
    private var leftMargin:CGFloat = 15
    //菜单与屏幕边距
    private var margin:CGFloat = 10
    
    //／*  -----------------------  外部参数 over------------------------------------------ *／
    
    private var arrowPoint : CGPoint = CGPoint.zero         //小箭头位置
    private var arrowViewWidth : CGFloat = 15               //三角箭头宽
    private var arrowViewHeight : CGFloat = 10               //三角箭头高
    private var data:[(icon:String?, title:String)]!       //数据源
    
    private var myFrame:CGRect!     //tableview  frame
    private var arrowView : UIView! = nil
    
    var tableView:UITableView! = nil
    
    ///   初始化菜单
    ///
    /// - Parameters:
    ///   - menuWidth: 菜单宽度
    ///   - arrow: 箭头位置是popmenu相对整个屏幕的位置
    ///   - datas: 数据源，icon允许传空，数据源没数据，不会显示菜单
    ///   - configure: 配置信息，可不传
       public  init(menuWidth:CGFloat,arrow:CGPoint,datas:[(icon:String?,title:String)],configures:[SDPopMenuConfigure] = []) {
           super.init(frame: UIScreen.main.bounds)
           self.frame = UIScreen.main.bounds
           //读取配置
           configures.forEach { (config) in
               switch (config){
                   case let .textFont(value):
                       textFont = value
                   case let .textColor(value):
                       textColor = value
                   case let .backgroudColor(value):
                       bgColor = value
                   case let .cornorRadius(value):
                       cornorRadius = value
                   case let .itemHeight(value):
                       itemHeight = value
                   case let .splitLineColor(value):
                       splitLineColor = value
                   case let .leftMargin(value):
                       leftMargin = value
                   case let .margin(value):
                       margin = value
                   case let .alpha(value):
                       outAlpha = value
               }
           }
           
           self.data = datas
           //设置myFrame size  ,original会在后面计算
           myFrame = CGRect(x: 0, y: 0, width: menuWidth, height: itemHeight*CGFloat(data.count))
           myFrame.size.height = min(kScreenH/2, myFrame.height)
           myFrame.size.width = min(kScreenW-margin*2, myFrame.width)
           
           //设置肩头，与屏幕间隔10
           arrowPoint = arrow
           arrowPoint.x = max(margin, min(arrowPoint.x, kScreenW-margin))
       
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        self.backgroundColor = UIColor.black.withAlphaComponent(outAlpha)
        
        let arrowPs = getArrowPoints()
        myFrame.origin = arrowPs.3
        let isarrowUP = arrowPs.4
        print(arrowPs)
        //箭头
        arrowView=UIView(frame: CGRect(x: myFrame.origin.x, y: isarrowUP ? myFrame.origin.y-arrowViewHeight : myFrame.origin.y+myFrame.height, width: myFrame.width, height: arrowViewHeight))
        let layer=CAShapeLayer()
        let path=UIBezierPath()
        path.move(to: arrowPs.0)
        path.addLine(to: arrowPs.1)
        path.addLine(to: arrowPs.2)
        layer.path=path.cgPath
        layer.fillColor = bgColor.cgColor
        arrowView.layer.addSublayer(layer)
        self.addSubview(arrowView)
        
        tableView=UITableView(frame: CGRect(x: myFrame.origin.x,y: myFrame.origin.y,width: myFrame.width,height: myFrame.height), style: .plain)
        tableView.register(cellType: SDPopMenuCell.self)
        tableView.backgroundColor = bgColor
        tableView.layer.cornerRadius = cornorRadius
        tableView.separatorStyle = .none
        tableView.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        UIView.animate(withDuration: 0.3) {
            self.addSubview(self.tableView)
        }
    }
   
    
    /// 计算箭头位置
    ///
    /// - Returns: (三角箭头顶，三角箭头左，三角箭头右，tableview 原点，是否箭头朝上)
    func getArrowPoints() -> (CGPoint,CGPoint,CGPoint,CGPoint,Bool) {
        if arrowPoint.x <= margin {
            arrowPoint.x = margin
        }
        if arrowPoint.x >= kScreenW - margin{
            arrowPoint.x = kScreenW - margin
        }
        var originalPoint = CGPoint.zero
        
        //箭头中间距离左边距离
        var arrowMargin:CGFloat = margin
        if arrowPoint.x < kScreenW/2{
            if (arrowPoint.x > myFrame.width/2) {
                arrowMargin = myFrame.width/2
                originalPoint = CGPoint(x: arrowPoint.x - myFrame.width/2, y: arrowPoint.y+arrowViewHeight)
            }else{
                arrowMargin = arrowPoint.x-margin
                originalPoint = CGPoint(x: margin, y: arrowPoint.y+arrowViewHeight)
            }
            
        }else{
            
            if (kScreenW-arrowPoint.x) < myFrame.width/2{
                arrowMargin = (myFrame.width - kScreenW + arrowPoint.x )
                originalPoint = CGPoint(x: kScreenW-margin-myFrame.width, y: arrowPoint.y+arrowViewHeight)
                
                
            }else{
                arrowMargin = myFrame.width/2
                originalPoint = CGPoint(x: arrowPoint.x-myFrame.width/2, y: arrowPoint.y+arrowViewHeight)
            }
        }
        
        //箭头朝上
        if (kScreenH - arrowPoint.y) > myFrame.height{
            
            return (CGPoint(x: arrowMargin, y: 0),CGPoint(x: arrowMargin-arrowViewWidth/2, y: arrowViewHeight),CGPoint(x: arrowMargin+arrowViewWidth/2, y: arrowViewHeight),originalPoint,true)
            
        }else{
            originalPoint.y = arrowPoint.y-myFrame.height-arrowViewHeight
            
            return (CGPoint(x: arrowMargin, y: arrowViewHeight),CGPoint(x: arrowMargin-arrowViewWidth/2, y: 0),CGPoint(x: arrowMargin+arrowViewWidth/2, y: 0),originalPoint,false)
        }
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

// MARK: - 页面显示、隐藏
extension SDPopMenu{
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != tableView{
            dismiss()
        }
    }
    
    public func show() {
        if data.isEmpty{
            return
        }
        initViews()
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    public func dismiss() {
        self.removeFromSuperview()
    }

}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension SDPopMenu : UITableViewDataSource,UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data.count>indexPath.row {
            let cell: SDPopMenuCell = tableView.dequeueReusableCell(for: indexPath)
            
            let model = data[indexPath.row]
            cell.setConfig(_txtColor: textColor, _lineColor: splitLineColor, _txtFont: textFont, _leftMargin: leftMargin)
            if indexPath.row == data.count - 1 {
                cell.fill(iconName: model.icon, title: model.title, islast: true)
            }else{
                 cell.fill(iconName: model.icon, title: model.title)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegate != nil{
            self.delegate?.popMenuDidSelectIndex(index: indexPath.row)
        }
        if didSelectMenuBlock != nil {
            didSelectMenuBlock!(indexPath.row)
        }
        
        dismiss()
    }
    
}

/// UITableViewCell
class SDPopMenuCell: UITableViewCell, SDReusable {
    var iconImage:UIImageView!
    var lblTitle:UILabel!
    var line:UIView!
    
    var isHiddenIcon: Bool = false
    
    //自定义属性
    var lineColor:UIColor = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 0.5)
    var txtColor:UIColor = UIColor.black
    var txtFont:UIFont = UIFont.systemFont(ofSize: 17)
    var leftMargin:CGFloat = 15
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        iconImage = UIImageView()
        self.contentView.addSubview(iconImage)
        self.selectionStyle = .none
        
        lblTitle = UILabel()
        self.contentView.addSubview(lblTitle)
        
        line = UIView()
        self.contentView.addSubview(line)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func fill(iconName:String?,title:String,islast:Bool = false) {
        if iconName != nil {
            iconImage.image = UIImage(named: iconName!)
            iconImage.isHidden = false
            isHiddenIcon = false
        } else {
            iconImage.isHidden = true
            isHiddenIcon = true
        }
        lblTitle.text = title
        line.isHidden = islast
    }
    
    func setConfig(_txtColor:UIColor,_lineColor:UIColor,_txtFont:UIFont,_leftMargin:CGFloat) {
        txtColor = _txtColor
        txtFont = _txtFont
        lineColor = _lineColor
        leftMargin = _leftMargin
        
        line.backgroundColor = lineColor
        lblTitle.textColor = txtColor
        lblTitle.font = txtFont
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(self.bounds)
        if isHiddenIcon {
            self.iconImage.frame = CGRect(x: leftMargin, y: (self.bounds.size.height - 20)/2, width: 20, height: 20)
            self.lblTitle.frame = CGRect(x: 20 + leftMargin * 2, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height)
        } else {
            self.iconImage.frame = CGRect(x: leftMargin, y: (self.bounds.size.height - 20)/2, width: 0, height: 0)
            self.lblTitle.frame = CGRect(x: leftMargin, y: 0, width: self.bounds.size.width - leftMargin * 2, height: self.bounds.size.height)
        }
        
        self.line.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        
    }
    
    
}
