//
//  Httpgetpost.h
//  OpenSeatr
//
//  Created by Ben Wang on 8/7/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

@interface Httpgetpost : NSObject

- (void) httpget:(NSString *)url;
-(void) httppost:(NSString*)postcontent urlstr:(NSString*) url;
@end
