//
//  ViewController.m
//  RollerCoaster
//
//  Created by Raija on 16/8/3.
//  Copyright © 2016年 Raija. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    //
    CALayer *groundLayer;
    CAShapeLayer *yellowPath,*greenPath;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    //
    CGSize size = self.view.frame.size;
    
    [self viewLayerWithGradientLayer:size];                         //绘制背景
    
    [self viewLayerAddMountainLayer:size];                          //绘制山峰
    
    [self viewLayerWithGrasslandLayer:&size];                       //绘制草坪
    
    groundLayer = [self viewLayerWithGroundLayer:size];             //绘制大地
    
    yellowPath = [self viewLayerWithYellowPathLayer:size];          //黄色轨迹
    
    greenPath = [self viewLayerWithGreenPathLayer:size];            //黄色轨迹
    
    for (int i = 0; i < 4; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //
            [self yellowCarPathAnimation];
        });
    }
    
    for (int i = 0; i < 4; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(85 * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //
            [self greenCarPathAnimation:size];
        });
    }
    
    for (int i = 0; i < 1; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //
            [self cloudAnimation:size];
        });
    }
    
    [self viewLayerAddTreeLayer:size];                              //绘制树木
}

//绘制背景
- (CAGradientLayer *)viewLayerWithGradientLayer:(CGSize)size {
    //
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.frame = CGRectMake(0, 0, size.width, size.height - 20);
    //渐变色
    layer.colors = [NSArray arrayWithObjects:(__bridge id)[UIColor colorWithRed:178 / 255.0 green:226 / 255.0 blue:248 / 255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:232 / 255.0 green:244 / 255.0 blue:193 / 255.0 alpha:1.0].CGColor, nil];
    //从左到右
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:layer];
    
    return layer;
}

//绘制山
- (void)viewLayerAddMountainLayer:(CGSize)size {
    //创建第一座山
    CAShapeLayer *mountainOne = [CAShapeLayer new];
    //创建第一条山的轮廓路径
    UIBezierPath *pathOne = [UIBezierPath new];
    [pathOne moveToPoint:CGPointMake(0, size.height - 120)];
    [pathOne addLineToPoint:CGPointMake(100, 100)];
    [pathOne addLineToPoint:CGPointMake(size.width / 3, size.height - 100)];
    [pathOne addLineToPoint:CGPointMake(size.width / 1.5, size.height - 50)];
    [pathOne addLineToPoint:CGPointMake(0, size.height)];
    //
    mountainOne.path = pathOne.CGPath;
    mountainOne.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:mountainOne];
    
    //计算出高度
    CGFloat pathOneHeight = [self calculatePoint:CGPointMake(0, size.height - 120) WithTwoPoint:CGPointMake(100, 100) WithReferenceX:55];
    CGFloat pathTwoHeight = [self calculatePoint:CGPointMake(100, 100) WithTwoPoint:CGPointMake(size.width / 3, size.height - 100) WithReferenceX:160];
    //
    CAShapeLayer *mountainOneLayer = [CAShapeLayer new];
    
    UIBezierPath *pathLayerOne = [UIBezierPath new];
    [pathLayerOne moveToPoint:CGPointMake(0, size.height - 120)];
    [pathLayerOne addLineToPoint:CGPointMake(55, pathOneHeight)];
    [pathLayerOne addLineToPoint:CGPointMake(70, pathOneHeight + 15)];
    [pathLayerOne addLineToPoint:CGPointMake(90, pathOneHeight)];
    [pathLayerOne addLineToPoint:CGPointMake(110, pathOneHeight + 25)];
    [pathLayerOne addLineToPoint:CGPointMake(130, pathOneHeight - 5)];
    [pathLayerOne addLineToPoint:CGPointMake(160, pathTwoHeight)];
    
    [pathLayerOne addLineToPoint:CGPointMake(size.width / 3, size.height - 100)];
    [pathLayerOne addLineToPoint:CGPointMake(size.width / 1.5, size.height - 50)];
    [pathLayerOne addLineToPoint:CGPointMake(0, size.height)];
    //
    mountainOneLayer.path = pathLayerOne.CGPath;
    mountainOneLayer.fillColor = [UIColor colorWithRed:104 / 255.0 green:92 / 255.0 blue:157 / 255.0 alpha:1.0].CGColor;
    [self.view.layer addSublayer:mountainOneLayer];
    
    //第二座山
    CAShapeLayer *mountainTwo = [CAShapeLayer new];
    //创建第一条山的轮廓路径
    UIBezierPath *pathTwo = [UIBezierPath new];
    [pathTwo moveToPoint:CGPointMake(size.width / 4, size.height - 90)];
    [pathTwo addLineToPoint:CGPointMake(size.width / 2.7, 200)];
    [pathTwo addLineToPoint:CGPointMake(size.width / 1.8, size.height - 85)];
    [pathTwo addLineToPoint:CGPointMake(size.width / 1.6, size.height - 125)];
    [pathTwo addLineToPoint:CGPointMake(size.width / 1.35, size.height - 70)];
    [pathTwo addLineToPoint:CGPointMake(0, size.height)];
    //
    mountainTwo.path = pathTwo.CGPath;
    mountainTwo.fillColor = [UIColor whiteColor].CGColor;
//    [self.view.layer addSublayer:mountainTwo];
    [self.view.layer insertSublayer:mountainTwo below:mountainOne];
    
    //计算出高度
    pathOneHeight = [self calculatePoint:CGPointMake(size.width / 4, size.height - 90) WithTwoPoint:CGPointMake(size.width / 2.7, 200) WithReferenceX:size.width / 4 + 50];
    pathTwoHeight = [self calculatePoint:CGPointMake(size.width / 1.8, size.height - 85) WithTwoPoint:CGPointMake(size.width / 2.7, 200) WithReferenceX:size.width / 2.2];
    CGFloat pathThreeHeight = [self calculatePoint:CGPointMake(size.width / 1.8, size.height - 85) WithTwoPoint:CGPointMake(size.width / 1.6, size.height - 125) WithReferenceX:size.width / 1.67];
    CGFloat pathFourHeight = [self calculatePoint:CGPointMake(size.width / 1.35, size.height - 70) WithTwoPoint:CGPointMake(size.width / 1.6, size.height - 125) WithReferenceX:size.width / 1.5];
    //第二座
    CAShapeLayer *mountainTwoLayer = [CAShapeLayer new];
    
    UIBezierPath *pathLayerTwo = [UIBezierPath new];
    [pathLayerTwo moveToPoint:CGPointMake(0, size.height)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 4, size.height - 90)];
    
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 4 + 50, pathOneHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 4 + 70, pathOneHeight + 15)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 4 + 90, pathOneHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 4 + 110, pathOneHeight + 15)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 2.2, pathTwoHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 1.8, size.height  - 85)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 1.67, pathThreeHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 1.65, pathThreeHeight + 5)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 1.6, pathThreeHeight - 2)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 1.58, pathFourHeight + 2)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 1.55, pathFourHeight - 5)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 1.5, pathFourHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width / 1.35, size.height - 70)];
    [pathLayerTwo addLineToPoint:CGPointMake(0, size.height)];
    //
    mountainTwoLayer.path = pathLayerTwo.CGPath;
    mountainTwoLayer.fillColor = [UIColor colorWithRed:75 / 255.0 green:65 / 255.0 blue:110 / 255.0 alpha:1.0].CGColor;
//    [self.view.layer addSublayer:mountainTwoLayer];
    [self.view.layer insertSublayer:mountainTwoLayer below:mountainOne];
}

//绘制草坪
- (NSArray *) viewLayerWithGrasslandLayer:(CGSize *)size {
    //
    CAShapeLayer *grasslandOne = [CAShapeLayer new];
    //
    UIBezierPath *pathOne = [UIBezierPath new];
    [pathOne moveToPoint:CGPointMake(0, size->height - 20)];
    [pathOne addLineToPoint:CGPointMake(0, size->height - 100)];
    [pathOne addQuadCurveToPoint:CGPointMake(size->width / 3.0, size->height - 20) controlPoint:CGPointMake(size->width / 6.0, size->height - 100)];
    grasslandOne.path = pathOne.CGPath;
    grasslandOne.fillColor = [UIColor colorWithRed:82 / 255.0 green:177 / 255.0 blue:44 / 255.0 alpha:1.0].CGColor;
    [self.view.layer addSublayer:grasslandOne];
    //
    CAShapeLayer *grasslandTwo = [CAShapeLayer new];
    UIBezierPath *pathTwo = [UIBezierPath new];
    [pathTwo moveToPoint:CGPointMake(0, size->height - 20)];
    [pathTwo addQuadCurveToPoint:CGPointMake(size->width, size->height - 60) controlPoint:CGPointMake(size->width / 2.0, size->height - 100)];
    [pathTwo addLineToPoint:CGPointMake(size->width, size->height - 20)];
    grasslandTwo.path = pathTwo.CGPath;
    grasslandTwo.fillColor = [UIColor colorWithRed:92 / 255.0 green:195 / 255.0 blue:52 / 255.0 alpha:1.0].CGColor;
    [self.view.layer addSublayer:grasslandTwo];
    
    return @[grasslandOne, grasslandTwo];
}

//绘制大地
- (CALayer *)viewLayerWithGroundLayer:(CGSize)size {
    //
    CALayer *ground = [[CALayer alloc] init];
    ground.frame = CGRectMake(0, size.height - 20, size.width, 20);
    ground.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ground"]].CGColor;
    [self.view.layer addSublayer:ground];
    
    return ground;
}

//黄色轨迹
- (CAShapeLayer *)viewLayerWithYellowPathLayer:(CGSize)size {
    //
    CAShapeLayer *calayer = [CAShapeLayer new];
    calayer.backgroundColor = [UIColor redColor].CGColor;
    calayer.lineWidth = 5.0;
    calayer.strokeColor = [UIColor colorWithRed:210 / 255.0 green:179 / 255.0 blue:54 / 255.0 alpha:1.0].CGColor;
    //
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, size.height - 70)];
    [path addCurveToPoint:CGPointMake(size.width / 1.5, 200) controlPoint1:CGPointMake(size.width / 6, size.height - 200) controlPoint2:CGPointMake(size.width / 2.5, size.height + 50)];
    [path addQuadCurveToPoint:CGPointMake(size.width + 10, size.height / 3) controlPoint:CGPointMake(size.width - 100, 50)];
    [path addLineToPoint:CGPointMake(size.width + 10, size.height + 10)];
    [path addLineToPoint:CGPointMake(0, size.height + 10)];
    calayer.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]].CGColor;
    calayer.path = path.CGPath;
    [self.view.layer insertSublayer:calayer below:groundLayer];
    //
    CAShapeLayer *lineLayer = [CAShapeLayer new];
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.strokeColor = [UIColor whiteColor].CGColor;
    lineLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
    lineLayer.lineWidth = 2.0;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.path = path.CGPath;
    [calayer addSublayer:lineLayer];
    
    return calayer;
}

//绿色轨迹
- (CAShapeLayer *)viewLayerWithGreenPathLayer:(CGSize)size {
    //
    CAShapeLayer *calayer = [CAShapeLayer new];
    calayer.backgroundColor = [UIColor redColor].CGColor;
    calayer.lineWidth = 5.0;
    calayer.fillRule = kCAFillRuleEvenOdd;
    calayer.strokeColor = [UIColor colorWithRed:0 / 255.0 green:147 / 255.0 blue:163 / 255.0 alpha:1.0].CGColor;
    //
    UIBezierPath *path = [UIBezierPath new];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path moveToPoint:CGPointMake(size.width + 10, size.height)];
    [path addLineToPoint:CGPointMake(size.width + 10, size.height - 70)];
    [path addQuadCurveToPoint:CGPointMake(size.width / 1.8, size.height - 70) controlPoint:CGPointMake(size.width - 120, 200)];
    [path addArcWithCenter:CGPointMake(size.width / 1.9, size.height - 140) radius:70 startAngle:0.5 * M_PI endAngle:2.5 * M_PI clockwise:true];
    [path addCurveToPoint:CGPointMake(0, size.height - 100) controlPoint1:CGPointMake(size.width / 1.8 - 60, size.height - 60) controlPoint2:CGPointMake(150, size.height / 2.3)];
    [path addLineToPoint:CGPointMake(-100, size.height + 10)];
    calayer.fillColor = [UIColor clearColor].CGColor;
    calayer.path = path.CGPath;
    [self.view.layer insertSublayer:calayer below:groundLayer];
    //
    CAShapeLayer *greenLayer = [CAShapeLayer new];
    greenLayer.fillRule = kCAFillRuleEvenOdd;
    greenLayer.strokeColor = [UIColor colorWithRed:0 green:147 / 255.0 blue:163 / 255.0 alpha:1.0].CGColor;
    UIBezierPath *grennPath = [UIBezierPath new];
    [grennPath moveToPoint:CGPointMake(size.width + 10, size.height)];
    [grennPath addLineToPoint:CGPointMake(size.width + 10, size.height - 70)];
    [grennPath addQuadCurveToPoint:CGPointMake(size.width / 1.8, size.height - 70) controlPoint:CGPointMake(size.width - 120, 200)];
    [grennPath addCurveToPoint:CGPointMake(0, size.height - 100) controlPoint1:CGPointMake(size.width / 1.8 - 60, size.height - 60) controlPoint2:CGPointMake(150, size.height / 2.3)];
    [grennPath addLineToPoint:CGPointMake(-100, size.height + 10)];
    greenLayer.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]].CGColor;
    greenLayer.path = grennPath.CGPath;
    [self.view.layer insertSublayer:greenLayer below:calayer];
    //
    CAShapeLayer *lineLayer = [CAShapeLayer new];
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.strokeColor = [UIColor whiteColor].CGColor;
    lineLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
    lineLayer.lineWidth = 2.0;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.path = path.CGPath;
    [calayer addSublayer:lineLayer];
    
    return calayer;
}

//绘制树木
- (void)viewLayerAddTreeLayer:(CGSize)size {
    //
    NSArray *treeOneArr = [NSArray arrayWithObjects:@5, @55, @70, @(size.width / 3 + 15), (size.width / 3 + 25), @(size.width - 130), @(size.width - 160), nil];
    NSArray *treeTwoArr = [NSArray arrayWithObjects:@10, @60, @(size.width / 3), @(size.width - 150), nil];
    NSArray *treeThreeArr = [NSArray arrayWithObjects:@(size.width - 210), @(size.width - 50), nil];
    NSArray *treeFourArr = [NSArray arrayWithObjects:@(size.width-235), @(size.width-220), @(size.width-40), nil];
    
    for (int i = 0; i < treeOneArr.count; i ++) {
        //
        CALayer *treeOne = [CALayer new];
        treeOne.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tree"].CGImage);
        treeOne.frame = CGRectMake([treeOneArr[i] floatValue], size.height - 43, 13, 23);
        [self.view.layer addSublayer:treeOne];
    }
    
    for (int i = 0; i < treeTwoArr.count; i ++) {
        //
        CALayer *treeOne = [CALayer new];
        treeOne.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tree"].CGImage);
        treeOne.frame = CGRectMake([treeTwoArr[i] floatValue], size.height - 52, 18, 32);
        [self.view.layer addSublayer:treeOne];
    }
    
    NSArray *treeThreeYArr = [NSArray arrayWithObjects:@(size.height - 75),@(size.height - 80), nil];
    for (int i = 0; i < treeThreeArr.count; i ++) {
        //
        CALayer *treeOne = [CALayer new];
        treeOne.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tree"].CGImage);
        treeOne.frame = CGRectMake([treeThreeArr[i] floatValue], [treeThreeYArr[i] floatValue], 18, 32);
        [self.view.layer insertSublayer:treeOne below:yellowPath];
    }
    
    NSArray *treeFourYArr = [NSArray arrayWithObjects:@(size.height - 67),@(size.height - 67),@(size.height - 72), nil];
    for (int i = 0; i < treeFourArr.count; i ++) {
        //
        CALayer *treeOne = [CALayer new];
        treeOne.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tree"].CGImage);
        treeOne.frame = CGRectMake([treeFourArr[i] floatValue], [treeFourYArr[i] floatValue], 13, 23);
         [self.view.layer insertSublayer:treeOne below:yellowPath];
    }
}

#pragma mark - Function to calculate
//参照x位置计算出高度
- (CGFloat)calculatePoint:(CGPoint)pointOne WithTwoPoint:(CGPoint)pointTwo WithReferenceX:(CGFloat)referencex {
    //
    CGFloat x1,y1,x2,y2,a,b,y;
    x1 = pointOne.x;
    y1 = pointOne.y;
    x2 = pointTwo.x;
    y2 = pointTwo.y;
    a = (y2 - y1) / (x2 - x1);
    b = y1 - a * x1;
    y = a * referencex + b;
    
    return y;
}

#pragma mark - Path animation
//黄色车轨迹动画
- (void)yellowCarPathAnimation {
    //
    CALayer *carLayer = [CALayer new];
    carLayer.frame = CGRectMake(0, 0, 17, 11);
    [carLayer setAffineTransform:CGAffineTransformTranslate(carLayer.affineTransform, 0, -7)];
    carLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"car"].CGImage);
    //
    CAKeyframeAnimation *animation = [CAKeyframeAnimation new];
    animation.keyPath = @"position";
    animation.path = yellowPath.path;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 6;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = false;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.rotationMode = kCAAnimationRotateAuto;
    [yellowPath addSublayer:carLayer];
    [carLayer addAnimation:animation forKey:@"position"];
    
}

//绿色车轨迹动画
- (void)greenCarPathAnimation:(CGSize)size {
    //
    CALayer *carLayer = [CALayer new];
    carLayer.frame = CGRectMake(0, 0, 17, 11);
    carLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"otherCar"].CGImage);
    //
    UIBezierPath *path = [UIBezierPath new];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path moveToPoint:CGPointMake(size.width + 10, size.height - 7)];
    [path addLineToPoint:CGPointMake(size.width + 10, size.height - 77)];
    [path addQuadCurveToPoint:CGPointMake(size.width / 1.8, size.height - 77) controlPoint:CGPointMake(size.width - 120, 193)];
    [path addArcWithCenter:CGPointMake(size.width / 1.9, size.height - 140) radius:63 startAngle:0.5 * M_PI endAngle:2.5 * M_PI clockwise:true];
    [path addCurveToPoint:CGPointMake(0, size.height - 107) controlPoint1:CGPointMake(size.width / 1.8 - 60, size.height - 67) controlPoint2:CGPointMake(150, size.height / 2.3 - 7)];
    [path addLineToPoint:CGPointMake(-100, size.height + 7)];
    
    //
    CAKeyframeAnimation *animation = [CAKeyframeAnimation new];
    animation.keyPath = @"position";
    animation.path = path.CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 6;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = false;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.rotationMode = kCAAnimationRotateAuto;
    [self.view.layer addSublayer:carLayer];
    [carLayer addAnimation:animation forKey:@"position"];
}

//云朵动画
- (CALayer *)cloudAnimation:(CGSize)size {
    //
    CALayer *cloudLayer = [CALayer new];
    cloudLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"cloud"].CGImage);
    cloudLayer.frame = CGRectMake(0, 0, 63, 20);
    [self.view.layer addSublayer:cloudLayer];
    //
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(size.width + 63, 40)];
    [path addLineToPoint:CGPointMake(-63, 40)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation new];
    animation.keyPath = @"positon";
    animation.path = path.CGPath;
    animation.duration = 40.0;
    animation.autoreverses = false;
    animation.repeatCount = MAXFLOAT;
    animation.calculationMode = kCAAnimationPaced;
    [cloudLayer addAnimation:animation forKey:@"position"];
    
    return cloudLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
