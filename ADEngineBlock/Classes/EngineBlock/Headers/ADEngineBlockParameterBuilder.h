/*  
 *  ADEngineBlockDictionaryBuilder.h
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 5/19/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface ADEngineBlockParameterBuilder : NSObject {}

- (NSDictionary *)trimUser:(BOOL)trimUser
           includeEntities:(BOOL)includeEntities;

- (NSDictionary *)sinceId:(unsigned long long)sinceId
                    maxId:(unsigned long long)maxId
                    count:(int)count
                     page:(int)page;

- (NSDictionary *)sinceId:(unsigned long long)sinceId
                    maxId:(unsigned long long)maxId
                    count:(int)count
                     page:(int)page
                 trimUser:(BOOL)trimUser
          includeEntities:(BOOL)includeEntities;

- (NSDictionary *)sinceId:(unsigned long long)sinceId
                    maxId:(unsigned long long)maxId
                    count:(int)count
                     page:(int)page
                 trimUser:(BOOL)trimUser
               includeRts:(BOOL)includeRts
          includeEntities:(BOOL)includeEntities;

- (NSDictionary *)userId:(unsigned long long)userId
                 sinceId:(unsigned long long)sinceId
                   maxId:(unsigned long long)maxId
                   count:(int)count
                    page:(int)page
                trimUser:(BOOL)trimUser
              includeRts:(BOOL)includeRts
         includeEntities:(BOOL)includeEntities;

- (NSDictionary *)update:(NSString *)message
               inReplyTo:(unsigned long long)replyToId
                latitude:(float)latitude
               longitude:(float)longitude
                 placeId:(unsigned long long)placeId
            displayCoord:(BOOL)displayCoord
                trimUser:(BOOL)trimUser
         includeEntities:(BOOL)includeEntities;

@end
