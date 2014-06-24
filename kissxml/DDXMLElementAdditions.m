#import "DDXMLElementAdditions.h"

@implementation DDXMLElement (XMPPStreamAdditions)

/**
 * This method returns the first child element for the given name (as an RHXMLElement).
 * If no child elements exist for the given name, nil is returned.
**/
- (DDXMLElement *)elementForName:(NSString *)name
{
	NSArray *elements = [self elementsForName:name];
	if([elements count] > 0)
	{
		return [elements objectAtIndex:0];
	}
	else
	{
		// There is a bug in the NSXMLElement elementsForName: method.
		// Consider the following XML fragment:
		//
		// <query xmlns="jabber:iq:private">
		//   <x xmlns="some:other:namespace"></x>
		// </query>
		//
		// Calling [query elementsForName:@"x"] results in an empty array!
		//
		// However, it will work properly if you use the following:
		// [query elementsForLocalName:@"x" URI:@"some:other:namespace"]
		//
		// The trouble with this is that we may not always know the xmlns in advance,
		// so in this particular case there is no way to access the element without looping through the children.
		//
		// This bug was submitted to apple on June 1st, 2007 and was classified as "serious".

		return nil;
	}
}

/**
 * This method returns the first child element for the given name and given xmlns (as an DDXMLElement).
 * If no child elements exist for the given name and given xmlns, nil is returned.
**/
- (DDXMLElement *)elementForName:(NSString *)name xmlns:(NSString *)xmlns
{
	NSLog(@"elementForName:%@ xmlns:%@", name, xmlns);

	NSArray *elements = [self elementsForLocalName:name URI:xmlns];
	if([elements count] > 0)
	{
		return [elements objectAtIndex:0];
	}
	else
	{
		return nil;
	}
}

/**
 * Returns the common xmlns "attribute", which is only accessible via the namespace methods.
 * The xmlns value is often used in jabber elements.
**/
- (NSString *)xmlns
{
	return [[self namespaceForPrefix:@""] stringValue];
}

/**
 *	Shortcut to avoid having to use RHXMLNode everytime
**/

- (void)addAttributeWithName:(NSString *)name stringValue:(NSString *)string
{
	[self addAttribute:[DDXMLNode attributeWithName:name stringValue:string]];
}

/**
 * Returns all the attributes in a dictionary.
**/
- (NSDictionary *)attributesAsDictionary
{
	NSArray *attributes = [self attributes];
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:[attributes count]];

	int i;
	for(i = 0; i < [attributes count]; i++)
	{
		DDXMLNode *node = [attributes objectAtIndex:i];

		[result setObject:[node stringValue] forKey:[node name]];
	}
	return result;
}

@end
