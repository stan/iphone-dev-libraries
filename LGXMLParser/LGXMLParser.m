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

#import "LGXMLParser.h"

static xmlSAXHandlerPtr emptySAXHandler;

#pragma mark -
#pragma mark Private properties

@interface LGXMLParser ()
@property (readonly, nonatomic) xmlParserCtxtPtr ctxt;
@end

#pragma mark -

@implementation LGXMLParser

@synthesize delegate;
@synthesize ctxt;

//No init method, we create are data structures as we need them

#pragma mark -
#pragma mark Init and Teardown

- (void) dealloc {
	xmlFreeParserCtxt(ctxt);
	self.delegate = nil;

	[super dealloc];
}

#pragma mark -
#pragma mark Custom accessors

- (xmlParserCtxtPtr) ctxt {
	if (!ctxt) {
		ctxt = xmlCreatePushParserCtxt(emptySAXHandler, self, NULL, 0, NULL);
	}

	return ctxt;
}

#pragma mark -
#pragma mark Data pumping methods

- (void) parseData:(NSData *)data {
	xmlParseChunk(self.ctxt, [data bytes], [data length], 0);
}

- (void) finish {
	xmlParseChunk(self.ctxt, 0, 0, 1);
}

#pragma mark -
#pragma mark NSXMLParser compatibility methods

- (NSInteger) lineNumber {
        return xmlSAX2GetLineNumber(self.ctxt);
}

- (NSInteger) columnNumber {
	return xmlSAX2GetColumnNumber(self.ctxt);
}

#pragma mark -
#pragma mark NSXMLParser compatibility methods (NOT IMPLEMENTED)

- (NSString *)publicID {
	@throw [NSException exceptionWithName:@"LGXMLParserNotImplemented" reason:@"publicID is not implemented" userInfo:nil];
}

- (NSString *)systemID {
	@throw [NSException exceptionWithName:@"LGXMLParserNotImplemented" reason:@"systemID is not implemented" userInfo:nil];
}

- (void)setShouldProcessNamespaces:(BOOL)shouldProcessNamespaces {
	@throw [NSException exceptionWithName:@"LGXMLParserNotImplemented" reason:@"setShouldProcessNamespaces: is not implemented" userInfo:nil];
}

- (void)setShouldReportNamespacePrefixes:(BOOL)shouldReportNamespacePrefixes {
	@throw [NSException exceptionWithName:@"LGXMLParserNotImplemented" reason:@"setShouldReportNamespacePrefixes: is not implemented" userInfo:nil];

}
- (void)setShouldResolveExternalEntities:(BOOL)shouldResolveExternalEntities {
	@throw [NSException exceptionWithName:@"LGXMLParserNotImplemented" reason:@"setShouldResolveExternalEntities: is not implemented" userInfo:nil];
}

@end

#pragma mark -
#pragma mark libxml2 callbacks (delegation)

//In every one of these we basically check to see if the delegate responds, then marshal the data

static void
startElement2(void *ctx, const xmlChar *name, const xmlChar **atts) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parser:didStartElement:namespaceURI:qualifiedName:attributes:)]) {
		NSMutableDictionary *returnAttributes = nil;
		NSUInteger i = 0;

		//We need to walk through the attributes and make a dictionary out of them
		if (atts) {
			returnAttributes = [NSMutableDictionary dictionary];
			for(i = 0; atts[i] != NULL && atts[i+1] != NULL; i+=2) {
				[returnAttributes setObject:[NSString stringWithUTF8String:(char *)atts[i+1]] forKey:[NSString stringWithUTF8String:(char *)atts[i]]];
			}
		}

		[self.delegate parser:(NSXMLParser *)self didStartElement:[NSString stringWithUTF8String:(const char *)name] namespaceURI:nil qualifiedName:nil attributes:returnAttributes];
	}
}

static void
endElement2(void *ctx, const xmlChar *name) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parser:didEndElement:namespaceURI:qualifiedName:)]) {
		[self.delegate parser:(NSXMLParser *)self didEndElement:[NSString stringWithUTF8String:(const char *)name] namespaceURI:nil qualifiedName:nil];
	}
}

static void
startDocument2(void *ctx) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parserDidStartDocument:)]) {
		[self.delegate  parserDidStartDocument:(NSXMLParser *)self];
	}
}

static void
endDocument2(void *ctx) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parserDidEndDocument:)]) {
		[self.delegate  parserDidEndDocument:(NSXMLParser *)self];
	}
}

static void
characters2(void *ctx ATTRIBUTE_UNUSED, const xmlChar *ch, int len) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parser:foundCharacters:)]) {
		NSString *characters = [[[NSString alloc] initWithBytes:(const void *)ch length:len encoding:NSUTF8StringEncoding] autorelease];;
		[self.delegate parser:(NSXMLParser *)self foundCharacters:characters];
	}
}


//We could do better error handling if we needed it
static void
xmlParserErrors2(void *ctx, const char *msg,  ...) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parser:parseErrorOccurred:)]) {
		//FIXME this should be better, but on the phone this is mainly a debugging niceity
		NSError *error = [NSError errorWithDomain:@"LGXMLParser" code:0 userInfo:nil];
		[self.delegate parser:(NSXMLParser *)self parseErrorOccurred:error];
	}
}

static void
ignorableWhitespace2 (void *ctx, const xmlChar *ch, int len) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parser:foundIgnorableWhitespace:)]) {
		NSString *characters = [[[NSString alloc] initWithBytes:(const void *)ch length:len encoding:NSUTF8StringEncoding] autorelease];
		[self.delegate parser:(NSXMLParser *)self foundIgnorableWhitespace:characters];
	}
}

static void
comment2  (void *ctx, const xmlChar *value) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parser:foundComment:)]) {
		NSString *characters = [[[NSString alloc] initWithBytes:value length:strlen((const char *)value) encoding:NSUTF8StringEncoding] autorelease];
		[self.delegate parser:(NSXMLParser *)self foundComment:characters];
	}
}

static void
cdataBlock2  (void *ctx, const xmlChar *value, int len) {
	LGXMLParser *self = (LGXMLParser *)ctx;

	if ([self.delegate respondsToSelector:@selector(parser:foundCDATA:)]) {
		NSData *data = [[[NSData alloc] initWithBytes:(const void *)value length:len] autorelease];
		[self.delegate parser:(NSXMLParser *)self foundCDATA:data];
	}
}


static xmlSAXHandler emptySAXHandlerStruct = {
NULL, /* internalSubset */
NULL, /* isStandalone */
NULL, /* hasInternalSubset */
NULL, /* hasExternalSubset */
NULL, /* resolveEntity */
NULL, /* getEntity */
NULL, /* entityDecl */
NULL, /* notationDecl */
NULL, /* attributeDecl */
NULL, /* elementDecl */
NULL, /* unparsedEntityDecl */
NULL, /* setDocumentLocator */
NULL, /* startDocument */
endDocument2, /* endDocument */
startElement2, /* startElement */
endElement2, /* endElement */
NULL, /* reference */
characters2, /* characters */
ignorableWhitespace2, /* ignorableWhitespace */
NULL, /* processingInstruction */
comment2, /* comment */
xmlParserErrors2, /* xmlParserWarning */
xmlParserErrors2, /* xmlParserError */
xmlParserErrors2, /* xmlParserError */
NULL, /* getParameterEntity */
NULL, /* cdataBlock; */
NULL, /* externalSubset; */
1,
NULL,
NULL, /* startElementNs */
NULL, /* endElementNs */
NULL  /* xmlStructuredErrorFunc */
};

static xmlSAXHandlerPtr emptySAXHandler = &emptySAXHandlerStruct;
