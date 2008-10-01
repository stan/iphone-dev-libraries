/* Copyright (c) 2008 Louis Gerbarg

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

*/

#include <libxml/xmlmemory.h>
#import <Foundation/Foundation.h>

// There are some slight differences from NSXMLParser
// There is no parse method, it begins parsing as soon as you hand it data
// There no other initializers, just init
// You must call finish when you are done pushing data into LGXMLParser;

@interface LGXMLParser : NSObject {
	id delegate;
	xmlParserCtxtPtr ctxt;
}

// These are unique to LGXMLParser.

//Take a block of data, and incrementally parses it
//This should be called repeatedly with sequential blcoks
- (void) parseData:(NSData *)data;

//Call this once there is no more data (connection closes, EOF, etc)
// parserDidEndDocument: cannot fire unless this is called
- (void) finish;


@property (assign, nonatomic) id delegate;



//Unsupported features, these all throw

- (void)setShouldProcessNamespaces:(BOOL)shouldProcessNamespaces;
- (void)setShouldReportNamespacePrefixes:(BOOL)shouldReportNamespacePrefixes;
- (void)setShouldResolveExternalEntities:(BOOL)shouldResolveExternalEntities;


@end


@interface LGXMLParser (LGXMLParserLocatorAdditions)
// Compatible functions
- (NSInteger)lineNumber;
- (NSInteger)columnNumber;

//Unsupported, these all throw
- (NSString *)publicID;
- (NSString *)systemID;
@end
