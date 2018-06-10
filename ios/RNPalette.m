
#import "UIPalette.h"
#import "iOSPalette.h"
#import <AssetsLibrary/AssetsLibrary.h>

#if __has_include("RCTLog.h")
#import "RCTLog.h"
#else
#import <React/RCTLog.h>
#endif

#if __has_include("RCTBridge.h")
#import "RCTBridge.h"
#else
#import <React/RCTBridge.h>
#endif

#if __has_include("RCTConvert.h")
#import "RCTConvert.h"
#else
#import <React/RCTConvert.h>
#endif

#if __has_include("RCTEventDispatcher.h")
#import "RCTEventDispatcher.h"
#else
#import <React/RCTEventDispatcher.h>
#endif

#if __has_include("RCTImageLoader.h")
#import "RCTImageLoader.h"
#else
#import <React/RCTImageLoader.h>
#endif

#if __has_include("UIImageView+WebCache.h")
#import "UIImageView+WebCache.h"
#else
#import <SDWebImage/UIImageView+WebCache.h>
#endif

@interface RNPalette ()

@end

@implementation RNPalette

static RCTImageLoaderCancellationBlock _reloadImageCancellationBlock;

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();


RCT_REMAP_METHOD(getNamedSwatchesFromUrl,
                 getNamedSwatchesFromUrlWithUrl: (NSString *)url
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  
  if (_reloadImageCancellationBlock) {
    _reloadImageCancellationBlock();
    _reloadImageCancellationBlock = nil;
  }
  
  NSURL * urlImage = [NSURL URLWithString: url];
  
  /*_reloadImageCancellationBlock = [_bridge.imageLoader loadImageWithURLRequest:[RCTConvert NSURLRequest:urlImage]
                                                                      callback:^(NSError *error, UIImage *image) {
                                                                        if (error) {
                                                                          reject(@"500", @"Error image", error);
                                                                        }else{
                                                                          [self getNamedSwatchesFromImage:image resolver:resolve rejecter:reject];
                                                                        }
                                                                      }];
  */
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager loadImageWithURL:urlImage
                    options:0
                   progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                     
                   }
                  completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    
                    if (image && finished) {
                      [self getNamedSwatchesFromImage:image resolver:resolve rejecter:reject];
                    }else{
                      reject(@"500", @"Error image", error);
                    }
                    
                  }];
  
  
}

RCT_REMAP_METHOD(getAllSwatchesFromUrl,
                 getAllSwatchesFromUrlWithUrl: (NSString *)url
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  
  if (_reloadImageCancellationBlock) {
    _reloadImageCancellationBlock();
    _reloadImageCancellationBlock = nil;
  }
  
  NSURL * urlImage = [NSURL URLWithString: url];
  
  /*_reloadImageCancellationBlock = [_bridge.imageLoader loadImageWithURLRequest:[RCTConvert NSURLRequest:urlImage]
                                                                      callback:^(NSError *error, UIImage *image) {
                                                                        if (error) {
                                                                          reject(@"500", @"Error image", error);
                                                                        }else{
                                                                          [self getAllSwatchesFromImage:image resolver:resolve rejecter:reject];
                                                                        }
                                                                      }];
  */
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager loadImageWithURL:urlImage
                                options:0
                               progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                                 
                               }
                              completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                                
                                if (image && finished) {
                                  [self getAllSwatchesFromImage:image resolver:resolve rejecter:reject];
                                }else{
                                  reject(@"500", @"Error image", error);
                                }
                                
                              }];
  
  
}


RCT_REMAP_METHOD(getNamedSwatches,
                 getNamedSwatchesWithUrl: (NSString *)url
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  
  
  //NSURL * urlImage = [NSURL URLWithString: url];
  UIImage * image = [UIImage imageWithContentsOfFile:url];
  [self getNamedSwatchesFromImage:image resolver:resolve rejecter:reject];
  
}



RCT_REMAP_METHOD(getAllSwatches,
                 getAllSwatchesWithUrl: (NSString *)url
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  
  
  //NSURL * urlImage = [NSURL URLWithString: url];
  UIImage * image = [UIImage imageWithContentsOfFile:url];
  [self getAllSwatchesFromImage:image resolver:resolve rejecter:reject];
  
}


- (void)getAllSwatchesFromImage:(UIImage *)image
                         resolver:(RCTPromiseResolveBlock)resolve
                         rejecter:(RCTPromiseRejectBlock)reject
{
  
  [image getPaletteImageColorWithMode:ALL_MODE_PALETTE withCallBack:^(PaletteColorModel *recommendColor, NSDictionary *allModeColorDic,NSError *error) {
    
    
   if (error) {
      reject(@"500", @"Error analize", error);
     return;
    }
    
    
    NSMutableArray * data = [[NSMutableArray alloc] init];
    
    if (recommendColor!=nil){
      [data addObject:@{ @"color":[recommendColor imageColorString]}];
    }
    if ([[allModeColorDic objectForKey:@"vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"vibrant"];
      [data addObject:@{ @"color":[vibrant imageColorString]}];
    }
    if ([[allModeColorDic objectForKey:@"dark_vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * dark_vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"dark_vibrant"];
      [data addObject:@{ @"color":[dark_vibrant imageColorString]}];
    }
    if ([[allModeColorDic objectForKey:@"light_vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * light_vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"light_vibrant"];
      [data addObject:@{ @"color":[light_vibrant imageColorString]}];
    }
    if ([[allModeColorDic objectForKey:@"muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"muted"];
      [data addObject:@{ @"color":[muted imageColorString]}];
    }
    if ([[allModeColorDic objectForKey:@"dark_muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * dark_muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"dark_muted"];
      [data addObject:@{ @"color":[dark_muted imageColorString]}];
    }
    if ([[allModeColorDic objectForKey:@"light_muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * light_muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"light_muted"];
      [data addObject:@{ @"color":[light_muted imageColorString]}];
    }

    
    
    resolve(data);
  }];

  
}


- (void)getNamedSwatchesFromImage:(UIImage *)image
                        resolver:(RCTPromiseResolveBlock)resolve
                        rejecter:(RCTPromiseRejectBlock)reject
{
  
  [image getPaletteImageColorWithMode:ALL_MODE_PALETTE withCallBack:^(PaletteColorModel *recommendColor, NSDictionary *allModeColorDic,NSError *error) {
    

    if (error) {
      reject(@"500", @"Error analize", error);
      return;
    }
    
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
  
    if ([[allModeColorDic objectForKey:@"vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"vibrant"];
      [data setObject:@{ @"color":[vibrant imageColorString]} forKey:@"Vibrant"];
    }
    if ([[allModeColorDic objectForKey:@"dark_vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * dark_vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"dark_vibrant"];
      [data setObject:@{ @"color":[dark_vibrant imageColorString]} forKey:@"Vibrant Dark"];
    }
    if ([[allModeColorDic objectForKey:@"light_vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * light_vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"light_vibrant"];
      [data setObject:@{ @"color":[light_vibrant imageColorString]} forKey:@"Vibrant Light"];
    }
    if ([[allModeColorDic objectForKey:@"muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"muted"];
      [data setObject:@{ @"color":[muted imageColorString]} forKey:@"Muted"];
    }
    if ([[allModeColorDic objectForKey:@"dark_muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * dark_muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"dark_muted"];
      [data setObject:@{ @"color":[dark_muted imageColorString]} forKey:@"Muted Dark"];
    }
    if ([[allModeColorDic objectForKey:@"light_muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * light_muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"light_muted"];
      [data setObject:@{ @"color":[light_muted imageColorString]} forKey:@"Muted Light"];
    }

   
    
    resolve(data);
    
    
  }];

}

@end
