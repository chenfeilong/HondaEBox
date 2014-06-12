//
//  Utils.m
//  PICC_IOS
//
//  Created by apple on 12-6-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "Utils.h"
#import <QuartzCore/CALayer.h>


#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

extern NSString* CTSIMSupportCopyMobileSubscriberIdentity();

@implementation Utils

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage *)sourceImage withTargetSize: (CGSize)targetSize
{
    if( sourceImage.size.width <= targetSize.width && sourceImage.size.height <= targetSize.height){
        return sourceImage;
    }
    //TODO 保持比例
//    float widthRate = targetSize.width/sourceImage.size.width;
//    float heightRate = targetSize.height/sourceImage.size.height;
    
    float widthRate = sourceImage.size.width/targetSize.width;
    float heightRate = sourceImage.size.height/targetSize.height;
    
    
    if( widthRate > heightRate ){
        targetSize = CGSizeMake(targetSize.width, sourceImage.size.height/widthRate);
    }else{
        targetSize = CGSizeMake(sourceImage.size.width/heightRate, targetSize.height);
    }
    
    
    
    UIImage *newImage = nil;       
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
	
	CGFloat imgRatio = width / height;
	CGFloat maxRatio = targetWidth / targetHeight;
	
	if( imgRatio != maxRatio ){
		if(imgRatio < maxRatio){
			imgRatio = targetWidth / height;
			scaledWidth = imgRatio * width;
			scaledHeight = targetHeight;
		} else {
			imgRatio = targetHeight / width;
			scaledWidth = imgRatio * height; 
			scaledHeight = targetWidth;
		}
	}
	
	CGRect rect = CGRectMake(0.0, 0.0, scaledWidth, scaledHeight);
	UIGraphicsBeginImageContext(rect.size);
	[sourceImage drawInRect:rect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

static NSDictionary* biDic = nil;

+ (NSDictionary*) getBiDic{
    if( nil == biDic ){
        biDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"不计免赔率（车身划痕损失险）",@"050922",
                 @"选择修理厂特约条款",@"050251",
                 @"不计免赔率（新增加设备损失保险）",@"050923",
                 @"不计免赔率（机动车盗抢险）",@"050921",
                 @"指定修理厂特约条款",@"050252",
                 @"车身划痕损失险条款",@"050210",
                 @"不计免赔额条款",@"050340",
                 @"第三者责任保险",@"050600",
                 @"粤港、粤澳两地车区域扩展条款",@"050970",
                 @"附加交通事故精神损害赔偿责任保险",@"050640",
                 @"粤港、粤澳两地车区域扩展条款（火灾、爆炸、自燃损失险）",@"050974",
                 @"代步机动车服务特约条款",@"050385",
                 @"粤港、粤澳两地车区域扩展条款（玻璃单独破碎险）",@"050973",
                 @"更换轮胎服务特约条款",@"050384",
                 @"粤港、粤澳两地车区域扩展条款（盗抢险）",@"050972",
                 @"不计免赔率（车上人员责任险（乘客））",@"050929",
                 @"粤港、粤澳两地车区域扩展条款（车损险）",@"050971",
                 @"不计免赔率（车上人员责任险（司机））",@"050928",
                 @"送油、充电服务特约条款",@"050381",
                 @"盗抢险",@"050500",
                 @"不计免赔率（附加油污污染责任险）",@"050926",
                 @"机动车辆救助特约险条款",@"050380",
                 @"不计免赔率（车上货物责任险）",@"050925",
                 @"拖车服务特约条款",@"050382",
                 @"不计免赔率（发动机特别损失险）",@"050924",
                 @"机动车强制责任保险",@"050100",
                 @"家庭自用汽车多次出险增加免赔率特约条款",@"050241",
                 @"随车行李物品损失保险",@"050410",
                 @"自燃损失险条款",@"050310",
                 @"机动车损失保险",@"050200",
                 @"法律费用特约条款",@"050611",
                 @"起重、装卸、挖掘车辆损失扩展条款",@"050350",
                 @"无过失责任险",@"050650",
                 @"租车人人车失踪险条款",@"050510",
                 @"教练车特约条款（车损险）",@"050941",
                 @"教练车特约条款（车上人员责任险（乘客））",@"050944",
                 @"教练车特约条款（三者险）",@"050942",
                 @"机动车停驶损失险条款",@"050270",
                 @"教练车特约条款（车上人员责任险（司机））",@"050943",
                 @"玻璃单独破碎险条款",@"050231",
                 @"不计免赔率特约条款",@"050900",
                 @"新车特约条款B",@"050422",
                 @"新车特约条款A",@"050421",
                 @"异地出险住宿费特约条款",@"050621",
                 @"车上人员责任险（乘客）",@"050702",
                 @"附加机动车出境保险",@"050950)",
                 @"车上人员责任险(驾驶证考试用车)",@"050703",
                 @"附加恐怖活动、群体性暴力事件车辆损失险",@"050320",
                 @"车上人员责任险",@"050700",
                 @"车上人员责任险（司机）",@"050701",
                 @"附加换件特约条款",@"050280",
                 @"特种车辆固定设备、仪器损坏扩展条款",@"050360",
                 @"车上货物责任险",@"050800",
                 @"附加机动车出境保险（车损险）",@"050951",
                 @"附加机动车出境保险（三者险）",@"050952",
                 @"新增加设备损失保险条款",@"050260",
                 @"火灾、爆炸、自燃损失险条款",@"050220",
                 @"不计免赔率（三者险）",@"050912",
                 @"不计免赔率（车损险）",@"050911",
                 @"附加油污污染责任保险",@"050630",
                 @"可选免赔额特约条款",@"050330",
                 @"发动机特别损失险条款",@"050291",
                 @"约定区域通行费用特约条款",@"050370",
                 @"免税机动车关税责任险条款",@"050530",nil];
    }
    return biDic;
}

static NSDictionary* photoSampleDic = nil;

+ (UIImage*) getPhotoSample:(NSString*) photoTypeCode{
    if( photoSampleDic == nil ){
        photoSampleDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"idcardfront",@"PHOTOTYPE_D_0001", 
                          @"idcardback",@"PHOTOTYPE_D_0002", 
                          @"steerno",@"PHOTOTYPE_D_0003", 
                          @"driveno",@"PHOTOTYPE_D_0004", 
                          @"toubaodanfront",@"PHOTOTYPE_D_0005", 
                          @"lastyear",@"PHOTOTYPE_D_0006", 
                          @"papertoubaodanfront",@"PHOTOTYPE_D_0007", 
                          @"vinno",@"PHOTOTYPE_C_0001", 
                          @"chewei45",@"PHOTOTYPE_C_0002", 
                          @"chetou45",@"PHOTOTYPE_C_0003", 
                          @"driveno",@"PHOTOTYPE_C_0010", 
                          @"steerno",@"PHOTOTYPE_C_0011", 
                          @"idcardfront",@"PHOTOTYPE_C_0012", 
                          @"idcardback",@"PHOTOTYPE_C_0013",  nil];
    }
    NSString* res = [photoSampleDic objectForKey:photoTypeCode];
    if( res == nil ){
        return [UIImage imageNamed:@"other_photo.png"];
    }else{
        NSLog(@"res:%@",res);
        UIImage *img = [UIImage imageNamed:res];
        if( img == nil ){
            img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",res]];
        }
        return img;
    }
}

NSDictionary* licenseColorDic;

+ (NSDictionary *) licenseColorDic{
    if( licenseColorDic == nil ){
        licenseColorDic = [[NSDictionary alloc ]initWithObjectsAndKeys:@"蓝",@"01",@"白蓝",@"05",@"黄",@"04",@"白",@"02",@"黑",@"02",@"其他",@"99", nil];
    }
    return licenseColorDic;
}

+ (void) insertView:(UIView*)view inSuper:(UIView*)superView space:(float)space{
    
//    float viewBottom = view.frame.origin.y + view.frame.size.height;
    float moveH = view.frame.size.height + space;
   
    //所有以下的view下移
    for(UIView* v in superView.subviews ){
        if( v.frame.origin.y > view.frame.origin.y - 0.1 ){
            CGRect rect = v.frame;
            rect.origin.y += moveH;
            v.frame = rect;
        }
    }
    
    [superView addSubview:view];
    
    if( [superView isKindOfClass:UIScrollView.class]){
        UIScrollView *scorll = (UIScrollView*) superView;
        CGSize size = scorll.contentSize;
        size.height += moveH;
        scorll.contentSize = size;
    }else{
        CGRect rect = superView.frame;
        rect.size.height += moveH;
        superView.frame = rect;
    }
}

//将某个subView 加入到父View中，如果这个subView存在子View ，则遍历这些子View，将这些子View直接加到父View中
+ (void) addSubView:(UIView*)view inSuper:(UIView*)superView{
    
    if (view==nil || superView == nil) {
        return;
    }
    if (view.subviews == nil || [view.subviews count]==0) {
        [superView addSubview:view];
        return;
    }
    
    for (UIView *v in view.subviews) {
        CGRect tempFram = v.frame;
        tempFram.origin.x = view.frame.origin.x+tempFram.origin.x;
        tempFram.origin.y = view.frame.origin.y+tempFram.origin.y;
        v.frame = tempFram;
        [superView addSubview:v];
    }
    
}
//将某个subView 从父View中移除，如果这个subView存在子View ，则遍历这些子View，将这些子View逐个从父View中移除
+ (void) removeSubView:(UIView*)view fromSuper:(UIView*)superView{
    if (view == nil || superView == nil) {
        return;
    }
    
    if (view.subviews ==nil || [view.subviews count]==0) {
        [view removeFromSuperview];
        return;
    }
    
    for (UIView * v in view.subviews) {
        [v removeFromSuperview];
    }
}

+ (int)moveView:(UIViewController*) root textField:(UITextField *)textField leaveView:(BOOL)leave keyBoardMargin:(int)_margin{
    
    int ret=0 ; // yuxl +0
    
    //屏幕尺寸
    float screenHeight = 480;
    //键盘尺寸
    float keyboardHeight = 180;
    float statusBarHeight,NavBarHeight,tableCellHeight,textFieldOriginY,textFieldFromButtomHeighth;
    int margin;
    //屏幕状态栏高度
    statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //获取导航栏高度
    NavBarHeight = root.navigationController.navigationBar.frame.size.height;
    
    UITableViewCell *tableViewCell = (UITableViewCell *)textField.superview;
    //获取单元格高度
    //    tableCellHeight = tableViewCell.frame.size.height;
    tableCellHeight = 0;
    
    CGRect fieldFrame = [root.view convertRect:textField.frame fromView:tableViewCell];
    //获取文本框相对本视图的Y轴坐标+文本框高度
    textFieldOriginY = fieldFrame.origin.y+fieldFrame.size.height;
    
    //    NSLog(@"textFieldOriginY = %f",textFieldOriginY);
    //    NSLog(@"tableCellHeight = %f",tableCellHeight);
    //    NSLog(@"NavBarHeight = %f",NavBarHeight);
    //    NSLog(@"statusBarHeight = %f",statusBarHeight);
    
    //计算文本框到屏幕底部的高度（屏幕高度-顶部状态栏高度-导航栏高度-文本框的相对Y轴位置-单元格高度）
    textFieldFromButtomHeighth = screenHeight - statusBarHeight-NavBarHeight-textFieldOriginY-tableCellHeight;
    
    if (!leave) {
        if (textFieldFromButtomHeighth < keyboardHeight) {
            //如果文本框到屏幕底部的高度<键盘高度
            //则计算差距
            margin = keyboardHeight - textFieldFromButtomHeighth;
            //kebBoardMargin为成员变量，记录上一次移动的间距，用户离开文本时恢复视图高度
            ret = margin;
        }else{
            margin = 0;
            ret = 0;
        }
    }
    //    NSLog(@"keyBoardMargin = %d",_keyBoardMargin);
    
    const float movementDuration = 0.3f;//动画时间
    int movement = (leave ? _margin : -margin);//进入时根据差距移动视图，离开时恢复之前的高度
    [UIView beginAnimations:@"textFieldAnim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    UIView *view_move = (UIView *)[root.view viewWithTag:501];
    view_move.frame = CGRectOffset(view_move.frame, 0, movement);
    [UIView commitAnimations];
    
    return ret;
}

+ (void)setRoundRect:(UIView*) view{
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [[UIColor grayColor]CGColor];
    view.layer.borderWidth = 1;
}

static int _nameW = 110;
+ (void) setNameW:(int) nameW{
    _nameW = nameW;
}

+ (UIButton*) button:(NSString*)txt target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:txt forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UITextField*) textField{
    UITextField *tf = [[UITextField alloc]init];
    [tf autorelease];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    return tf;
}

+ (UITextView *) textView{
    UITextView *tv = [[UITextView alloc] init];
//    tv.contentSize = CGSizeMake(100, 62);
//    tv.layer.cornerRadius = 8;
//    tv.layer.masksToBounds = YES;
//    tv.layer.borderColor = [[UIColor blackColor] CGColor];
//    tv.layer.borderWidth = 1;
    [tv autorelease];
    return tv;
}
//获取正在编辑中的编辑框
+ (UIView *)editingTextField:(UIView*) view{
    if( [view isKindOfClass:[UITextField class]] ){
        if( ((UITextField*)view).isEditing ){
            return ((UITextField*)view);
        }else{
            return nil;
        }        
    }else if( [view isKindOfClass:[UITextView class]] ){
        if( ((UITextView*)view).isFirstResponder ){
            return ((UITextView*)view);
        }else{
            return nil;
        }
    }
    
    for (UIView *subView in view.subviews) {
        UIView *tf = [Utils editingTextField:subView];
        
        if (tf != nil) {
            return tf;
        }
    }
    
    return nil;
}





#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString *)macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+(NSString *)getStatusStrWithUnderWriteInd:(NSString *)underWriteInd{
    NSArray *valueArr = [[NSArray alloc] initWithObjects:@"初始状态",@"核保通过,可支付!",@"核保不通过",@"自动审核,可支付!",@"拒保",@"复核通过",@"承包通过",@"复核不通过",@"待复核",@"待核保",@"核保状态错误", nil];
    NSArray *keyArr = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"404", nil];
    NSDictionary *statusDic = [[NSDictionary alloc] initWithObjects:valueArr forKeys:keyArr];
    NSString *statusStr = [NSString stringWithFormat:@"%@",[statusDic objectForKey:underWriteInd]];
    
    [valueArr release];
    [keyArr release];
    [statusDic release];
    return statusStr;
}
@end
