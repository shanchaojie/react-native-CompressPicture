//
//  CompressPicture.m
//  CompressPicture
//
//  Created by shanchaojie on 2017/12/11.
//  Copyright © 2017年 SuperShan. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "CompressPicture.h"

@implementation CompressPicture

RCT_EXPORT_MODULE(CompressPicture);

RCT_REMAP_METHOD(CompressPicture, image:(UIImage*)image size:(CGFloat )size resolver:(RCTPromiseResolveBlock )resolver rejecter:(RCTPromiseRejectBlock )reject){

    NSData *data = [self compressOriginalImage:image toMaxDataSizeKBytes:size];
    resolver(data);

}

- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1024.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.05f) {
        maxQuality = maxQuality - 0.05f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1024.0;
        if (lastData == dataKBytes) {
            //已压缩到最小
            break;
        }else{
            lastData = dataKBytes;

        }
    }
    NSLog(@"%g",lastData);
    NSLog(@"%@",data);
    return data;
}

@end
