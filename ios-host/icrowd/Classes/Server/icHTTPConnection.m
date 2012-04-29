#import "icHTTPConnection.h"
#import "icDataManager.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "DDNumber.h"
#import "HTTPLogging.h"
#import "NSString+URLUtils.h"
#import "icUser.h"
#import "icGrain.h"

// Log levels : off, error, warn, info, verbose
// Other flags: trace
static const int httpLogLevel = HTTP_LOG_LEVEL_WARN; // | HTTP_LOG_FLAG_TRACE;


/**
 * All we have to do is override appropriate methods in HTTPConnection.
**/

@implementation icHTTPConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
	// Add support for POST	
	if ([method isEqualToString:@"POST"])
	{
		if ([path isEqualToString:@"/hello"])
		{
			// Let's be extra cautious, and make sure the upload isn't 5 gigs
//            omLogDev(@"will accept payload of size %i",requestContentLength);
			return requestContentLength < 50;
		}
		if ([path isEqualToString:@"/grain"])
		{
			// Let's be extra cautious, and make sure the upload isn't 5 gigs
//            omLogDev(@"will accept payload of size %i",requestContentLength);
			return requestContentLength < 50;
		}
	}	
	return [super supportsMethod:method atPath:path];
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{	
	// Inform HTTP server that we expect a body to accompany a POST request
	
	if([method isEqualToString:@"POST"])
		return YES;

//    omLogDev(@"expects request body from method %@ at path %@", method, path);
	
	return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    
#pragma mark HTTP request handler for HELLO NEW USER
    /**
     *  HELLO NEW USER
     */
	if ([method isEqualToString:@"POST"] && [path isEqualToString:@"/hello"])
	{
		NSData *postData = [request body];
		NSString *postStr = nil;
        NSDictionary *postParameters;
        NSData *response = nil;
        
		if (postData)
			postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
		
        postParameters = [postStr URLQueryParameters];            
        
        NSString * userName = (NSString *) [postParameters objectForKey:@"n"];
        NSNumber * userAge = [[NSNumber alloc] initWithInt: [[postParameters objectForKey:@"a"] intValue]];
        NSNumber * userGender = [[NSNumber alloc] initWithInt: [[postParameters objectForKey:@"g"] intValue]];
        
        icUser * user = [[icDataManager singleton] userCreateWithName:userName andAge:userAge andGender:userGender];
        
        response = [[[NSString alloc] initWithFormat:@"{\"user\":{\"idx\":\"%@\",\"name\":\"%@\",\"age\":\"%@\",\"gender\":\"%@\"}}",user.idx,user.name,user.age,user.gender] dataUsingEncoding:NSUTF8StringEncoding];
        
		omLogDev(@"HELLO NEW user:{idx:\"%@\",name:\"%@\",age:\"%@\",gender:\"%@\"}",user.idx,user.name,user.age,user.gender);

		return [[HTTPDataResponse alloc] initWithData:response];        
	}  	
    
#pragma mark HTTP request handler for POST a GRAIN        
    /*
     *  POST a GRAIN
     */
	if ([method isEqualToString:@"POST"] && [path isEqualToString:@"/grain"])
	{
		NSData *postData = [request body];
		NSString *postStr = nil;
        NSDictionary *postParameters;
        NSData *response = nil;
        
		if (postData)
			postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
		
        postParameters = [postStr URLQueryParameters];            
        
        NSNumber * grainUserIdx = [[NSNumber alloc] initWithInt: [[postParameters objectForKey:@"u"] intValue]];
        NSNumber * grainFeeling = [[NSNumber alloc] initWithFloat: [[postParameters objectForKey:@"f"] floatValue]];
        NSNumber * grainIntensity = [[NSNumber alloc] initWithFloat: [[postParameters objectForKey:@"i"] floatValue]];
        
        icGrain * grain = [[icDataManager singleton] grainCreateForUserId:grainUserIdx andFeeling:grainFeeling andIntensity:grainIntensity];
        
        if (grain!=nil) {
            response = [[[NSString alloc] initWithFormat:@"OK",requestContentLength] dataUsingEncoding:NSUTF8StringEncoding];
            omLogDev(@"SAVED grain:{userId:\"%@\",feeling:\"%@\",intensity:\"%@\",date:\"%@\"}",grainUserIdx,grain.feeling,grain.intensity,grain.date);            
        }else{
            response = [[[NSString alloc] initWithFormat:@"FAIL",requestContentLength] dataUsingEncoding:NSUTF8StringEncoding];
            omLogDev(@"FAILED to save grain:{userId:\"%@\",feeling:\"%@\",intensity:\"%@\"}",grainUserIdx,grainFeeling,grainIntensity);
        }
        
		return [[HTTPDataResponse alloc] initWithData:response];
	}
    
#pragma mark HTTP request handler for a file path from the Web folder      
	/**
     *  request a file path from the Web folder
     */
	return [super httpResponseForMethod:method URI:path];
}

- (void)prepareForBodyWithSize:(UInt64)contentLength
{
	HTTPLogTrace();
	
	// If we supported large uploads,
	// we might use this method to create/open files, allocate memory, etc.
}

- (void)processBodyData:(NSData *)postDataChunk
{
	HTTPLogTrace();
	
	// Remember: In order to support LARGE POST uploads, the data is read in chunks.
	// This prevents a 50 MB upload from being stored in RAM.
	// The size of the chunks are limited by the POST_CHUNKSIZE definition.
	// Therefore, this method may be called multiple times for the same POST request.
	
	BOOL result = [request appendData:postDataChunk];
	if (!result)
	{
		omLogDev(@"%@[%p]: %@ - Couldn't append bytes!", THIS_FILE, self, THIS_METHOD);
	}
}

@end
