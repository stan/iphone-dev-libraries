//
//  CDataScanner_UnitTests.m
//  TouchCode
//
//  Created by Jonathan Wight on 04/16/08.
//  Copyright (c) 2008 Jonathan Wight
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "CDataScanner_UnitTests.h"

#import "CDataScanner.h"
#import "CDataScanner_Extensions.h"

@implementation CDataScanner_UnitTests

- (void)testSomething
{
CDataScanner *theScanner = [CDataScanner scannerWithData:[@"Hello World" dataUsingEncoding:NSUTF8StringEncoding]];

STAssertFalse(theScanner.isAtEnd, NULL);

NSString *theString = NULL;
BOOL theResult = 

theResult = [theScanner scanString:@"Hello" intoString:&theString];
STAssertTrue(theResult, NULL);
STAssertEqualObjects(theString, @"Hello", NULL);
STAssertEquals(theScanner.scanLocation, 5U, NULL);

theResult = [theScanner scanCharacter:' '];
STAssertTrue(theResult, NULL);
STAssertEquals(theScanner.scanLocation, 6U, NULL);

theResult = [theScanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet] intoString:&theString];
STAssertTrue(theResult, NULL);
STAssertEqualObjects(theString, @"World", NULL);
STAssertEquals(theScanner.scanLocation, 11U, NULL);


STAssertTrue(theScanner.isAtEnd, NULL);

}

@end
