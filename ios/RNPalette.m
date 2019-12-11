
#import "RNPalette.h"
#import "UIPalette.h"
#import <AssetsLibrary/AssetsLibrary.h>

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
      [data addObject:@{ 
          @"name":@"recommend",
          @"color":[recommendColor imageColorString],
          @"population" : [NSNumber numberWithInteger:[recommendColor population]],
          @"percentage":[NSNumber numberWithFloat:[recommendColor percentage]],
      }];
    }
    if ([[allModeColorDic objectForKey:@"vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"vibrant"];
      [data addObject:@{
          @"name":@"Vibrant",
          @"color":[vibrant  imageColorString],
          @"population" : [NSNumber numberWithInteger:[vibrant population]],
          @"percentage":[NSNumber numberWithFloat:[vibrant percentage]],
      }];    
    }
    if ([[allModeColorDic objectForKey:@"dark_vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * dark_vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"dark_vibrant"];
      [data addObject:@{
          @"name":@"Vibrant Dark",
          @"color":[dark_vibrant  imageColorString],
          @"population" : [NSNumber numberWithInteger:[dark_vibrant population]],
          @"percentage":[NSNumber numberWithFloat:[dark_vibrant percentage]],
      }];    
    }
    if ([[allModeColorDic objectForKey:@"light_vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * light_vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"light_vibrant"];
      [data addObject:@{
          @"name":@"Vibrant Light",
          @"color":[light_vibrant  imageColorString],
          @"population" : [NSNumber numberWithInteger:[light_vibrant population]],
          @"percentage":[NSNumber numberWithFloat:[light_vibrant percentage]],
      }];    
    }
    if ([[allModeColorDic objectForKey:@"muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"muted"];
      [data addObject:@{
          @"name":@"Muted",
          @"color":[muted imageColorString],
          @"population" : [NSNumber numberWithInteger:[muted population]],
          @"percentage":[NSNumber numberWithFloat:[muted percentage]],
      }];    
    }
    if ([[allModeColorDic objectForKey:@"dark_muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * dark_muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"dark_muted"];
      [data addObject:@{
          @"name":@"Muted Dark",
          @"color":[dark_muted imageColorString],
          @"population" : [NSNumber numberWithInteger:[dark_muted population]],
          @"percentage":[NSNumber numberWithFloat:[dark_muted percentage]],
      }];    
    }
    if ([[allModeColorDic objectForKey:@"light_muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * light_muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"light_muted"];
      [data addObject:@{
          @"name":@"Muted Light",
          @"color":[light_muted imageColorString],
          @"population" : [NSNumber numberWithInteger:[light_muted population]],
          @"percentage":[NSNumber numberWithFloat:[light_muted percentage]],
      }];    
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
      [data setObject:@{ 
        @"color":[vibrant imageColorString],
        @"population":[NSNumber numberWithInteger:[vibrant population]],
        @"percentage":[NSNumber numberWithFloat:[vibrant percentage]]
      } forKey:@"Vibrant"];
    }
    if ([[allModeColorDic objectForKey:@"dark_vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * dark_vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"dark_vibrant"];
      [data setObject:@{ 
        @"color":[dark_vibrant imageColorString],
        @"population":[NSNumber numberWithInteger:[dark_vibrant population]],
        @"percentage":[NSNumber numberWithFloat:[dark_vibrant percentage]]
      } forKey:@"Vibrant Dark"];

    }
    if ([[allModeColorDic objectForKey:@"light_vibrant"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * light_vibrant = (PaletteColorModel *)[allModeColorDic objectForKey:@"light_vibrant"];
      [data setObject:@{ 
        @"color":[light_vibrant imageColorString],
        @"population":[NSNumber numberWithInteger:[light_vibrant population]],
        @"percentage":[NSNumber numberWithFloat:[light_vibrant percentage]],
      } forKey:@"Vibrant Light"];
    }
    if ([[allModeColorDic objectForKey:@"muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"muted"];
      [data setObject:@{ 
        @"color":[muted imageColorString],
        @"population":[NSNumber numberWithInteger:[muted population]],
        @"percentage":[NSNumber numberWithFloat:[muted percentage]]
      } forKey:@"Muted"];
    }
    if ([[allModeColorDic objectForKey:@"dark_muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * dark_muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"dark_muted"];
      [data setObject:@{ 
        @"color":[dark_muted imageColorString],
        @"population":[NSNumber numberWithInteger:[dark_muted population]],
        @"percentage":[NSNumber numberWithFloat:[dark_muted percentage]]
      } forKey:@"Muted Dark"];
    }
    if ([[allModeColorDic objectForKey:@"light_muted"] isKindOfClass:[PaletteColorModel class]]){
      PaletteColorModel * light_muted = (PaletteColorModel *)[allModeColorDic objectForKey:@"light_muted"];
      [data setObject:@{ 
        @"color":[light_muted imageColorString],
        @"population":[NSNumber numberWithInteger:[light_muted population]],
        @"percentage":[NSNumber numberWithFloat:[light_muted percentage]]
      } forKey:@"Muted Light"];
    }

   
    
    resolve(data);
    
    
  }];

}

@end
