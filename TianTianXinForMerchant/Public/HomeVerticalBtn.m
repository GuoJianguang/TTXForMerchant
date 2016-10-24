//
//  HomeVerticalBtn.m
//  天添薪
//
//  Created by ttx on 16/1/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "HomeVerticalBtn.h"

@implementation HomeVerticalBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initViewswithframe:TWitdh/5];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initViewswithframe:TWitdh/5];
    }
    return self;
}

- (UILabel *)alerLabel
{
    if (!_alerLabel) {
        _alerLabel = [[UILabel alloc]init];
    }
    return _alerLabel;
}

-(void) initViewswithframe:(CGFloat)width {
    self.backgroundColor = [UIColor clearColor];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.textLabel = [[UILabel alloc] init];
    
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.font = [UIFont boldSystemFontOfSize:13];
    
    self.alerLabel = [[UILabel alloc]initWithFrame:CGRectMake(width - 20, 5, 14, 14)];
    self.alerLabel.backgroundColor = MacoColor;
    self.alerLabel.layer.cornerRadius = 7;
//    self.alerLabel.text = ;
    self.alerLabel.layer.masksToBounds = YES;
    self.alerLabel.textAlignment = NSTextAlignmentCenter;
    self.alerLabel.adjustsFontSizeToFitWidth = YES;
    self.alerLabel.font = [UIFont systemFontOfSize:10];
    self.alerLabel.textColor = [UIColor whiteColor];
    self.alerLabel.hidden = YES;
    [self addSubview:self.alerLabel];
    
    [self addSubview:self.imageView];
    [self addSubview:self.textLabel];
    
    self.imageView.frame = CGRectMake(width/4, 2, width/2, self.bounds.size.height/2);
    self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) , width, self.bounds.size.height/2 );
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}



- (void)setAlerTitle:(NSString *)alerTitle
{
    _alerTitle = alerTitle;
    self.alerLabel.text = _alerTitle;
}


- (void)setShowAlerNumber:(BOOL)showAlerNumber
{
    _showAlerNumber = showAlerNumber;
    if (!_showAlerNumber){
        self.alerLabel.frame = CGRectMake(TWitdh/5. - 20, 5, 6, 6);
        self.alerLabel.layer.cornerRadius = 3;
        self.alerLabel.text = @"";
        self.alerLabel.layer.masksToBounds = YES;
    }
}

- (void)setShowAlerLabel:(BOOL)showAlerLabel
{
    _showAlerLabel = showAlerLabel;
    self.alerLabel.hidden = !_showAlerLabel;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textLabel.textColor = _textColor;
}
- (void)awakeFromNib {
    // Initialization code
}


@end
