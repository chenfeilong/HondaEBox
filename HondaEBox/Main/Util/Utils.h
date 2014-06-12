#import <Foundation/Foundation.h>
#import "AppDelegate.h"

//#define BEGIN_POOL NSAutoreleasePool *autoreleasePoolInUtils = [[NSAutoreleasePool alloc]init];
//
//#define END_POOL  [autoreleasePoolInUtils release];




     
@interface Utils : NSObject

//图片压缩
+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage *)sourceImage withTargetSize: (CGSize)targetSize;

+ (UIImage*) getPhotoSample:(NSString*) photoTypeCode;

//车片底色字典
+ (NSDictionary *) licenseColorDic;



//向某个view中插入一个view,自动将其之下的元素向下移
+ (void) insertView:(UIView*)view inSuper:(UIView*)superView space:(float)space;
//将某个subView 加入到父View中，如果这个subView存在子View ，则遍历这些子View，将这些子View直接加到父View中
+ (void) addSubView:(UIView*)view inSuper:(UIView*)superView;
//将某个subView 从父View中移除，如果这个subView存在子View ，则遍历这些子View，将这些子View逐个从父View中移除
+ (void) removeSubView:(UIView*)view fromSuper:(UIView*)superView;
#

//用于处理textField的进入事件及离开事件
//+(int)moveView:(UIViewController*) view textField:(UITextField *)textField leaveView:(BOOL)leave margin:(int)_margin;
//+ (int)moveView:(UIViewController*) root textField:(UITextField *)textField leaveView:(BOOL)leave keyBoardMargin:(int)_margin
+ (void)setRoundRect:(UIView*) view;

//商业险代码及名称
+ (NSDictionary*) getBiDic;

//添加一行  名字：值 
+ (void) setNameW:(int) nameW;

//读助登录报文返回的值,or nil if not found
//+ (NSString*) getParam:(NSString*) key defaultValue:(NSString*) defaultValue;

//读取网址  PHOTOCONNECTION
//+(NSString *) getConnUrl:(NSString *)defaultValue;

//返回imsi号
//+ (NSString*) getDeviceIMSI;

//+ (NSString*) getValue:(UIView*) view;

//+ (void) setValue:(UIView*)view value:(NSString*) value;

//当前时间
//+ (NSString*) curTime;

//是否有对应的权限
//+ (BOOL) isAVILABLE:(NSString*) code;


+ (UITextField*) textField;

+ (UIButton*) button:(NSString*)txt target:(id)target action:(SEL)action;

+ (UITextView *) textView;

//找到当前在编辑的textfield
+ (UITextField *)editingTextField:(UIView*) view;
//获取iphonemac地址
+ (NSString *) macaddress;

//根据投保状态码获取投保状态
+(NSString *)getStatusStrWithUnderWriteInd:(NSString *)underWriteInd;
@end
