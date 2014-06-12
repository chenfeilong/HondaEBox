
#import "CheckButton.h"
#import "AppDelegate.h"
@implementation CheckButton
@synthesize name = _name, fontSize=_fontSize;
@synthesize btn_margin = _btn_margin;
@synthesize selectedBlock;
@synthesize isSelected= _isSelected;
@synthesize isUnClickable = _isUnClickable;

- (id)initWithFrame:(CGRect)frame
{ 
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame andName:(NSString*)name {
    return [self initWithFrame:frame andName:name andSelectedBlock:nil];
}

-(id) initWithFrame:(CGRect)frame andName:(NSString*)name andSelectedBlock:(void(^)(BOOL isSelected))block{
    self = [self initWithFrame:frame];
    if(self){
        self.selectedBlock = block;
        if(block==nil){NSLog(@"nillll");}
        self.name = name;
        _fontSize = self.fontSize;
        [self initSubView:frame];
    }
    return self;
}

- (void)onSel:(id)sender
    {
        if(!_isUnClickable){
            UIButton * btn = (UIButton*)[self viewWithTag:10000];
            if(_isSelected){
                [btn setBackgroundImage:[UIImage imageNamed:@"main_checkbox_unchecked.png"] forState:UIControlStateNormal];
                _isSelected = NO;
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"main_checkbox_checked.png"] forState:UIControlStateNormal];
                _isSelected = YES;
            }
            if (selectedBlock) {
                selectedBlock(_isSelected);
            }
        }
   }

- (void)setIsSelected:(BOOL)isSelectedTemp{
    
    _isSelected = isSelectedTemp;
    if (selectedBlock) {
        selectedBlock(_isSelected);
    }
    UIButton * btn = (UIButton*)[self viewWithTag:10000];
    [btn setBackgroundImage:[UIImage imageNamed:(_isSelected?@"main_checkbox_checked.png":@"main_checkbox_unchecked.png")] forState:UIControlStateNormal];
}

-(void)registerClickAcitonListener:(void(^)(BOOL))block{
    self.selectedBlock = block;
}

-(void)setIsUnClickable:(BOOL)isUnClickableTemp{
    _isUnClickable = isUnClickableTemp;
//    UIButton * btn = (UIButton*)[self viewWithTag:10000];
//    [btn setEnabled:isUnClickable];
}
-(void)setBtn_margin:(struct MARGIN)btn_marginTemp{
    _btn_margin =btn_marginTemp;
//    [self initWithFrame:self.frame andName:self.name andSelectedBlock:selectedBlock];
    [self initSubView:self.frame];

}

- (void) initSubView:(CGRect)frame
{   
    for(UIView *v in self.subviews ){
        [v removeFromSuperview];
    }
   
    BEGIN_POOL
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    btn.frame = CGRectMake(self.btn_margin.left>0?self.btn_margin.left:0, self.btn_margin.top>0?self.btn_margin.top:2.5, 20, frame.size.height-(self.btn_margin.top>0?self.btn_margin.top:5)-self.btn_margin.bottom);
         btn.frame = CGRectMake(self.btn_margin.left>0?self.btn_margin.left:0, self.btn_margin.top>0?self.btn_margin.top:3.5, 20, 20);
        btn.tag =  10000;
        [btn setBackgroundImage:[UIImage imageNamed:(self.isSelected?@"main_checkbox_checked.png":@"main_checkbox_unchecked.png")] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onSel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        NSLog(@"margin-x:%f",btn.frame.size.width+btn.frame.origin.x + (self.btn_margin.right>0?self.btn_margin.right:2));
            UILabel *label = [[[UILabel alloc]init]autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.numberOfLines =  2;
        label.frame = CGRectMake(btn.frame.size.width+btn.frame.origin.x + (self.btn_margin.right>0?self.btn_margin.right:2), 0, frame.size.width - btn.frame.size.width - btn.frame.origin.x - self.btn_margin.right, frame.size.height);

        label.text = self.name;
        [self addSubview:label];
    END_POOL

}

-(void) drawRect:(CGRect)rect{
    [self initSubView:rect];
}
- (void)dealloc {
    if(self.name){
        self.name = nil;
    }
    [super dealloc];
}
@end
