/*
 *  ADEngineBlockDictionaryBuilder.h
 *  ADEngineBlock
 *
 *  Created by Adam Duke on 5/19/11.
 *  Copyright 2011 Adam Duke. All rights reserved.
 *
 */

#import "ADEngineBlockParameterBuilder.h"

@implementation ADEngineBlockParameterBuilder

+ (NSDictionary *)trimUser:(BOOL)trimUser
           includeEntities:(BOOL)includeEntities
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:[NSString stringWithFormat:@"%d", trimUser ? 1:0] forKey:@"trim_user"];
    [params setObject:[NSString stringWithFormat:@"%d", includeEntities ? 1:0] forKey:@"include_entities"];
    return params;
}

+ (NSDictionary *)sinceId:(unsigned long long)sinceId
                    maxId:(unsigned long long)maxId
                    count:(int)count
                     page:(int)page
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    if(sinceId > 0)
    {
        [params setObject:[NSString stringWithFormat:@"%qu", sinceId] forKey:@"since_id"];
    }
    if(maxId > 0)
    {
        [params setObject:[NSString stringWithFormat:@"%qu", maxId] forKey:@"max_id"];
    }
    if(count > 0)
    {
        [params setObject:[NSString stringWithFormat:@"%d", count] forKey:@"count"];
    }
    if(page > 0)
    {
        [params setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    }
    return params;
}

+ (NSDictionary *)sinceId:(unsigned long long)sinceId
                    maxId:(unsigned long long)maxId
                    count:(int)count
                     page:(int)page
                 trimUser:(BOOL)trimUser
          includeEntities:(BOOL)includeEntities
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params addEntriesFromDictionary:[self sinceId:sinceId maxId:maxId count:count page:page]];
    [params addEntriesFromDictionary:[self trimUser:trimUser includeEntities:includeEntities]];
    return params;
}

+ (NSDictionary *)sinceId:(unsigned long long)sinceId
                    maxId:(unsigned long long)maxId
                    count:(int)count
                     page:(int)page
                 trimUser:(BOOL)trimUser
               includeRts:(BOOL)includeRts
          includeEntities:(BOOL)includeEntities
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params addEntriesFromDictionary:[self sinceId:sinceId maxId:maxId count:count page:page trimUser:trimUser includeEntities:includeEntities]];
    [params setObject:[NSString stringWithFormat:@"%d", includeRts ? 1:0] forKey:@"include_rts"];
    return params;
}

+ (NSDictionary *)userId:(unsigned long long)userId
                 sinceId:(unsigned long long)sinceId
                   maxId:(unsigned long long)maxId
                   count:(int)count
                    page:(int)page
                trimUser:(BOOL)trimUser
              includeRts:(BOOL)includeRts
         includeEntities:(BOOL)includeEntities
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    if(userId > 0)
    {
        [params setObject:[NSString stringWithFormat:@"%qu", userId] forKey:@"user_id"];
    }
    [params addEntriesFromDictionary:[self sinceId:sinceId maxId:maxId count:count page:page trimUser:trimUser includeRts:includeRts includeEntities:includeEntities]];
    return params;
}

+ (NSDictionary *)update:(NSString *)message
               inReplyTo:(unsigned long long)replyToId
                latitude:(float)latitude
               longitude:(float)longitude
                 placeId:(unsigned long long)placeId
            displayCoord:(BOOL)displayCoord
                trimUser:(BOOL)trimUser
         includeEntities:(BOOL)includeEntities
{
    if(!message)
    {
        return nil;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:message forKey:@"status"];
    if(replyToId > 0)
    {
        [params setObject:[NSString stringWithFormat:@"%qu", replyToId] forKey:@"in_reply_to_status_id"];
    }
    if(-90.0f <= latitude <= 90.0f)
    {
        [params setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"lat"];
    }
    if(-180.0f <= longitude <= 180.0f)
    {
        [params setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"long"];
    }
    if(placeId > 0)
    {
        [params setObject:[NSString stringWithFormat:@"%qu", placeId] forKey:@"place_id"];
    }
    [params setObject:[NSString stringWithFormat:@"%d", displayCoord ? 1:0] forKey:@"display_coordinates"];
    [params addEntriesFromDictionary:[self trimUser:trimUser includeEntities:includeEntities]];
    return params;
}

@end
