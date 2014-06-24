#import "DDXMLTesting.h"
#import "DDXML.h"

@interface DDXMLTesting (Tests)
+ (void)setUp;
+ (void)tearDown;
+ (void)testLocalName;
+ (void)testPrefixName;
+ (void)testDoubleAdd;
+ (void)testNsGeneral;
+ (void)testNsLevel;
+ (void)testNsURI;
+ (void)testAttrGeneral;
+ (void)testAttrSiblings;
+ (void)testAttrDocOrder;
+ (void)testAttrChildren;
+ (void)testString;
+ (void)testPreviousNextNode;
+ (void)testPrefix;
+ (void)testURI;
+ (void)testXmlns;
@end

@implementation DDXMLTesting

+ (void)performTests
{
	[self setUp];

	[self testLocalName];
	[self testPrefixName];
	[self testDoubleAdd];
	[self testNsGeneral];
	[self testNsLevel];
	[self testNsURI];
	[self testAttrGeneral];
	[self testAttrSiblings];
	[self testAttrDocOrder];
	[self testAttrChildren];
	[self testString];
	[self testPreviousNextNode];
	[self testPrefix];
	[self testURI];
	[self testXmlns];

	[self tearDown];
}

+ (void)setUp
{
	// Reserved for future use
}

+ (void)tearDown
{
	// Reserved for future use
}

+ (void)testLocalName
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	NSString *nsTest1 = [NSXMLNode localNameForName:@"a:quack"];
	NSString *ddTest1 = [DDXMLNode localNameForName:@"a:quack"];

	NSAssert([nsTest1 isEqualToString:ddTest1], @"Failed test 1");

	NSString *nsTest2 = [NSXMLNode localNameForName:@"a:a:quack"];
	NSString *ddTest2 = [DDXMLNode localNameForName:@"a:a:quack"];

	NSAssert([nsTest2 isEqualToString:ddTest2], @"Failed test 2");

	NSString *nsTest3 = [NSXMLNode localNameForName:@"quack"];
	NSString *ddTest3 = [DDXMLNode localNameForName:@"quack"];

	NSAssert([nsTest3 isEqualToString:ddTest3], @"Failed test 3");

	NSString *nsTest4 = [NSXMLNode localNameForName:@"a:"];
	NSString *ddTest4 = [DDXMLNode localNameForName:@"a:"];

	NSAssert([nsTest4 isEqualToString:ddTest4], @"Failed test 4");

	NSString *nsTest5 = [NSXMLNode localNameForName:nil];
	NSString *ddTest5 = [DDXMLNode localNameForName:nil];

	NSAssert(!nsTest5 && !ddTest5, @"Failed test 5");

	NSXMLNode *nsNode = [NSXMLNode namespaceWithName:@"tucker" stringValue:@"dog"];
	DDXMLNode *ddNode = [DDXMLNode namespaceWithName:@"tucker" stringValue:@"dog"];

	NSString *nsTest6 = [nsNode localName];
	NSString *ddTest6 = [ddNode localName];

	NSAssert([nsTest6 isEqualToString:ddTest6], @"Failed test 6");
}

+ (void)testPrefixName
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	NSString *nsTest1 = [NSXMLNode prefixForName:@"a:quack"];
	NSString *ddTest1 = [DDXMLNode prefixForName:@"a:quack"];

	NSAssert([nsTest1 isEqualToString:ddTest1], @"Failed test 1");

	NSString *nsTest2 = [NSXMLNode prefixForName:@"a:a:quack"];
	NSString *ddTest2 = [DDXMLNode prefixForName:@"a:a:quack"];

	NSAssert([nsTest2 isEqualToString:ddTest2], @"Failed test 2");

	NSString *nsTest3 = [NSXMLNode prefixForName:@"quack"];
	NSString *ddTest3 = [DDXMLNode prefixForName:@"quack"];

	NSAssert([nsTest3 isEqualToString:ddTest3], @"Failed test 3");

	NSString *nsTest4 = [NSXMLNode prefixForName:@"a:"];
	NSString *ddTest4 = [DDXMLNode prefixForName:@"a:"];

	NSAssert([nsTest4 isEqualToString:ddTest4], @"Failed test 4");

	NSString *nsTest5 = [NSXMLNode prefixForName:nil];
	NSString *ddTest5 = [DDXMLNode prefixForName:nil];

	NSAssert([nsTest5 isEqualToString:ddTest5], @"Failed test 5");

	NSXMLNode *nsNode = [NSXMLNode namespaceWithName:@"tucker" stringValue:@"dog"];
	DDXMLNode *ddNode = [DDXMLNode namespaceWithName:@"tucker" stringValue:@"dog"];

	NSString *nsTest6 = [nsNode prefix];
	NSString *ddTest6 = [ddNode prefix];

	NSAssert([nsTest6 isEqualToString:ddTest6], @"Failed test 6");
}

+ (void)testDoubleAdd
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

//	NSXMLElement *nsRoot1 = [NSXMLElement elementWithName:@"root1"];
//	NSXMLElement *nsRoot2 = [NSXMLElement elementWithName:@"root2"];

//	NSXMLElement *nsNode = [NSXMLElement elementWithName:@"node"];
//	NSXMLNode *nsAttr = [NSXMLNode attributeWithName:@"key" stringValue:@"value"];
//	NSXMLNode *nsNs = [NSXMLNode namespaceWithName:@"a" stringValue:@"domain.com"];

//	[nsRoot1 addChild:nsAttr]; // Elements can only have text, elements, processing instructions, and comments as children
//	[nsRoot1 addAttribute:nsNode]; // Not an attribute
//	[nsRoot1 addNamespace:nsNode]; // Not a namespace

//	[nsRoot1 addChild:nsNode];
//	[nsRoot2 addChild:nsNode]; // Cannot add a child that has a parent; detach or copy first

//	[nsRoot1 addAttribute:nsAttr];
//	[nsRoot2 addAttribute:nsAttr]; // Cannot add an attribute with a parent; detach or copy first

//	[nsRoot1 addNamespace:nsNs];
//	[nsRoot2 addNamespace:nsNs]; // Cannot add a namespace with a parent; detach or copy first

//	DDXMLElement *ddRoot1 = [DDXMLElement elementWithName:@"root1"];
//	DDXMLElement *ddRoot2 = [DDXMLElement elementWithName:@"root2"];

//	DDXMLElement *ddNode = [DDXMLElement elementWithName:@"node"];
//	DDXMLNode *ddAttr = [DDXMLNode attributeWithName:@"key" stringValue:@"value"];
//	DDXMLNode *ddNs = [DDXMLNode namespaceWithName:@"a" stringValue:@"domain.com"];

//	[ddRoot1 addChild:ddAttr]; // Elements can only have text, elements, processing instructions, and comments as children
//	[ddRoot1 addAttribute:ddNode]; // Not an attribute
//	[ddRoot1 addNamespace:ddNode]; // Not a namespace

//	[ddRoot1 addChild:ddNode];
//	[ddRoot2 addChild:ddNode]; // Cannot add a child that has a parent; detach or copy first

//	[ddRoot1 addAttribute:ddAttr];
//	[ddRoot2 addAttribute:ddAttr]; // Cannot add an attribute with a parent; detach or copy first

//	[ddRoot1 addNamespace:ddNs];
//	[ddRoot2 addNamespace:ddNs]; // Cannot add a namespace with a parent; detach or copy first
}

+ (void)testNsGeneral
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	NSXMLNode *nsNs = [NSXMLNode namespaceWithName:@"a" stringValue:@"deusty.com"];
	DDXMLNode *ddNs = [DDXMLNode namespaceWithName:@"a" stringValue:@"deusty.com"];

	NSString *nsTest1 = [nsNs XMLString];
	NSString *ddTest1 = [ddNs XMLString];

	NSAssert([nsTest1 isEqualToString:ddTest1], @"Failed test 1");

	[nsNs setName:@"b"];
	[ddNs setName:@"b"];

	NSString *nsTest2 = [nsNs XMLString];
	NSString *ddTest2 = [ddNs XMLString];

	NSAssert([nsTest2 isEqualToString:ddTest2], @"Failed test 2");

	[nsNs setStringValue:@"robbiehanson.com"];
	[ddNs setStringValue:@"robbiehanson.com"];

	NSString *nsTest3 = [nsNs XMLString];
	NSString *ddTest3 = [ddNs XMLString];

	NSAssert([nsTest3 isEqualToString:ddTest3], @"Failed test 3");
}

+ (void)testNsLevel
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	// <root xmlns:a="apple.com">
	//   <node xmlns:d="deusty.com" xmlns:rh="robbiehanson.com"/>
	// </root>

	NSXMLElement *nsRoot = [NSXMLElement elementWithName:@"root"];
	NSXMLElement *nsNode = [NSXMLElement elementWithName:@"node"];
	NSXMLNode *nsNs0 = [NSXMLNode namespaceWithName:@"a" stringValue:@"apple.com"];
	NSXMLNode *nsNs1 = [NSXMLNode namespaceWithName:@"d" stringValue:@"deusty.com"];
	NSXMLNode *nsNs2 = [NSXMLNode namespaceWithName:@"rh" stringValue:@"robbiehanson.com"];
	[nsNode addNamespace:nsNs1];
	[nsNode addNamespace:nsNs2];
	[nsRoot addNamespace:nsNs0];
	[nsRoot addChild:nsNode];

	DDXMLElement *ddRoot = [DDXMLElement elementWithName:@"root"];
	DDXMLElement *ddNode = [DDXMLElement elementWithName:@"node"];
	DDXMLNode *ddNs0 = [DDXMLNode namespaceWithName:@"a" stringValue:@"apple.com"];
	DDXMLNode *ddNs1 = [DDXMLNode namespaceWithName:@"d" stringValue:@"deusty.com"];
	DDXMLNode *ddNs2 = [DDXMLNode namespaceWithName:@"rh" stringValue:@"robbiehanson.com"];
	[ddNode addNamespace:ddNs1];
	[ddNode addNamespace:ddNs2];
	[ddRoot addNamespace:ddNs0];
	[ddRoot addChild:ddNode];

	NSAssert([nsNs0 index] == [ddNs0 index], @"Failed test 1");
	NSAssert([nsNs1 index] == [ddNs1 index], @"Failed test 2");
	NSAssert([nsNs2 index] == [ddNs2 index], @"Failed test 3");

	NSAssert([nsNs0 level] == [ddNs0 level], @"Failed test 4");
	NSAssert([nsNs1 level] == [ddNs1 level], @"Failed test 5");
	NSAssert([nsNs2 level] == [ddNs2 level], @"Failed test 6");
}

+ (void)testNsURI
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	NSXMLElement *nsNode = [NSXMLElement elementWithName:@"duck" URI:@"quack.com"];
	DDXMLElement *ddNode = [DDXMLElement elementWithName:@"duck" URI:@"quack.com"];

	NSString *nsTest1 = [nsNode URI];
	NSString *ddTest1 = [ddNode URI];

	NSAssert([nsTest1 isEqualToString:ddTest1], @"Failed test 1");

	NSXMLElement *nsAttr = [NSXMLElement attributeWithName:@"duck" URI:@"quack.com" stringValue:@"quack"];
	DDXMLElement *ddAttr = [DDXMLElement attributeWithName:@"duck" URI:@"quack.com" stringValue:@"quack"];

	NSString *nsTest2 = [nsAttr URI];
	NSString *ddTest2 = [ddAttr URI];

	NSAssert([nsTest2 isEqualToString:ddTest2], @"Failed test 2");
}

+ (void)testAttrGeneral
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	NSXMLNode *nsAttr = [NSXMLNode attributeWithName:@"apple" stringValue:@"inc"];
	DDXMLNode *ddAttr = [DDXMLNode attributeWithName:@"apple" stringValue:@"inc"];

	NSString *nsStr1 = [nsAttr XMLString];
	NSString *ddStr1 = [ddAttr XMLString];

	NSAssert([nsStr1 isEqualToString:ddStr1], @"Failed test 1");

	[nsAttr setName:@"deusty"];
	[ddAttr setName:@"deusty"];

	NSString *nsStr2 = [nsAttr XMLString];
	NSString *ddStr2 = [ddAttr XMLString];

	NSAssert([nsStr2 isEqualToString:ddStr2], @"Failed test 2");

	[nsAttr setStringValue:@"designs"];
	[ddAttr setStringValue:@"designs"];

	NSString *nsStr3 = [nsAttr XMLString];
	NSString *ddStr3 = [ddAttr XMLString];

	NSAssert([nsStr3 isEqualToString:ddStr3], @"Failed test 3");
}

+ (void)testAttrSiblings
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	// <duck sound="quack" swims="YES" flys="YES"/>

	NSXMLElement *nsNode = [NSXMLElement elementWithName:@"duck"];
	[nsNode addAttribute:[NSXMLNode attributeWithName:@"sound" stringValue:@"quack"]];
	[nsNode addAttribute:[NSXMLNode attributeWithName:@"swims" stringValue:@"YES"]];
	[nsNode addAttribute:[NSXMLNode attributeWithName:@"flys" stringValue:@"YES"]];

	DDXMLElement *ddNode = [DDXMLElement elementWithName:@"duck"];
	[ddNode addAttribute:[DDXMLNode attributeWithName:@"sound" stringValue:@"quack"]];
	[ddNode addAttribute:[DDXMLNode attributeWithName:@"swims" stringValue:@"YES"]];
	[ddNode addAttribute:[DDXMLNode attributeWithName:@"flys" stringValue:@"YES"]];

	NSXMLNode *nsAttr = [nsNode attributeForName:@"swims"];
	DDXMLNode *ddAttr = [ddNode attributeForName:@"swims"];

	NSString *nsTest1 = [nsAttr XMLString];
	NSString *ddTest1 = [ddAttr XMLString];

	NSAssert([nsTest1 isEqualToString:ddTest1], @"Failed test 1");

//	NSLog(@"nsAttr prev: %@", [[nsAttr previousSibling] XMLString]);
//	NSLog(@"nsAttr next: %@", [[nsAttr nextSibling] XMLString]);
//
//	NSLog(@"ddAttr prev: %@", [[ddAttr previousSibling] XMLString]);
//	NSLog(@"ddAttr next: %@", [[ddAttr nextSibling] XMLString]);
//
//	Analysis: Ours works and theirs doesn't.  I see no need to cripple ours because of that.
}

+ (void)testAttrDocOrder
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	// <duck sound="quack" swims="YES" flys="YES"/>

	NSXMLElement *nsNode = [NSXMLElement elementWithName:@"duck"];
	[nsNode addAttribute:[NSXMLNode attributeWithName:@"sound" stringValue:@"quack"]];
	[nsNode addAttribute:[NSXMLNode attributeWithName:@"swims" stringValue:@"YES"]];
	[nsNode addAttribute:[NSXMLNode attributeWithName:@"flys" stringValue:@"YES"]];

	DDXMLElement *ddNode = [DDXMLElement elementWithName:@"duck"];
	[ddNode addAttribute:[DDXMLNode attributeWithName:@"sound" stringValue:@"quack"]];
	[ddNode addAttribute:[DDXMLNode attributeWithName:@"swims" stringValue:@"YES"]];
	[ddNode addAttribute:[DDXMLNode attributeWithName:@"flys" stringValue:@"YES"]];

	NSXMLNode *nsAttr = [nsNode attributeForName:@"swims"];
	DDXMLNode *ddAttr = [ddNode attributeForName:@"swims"];

	NSXMLNode *nsTest1 = [nsAttr previousNode];
	DDXMLNode *ddTest1 = [ddAttr previousNode];

	NSAssert((!nsTest1 && !ddTest1), @"Failed test 1");

	NSXMLNode *nsTest2 = [nsAttr nextNode];
	DDXMLNode *ddTest2 = [ddAttr nextNode];

	NSAssert((!nsTest2 && !ddTest2), @"Failed test 2");

	// Notes: Attributes play no part in the document order.
}

+ (void)testAttrChildren
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	NSXMLNode *nsAttr1 = [NSXMLNode attributeWithName:@"deusty" stringValue:@"designs"];
	DDXMLNode *ddAttr1 = [DDXMLNode attributeWithName:@"deusty" stringValue:@"designs"];

	NSXMLNode *nsTest1 = [nsAttr1 childAtIndex:0];
	DDXMLNode *ddTest1 = [ddAttr1 childAtIndex:0];

	NSAssert((!nsTest1 && !ddTest1), @"Failed test 1");

	NSUInteger nsTest2 = [nsAttr1 childCount];
	NSUInteger ddTest2 = [ddAttr1 childCount];

	NSAssert((nsTest2 == ddTest2), @"Failed test 2");

	NSArray *nsTest3 = [nsAttr1 children];
	NSArray *ddTest3 = [ddAttr1 children];

	NSAssert((!nsTest3 && !ddTest3), @"Failed test 3");

	// Notes: Attributes aren't supposed to have children, although in libxml they technically do.
	// The child is simply a pointer to a text node, which contains the attribute value.
}

+ (void)testString
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	// <pizza>
	//   <toppings>
	//     <pepperoni/>
	//     <sausage>
	//       <mild/>
	//       <spicy/>
	//     </sausage>
	//   </toppings>
	//   <crust>
	//     <thin/>
	//     <thick/>
	//   </crust>
	// </pizza>

	NSXMLElement *nsNode0 = [NSXMLElement elementWithName:@"pizza"];
	NSXMLElement *nsNode1 = [NSXMLElement elementWithName:@"toppings"];
	NSXMLElement *nsNode2 = [NSXMLElement elementWithName:@"pepperoni"];
	NSXMLElement *nsNode3 = [NSXMLElement elementWithName:@"sausage"];
	NSXMLElement *nsNode4 = [NSXMLElement elementWithName:@"mild"];
	NSXMLElement *nsNode5 = [NSXMLElement elementWithName:@"spicy"];
	NSXMLElement *nsNode6 = [NSXMLElement elementWithName:@"crust"];
	NSXMLElement *nsNode7 = [NSXMLElement elementWithName:@"thin"];
	NSXMLElement *nsNode8 = [NSXMLElement elementWithName:@"thick"];

	[nsNode0 addChild:nsNode1];
	[nsNode0 addChild:nsNode6];
	[nsNode1 addChild:nsNode2];
	[nsNode1 addChild:nsNode3];
	[nsNode3 addChild:nsNode4];
	[nsNode3 addChild:nsNode5];
	[nsNode6 addChild:nsNode7];
	[nsNode6 addChild:nsNode8];

	DDXMLElement *ddNode0 = [DDXMLElement elementWithName:@"pizza"];
	DDXMLElement *ddNode1 = [DDXMLElement elementWithName:@"toppings"];
	DDXMLElement *ddNode2 = [DDXMLElement elementWithName:@"pepperoni"];
	DDXMLElement *ddNode3 = [DDXMLElement elementWithName:@"sausage"];
	DDXMLElement *ddNode4 = [DDXMLElement elementWithName:@"mild"];
	DDXMLElement *ddNode5 = [DDXMLElement elementWithName:@"spicy"];
	DDXMLElement *ddNode6 = [DDXMLElement elementWithName:@"crust"];
	DDXMLElement *ddNode7 = [DDXMLElement elementWithName:@"thin"];
	DDXMLElement *ddNode8 = [DDXMLElement elementWithName:@"thick"];

	[ddNode0 addChild:ddNode1];
	[ddNode0 addChild:ddNode6];
	[ddNode1 addChild:ddNode2];
	[ddNode1 addChild:ddNode3];
	[ddNode3 addChild:ddNode4];
	[ddNode3 addChild:ddNode5];
	[ddNode6 addChild:ddNode7];
	[ddNode6 addChild:ddNode8];

	NSXMLNode *nsAttr1 = [NSXMLNode attributeWithName:@"price" stringValue:@"1.00"];
	DDXMLNode *ddAttr1 = [DDXMLNode attributeWithName:@"price" stringValue:@"1.00"];

	[nsNode1 addAttribute:nsAttr1];
	[ddNode1 addAttribute:ddAttr1];

	[nsNode4 setStringValue:@"<just right>"];
	[ddNode4 setStringValue:@"<just right>"];

	[nsNode5 setStringValue:@"too hot"];
	[ddNode5 setStringValue:@"too hot"];

	NSString *nsTest1 = [nsNode0 stringValue];  // Returns "<just right>too hot"
	NSString *ddTest1 = [ddNode0 stringValue];

	NSAssert([nsTest1 isEqualToString:ddTest1], @"Failed test 1");

	NSString *nsTest2 = [nsAttr1 stringValue];  // Returns "1.00"
	NSString *ddTest2 = [ddAttr1 stringValue];

	NSAssert([nsTest2 isEqualToString:ddTest2], @"Failed test 2");

	[nsAttr1 setStringValue:@"1.25"];
	[ddAttr1 setStringValue:@"1.25"];

	NSString *nsTest3 = [nsAttr1 stringValue];  // Returns "1.25"
	NSString *ddTest3 = [ddAttr1 stringValue];

	NSAssert([nsTest3 isEqualToString:ddTest3], @"Failed test 3");

	[nsNode0 setStringValue:@"<wtf>ESCAPE</wtf>"];
	[ddNode0 setStringValue:@"<wtf>ESCAPE</wtf>"];

	NSString *nsTest4 = [nsNode0 stringValue];  // Returns "<wtf>ESCAPE</wtf>"
	NSString *ddTest4 = [ddNode0 stringValue];

	NSAssert([nsTest4 isEqualToString:ddTest4], @"Failed test 4");

//	NSString *nsTest5 = [nsNode0 XMLString];  // Returns "<pizza>&lt;wtf>ESCAPE&lt;/wtf></pizza>"
//	NSString *ddTest5 = [ddNode0 XMLString];  // Returns "<pizza>&lt;wtf&gt;ESCAPE&lt;/wtf&gt;</pizza>"
//
//	NSAssert([nsTest5 isEqualToString:ddTest5], @"Failed test 5");
//
//  The DDXML version is actually more accurate, so we'll accept the difference.
}

+ (void)testPreviousNextNode
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	// <pizza>
	//   <toppings>
	//     <pepperoni/>
	//     <sausage>
	//       <mild/>
	//       <spicy/>
	//     </sausage>
	//   </toppings>
	//   <crust>
	//     <thin/>
	//     <thick/>
	//   </crust>
	// </pizza>

	NSXMLElement *nsNode0 = [NSXMLElement elementWithName:@"pizza"];
	NSXMLElement *nsNode1 = [NSXMLElement elementWithName:@"toppings"];
	NSXMLElement *nsNode2 = [NSXMLElement elementWithName:@"pepperoni"];
	NSXMLElement *nsNode3 = [NSXMLElement elementWithName:@"sausage"];
	NSXMLElement *nsNode4 = [NSXMLElement elementWithName:@"mild"];
	NSXMLElement *nsNode5 = [NSXMLElement elementWithName:@"spicy"];
	NSXMLElement *nsNode6 = [NSXMLElement elementWithName:@"crust"];
	NSXMLElement *nsNode7 = [NSXMLElement elementWithName:@"thin"];
	NSXMLElement *nsNode8 = [NSXMLElement elementWithName:@"thick"];

	[nsNode0 addChild:nsNode1];
	[nsNode0 addChild:nsNode6];
	[nsNode1 addChild:nsNode2];
	[nsNode1 addChild:nsNode3];
	[nsNode3 addChild:nsNode4];
	[nsNode3 addChild:nsNode5];
	[nsNode6 addChild:nsNode7];
	[nsNode6 addChild:nsNode8];

	DDXMLElement *ddNode0 = [DDXMLElement elementWithName:@"pizza"];
	DDXMLElement *ddNode1 = [DDXMLElement elementWithName:@"toppings"];
	DDXMLElement *ddNode2 = [DDXMLElement elementWithName:@"pepperoni"];
	DDXMLElement *ddNode3 = [DDXMLElement elementWithName:@"sausage"];
	DDXMLElement *ddNode4 = [DDXMLElement elementWithName:@"mild"];
	DDXMLElement *ddNode5 = [DDXMLElement elementWithName:@"spicy"];
	DDXMLElement *ddNode6 = [DDXMLElement elementWithName:@"crust"];
	DDXMLElement *ddNode7 = [DDXMLElement elementWithName:@"thin"];
	DDXMLElement *ddNode8 = [DDXMLElement elementWithName:@"thick"];

	[ddNode0 addChild:ddNode1];
	[ddNode0 addChild:ddNode6];
	[ddNode1 addChild:ddNode2];
	[ddNode1 addChild:ddNode3];
	[ddNode3 addChild:ddNode4];
	[ddNode3 addChild:ddNode5];
	[ddNode6 addChild:ddNode7];
	[ddNode6 addChild:ddNode8];

	NSString *nsTest1 = [[nsNode2 nextNode] name];
	NSString *ddTest1 = [[ddNode2 nextNode] name];

	NSAssert2([nsTest1 isEqualToString:ddTest1], @"Failed test 1: ns(%@) dd(%@)", nsTest1, ddTest1);

	NSString *nsTest2 = [[nsNode3 nextNode] name];
	NSString *ddTest2 = [[ddNode3 nextNode] name];

	NSAssert2([nsTest2 isEqualToString:ddTest2], @"Failed test 2: ns(%@) dd(%@)", nsTest2, ddTest2);

	NSString *nsTest3 = [[nsNode5 nextNode] name];
	NSString *ddTest3 = [[ddNode5 nextNode] name];

	NSAssert2([nsTest3 isEqualToString:ddTest3], @"Failed test 3: ns(%@) dd(%@)", nsTest3, ddTest3);

	NSString *nsTest4 = [[nsNode5 previousNode] name];
	NSString *ddTest4 = [[ddNode5 previousNode] name];

	NSAssert2([nsTest4 isEqualToString:ddTest4], @"Failed test 4: ns(%@) dd(%@)", nsTest4, ddTest4);

	NSString *nsTest5 = [[nsNode6 previousNode] name];
	NSString *ddTest5 = [[ddNode6 previousNode] name];

	NSAssert2([nsTest5 isEqualToString:ddTest5], @"Failed test 5: ns(%@) dd(%@)", nsTest5, ddTest5);

	NSString *nsTest6 = [[nsNode8 nextNode] name];
	NSString *ddTest6 = [[ddNode8 nextNode] name];

	NSAssert2((!nsTest6 && !ddTest6), @"Failed test 6: ns(%@) dd(%@)", nsTest6, ddTest6);

	NSString *nsTest7 = [[nsNode0 previousNode] name];
	NSString *ddTest7 = [[ddNode0 previousNode] name];

	NSAssert2((!nsTest7 && !ddTest7), @"Failed test 7: ns(%@) dd(%@)", nsTest7, ddTest7);
}

+ (void)testPrefix
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	// <root xmlns:a="beagle" xmlns:b="lab">
	//   <dog/>
	//   <a:dog/>
	//   <a:b:dog/>
	//   <dog xmlns="beagle"/>
	// </root>

	NSXMLElement *nsNode1 = [NSXMLElement elementWithName:@"dog"];
	NSXMLElement *nsNode2 = [NSXMLElement elementWithName:@"a:dog"];
	NSXMLElement *nsNode3 = [NSXMLElement elementWithName:@"a:b:dog"];
	NSXMLElement *nsNode4 = [NSXMLElement elementWithName:@"dog" URI:@"beagle"];

	DDXMLElement *ddNode1 = [DDXMLElement elementWithName:@"dog"];
	DDXMLElement *ddNode2 = [DDXMLElement elementWithName:@"a:dog"];
	DDXMLElement *ddNode3 = [DDXMLElement elementWithName:@"a:b:dog"];
	DDXMLElement *ddNode4 = [DDXMLElement elementWithName:@"dog" URI:@"beagle"];

	NSString *nsTest1 = [nsNode1 prefix];
	NSString *ddTest1 = [ddNode1 prefix];

	NSAssert([nsTest1 isEqualToString:ddTest1], @"Failed test 1");

	NSString *nsTest2 = [nsNode2 prefix];
	NSString *ddTest2 = [ddNode2 prefix];

	NSAssert([nsTest2 isEqualToString:ddTest2], @"Failed test 2");

	NSString *nsTest3 = [nsNode3 prefix];
	NSString *ddTest3 = [ddNode3 prefix];

	NSAssert([nsTest3 isEqualToString:ddTest3], @"Failed test 3");

	NSString *nsTest4 = [nsNode4 prefix];
	NSString *ddTest4 = [ddNode4 prefix];

	NSAssert([nsTest4 isEqualToString:ddTest4], @"Failed test 4");
}

+ (void)testURI
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	// <root xmlns:a="deusty.com" xmlns:b="robbiehanson.com">
	//     <test test="1"/>
	//     <a:test test="2"/>
	//     <b:test test="3"/>
	//     <test xmlns="deusty.com" test="4"/>
	//     <test xmlns="quack.com" test="5"/>
	// </root>

	NSXMLElement *nsRoot = [NSXMLElement elementWithName:@"root"];
	[nsRoot addNamespace:[NSXMLNode namespaceWithName:@"a" stringValue:@"deusty.com"]];
	[nsRoot addNamespace:[NSXMLNode namespaceWithName:@"b" stringValue:@"robbiehanson.com"]];

	NSXMLElement *nsNode1 = [NSXMLElement elementWithName:@"test"];
	[nsNode1 addAttribute:[NSXMLNode attributeWithName:@"test" stringValue:@"1"]];

	NSXMLElement *nsNode2 = [NSXMLElement elementWithName:@"a:test"];
	[nsNode2 addAttribute:[NSXMLNode attributeWithName:@"test" stringValue:@"2"]];

	NSXMLElement *nsNode3 = [NSXMLElement elementWithName:@"b:test"];
	[nsNode3 addAttribute:[NSXMLNode attributeWithName:@"test" stringValue:@"3"]];

	NSXMLElement *nsNode4 = [NSXMLElement elementWithName:@"test" URI:@"deusty.com"];
	[nsNode4 addAttribute:[NSXMLNode attributeWithName:@"test" stringValue:@"4"]];

	NSXMLElement *nsNode5 = [NSXMLElement elementWithName:@"test" URI:@"quack.com"];
	[nsNode5 addAttribute:[NSXMLNode attributeWithName:@"test" stringValue:@"5"]];

	[nsRoot addChild:nsNode1];
	[nsRoot addChild:nsNode2];
	[nsRoot addChild:nsNode3];
	[nsRoot addChild:nsNode4];
	[nsRoot addChild:nsNode5];

	DDXMLElement *ddRoot = [DDXMLElement elementWithName:@"root"];
	[ddRoot addNamespace:[DDXMLNode namespaceWithName:@"a" stringValue:@"deusty.com"]];
	[ddRoot addNamespace:[DDXMLNode namespaceWithName:@"b" stringValue:@"robbiehanson.com"]];

	DDXMLElement *ddNode1 = [DDXMLElement elementWithName:@"test"];
	[ddNode1 addAttribute:[DDXMLNode attributeWithName:@"test" stringValue:@"1"]];

	DDXMLElement *ddNode2 = [DDXMLElement elementWithName:@"a:test"];
	[ddNode2 addAttribute:[DDXMLNode attributeWithName:@"test" stringValue:@"2"]];

	DDXMLElement *ddNode3 = [DDXMLElement elementWithName:@"b:test"];
	[ddNode3 addAttribute:[DDXMLNode attributeWithName:@"test" stringValue:@"3"]];

	DDXMLElement *ddNode4 = [DDXMLElement elementWithName:@"test" URI:@"deusty.com"];
	[ddNode4 addAttribute:[DDXMLNode attributeWithName:@"test" stringValue:@"4"]];

	DDXMLElement *ddNode5 = [DDXMLElement elementWithName:@"test" URI:@"quack.com"];
	[ddNode5 addAttribute:[DDXMLNode attributeWithName:@"test" stringValue:@"5"]];

	[ddRoot addChild:ddNode1];
	[ddRoot addChild:ddNode2];
	[ddRoot addChild:ddNode3];
	[ddRoot addChild:ddNode4];
	[ddRoot addChild:ddNode5];

	NSString *nsTest1 = [[nsNode1 resolveNamespaceForName:[nsNode1 name]] stringValue];
	NSString *ddTest1 = [[ddNode1 resolveNamespaceForName:[ddNode1 name]] stringValue];

	NSAssert(!nsTest1 && !ddTest1, @"Failed test 1");

	NSString *nsTest2 = [[nsNode2 resolveNamespaceForName:[nsNode2 name]] stringValue];
	NSString *ddTest2 = [[ddNode2 resolveNamespaceForName:[ddNode2 name]] stringValue];

	NSAssert2([nsTest2 isEqualToString:ddTest2], @"Failed test 2: ns(%@) dd(%@)", nsTest2, ddTest2);

	NSString *nsTest3 = [[nsNode3 resolveNamespaceForName:[nsNode3 name]] stringValue];
	NSString *ddTest3 = [[ddNode3 resolveNamespaceForName:[ddNode3 name]] stringValue];

	NSAssert([nsTest3 isEqualToString:ddTest3], @"Failed test 3");

	NSString *nsTest4 = [[nsNode4 resolveNamespaceForName:[nsNode4 name]] stringValue];
	NSString *ddTest4 = [[ddNode4 resolveNamespaceForName:[ddNode4 name]] stringValue];

	NSAssert2(!nsTest4 && !ddTest4, @"Failed test 4: ns(%@) dd(%@)", nsTest4, ddTest4);

	NSString *nsTest5 = [nsNode4 resolvePrefixForNamespaceURI:@"deusty.com"];
	NSString *ddTest5 = [ddNode4 resolvePrefixForNamespaceURI:@"deusty.com"];

	NSAssert2([nsTest5 isEqualToString:ddTest5], @"Failed test 5: ns(%@) dd(%@)", nsTest5, ddTest5);

	NSString *nsTest6 = [nsNode4 resolvePrefixForNamespaceURI:@"robbiehanson.com"];
	NSString *ddTest6 = [ddNode4 resolvePrefixForNamespaceURI:@"robbiehanson.com"];

	NSAssert([nsTest6 isEqualToString:ddTest6], @"Failed test 6");

	NSString *nsTest7 = [nsNode4 resolvePrefixForNamespaceURI:@"quack.com"];
	NSString *ddTest7 = [ddNode4 resolvePrefixForNamespaceURI:@"quack.com"];

	NSAssert(!nsTest7 && !ddTest7, @"Failed test 7");

	NSString *nsTest8 = [nsNode4 resolvePrefixForNamespaceURI:nil];
	NSString *ddTest8 = [ddNode4 resolvePrefixForNamespaceURI:nil];

	NSAssert(!nsTest8 && !ddTest8, @"Failed test 8");

	NSUInteger nsTest9  = [[nsRoot elementsForName:@"test"] count];  // Returns test1, test4, test5
	NSUInteger ddTest9  = [[ddRoot elementsForName:@"test"] count];  // Returns test1, test4, test5

	NSAssert(nsTest9 == ddTest9, @"Failed test 9");

	NSUInteger nsTest10 = [[nsRoot elementsForName:@"a:test"] count];  // Returns node2 and node4
	NSUInteger ddTest10 = [[ddRoot elementsForName:@"a:test"] count];  // Returns node2 and node4

	NSAssert(nsTest10 == ddTest10, @"Failed test 10");

	NSUInteger nsTest11 = [[nsRoot elementsForLocalName:@"test" URI:@"deusty.com"] count];  // Returns node2 and node4
	NSUInteger ddTest11 = [[ddRoot elementsForLocalName:@"test" URI:@"deusty.com"] count];  // Returns node2 and node4

	NSAssert(nsTest11 == ddTest11, @"Failed test 11");

	NSUInteger nsTest12 = [[nsRoot elementsForLocalName:@"a:test" URI:@"deusty.com"] count];  // Returns nothing
	NSUInteger ddTest12 = [[ddRoot elementsForLocalName:@"a:test" URI:@"deusty.com"] count];  // Returns nothing

	NSAssert(nsTest12 == ddTest12, @"Failed test 12");

	NSUInteger nsTest13 = [[nsRoot elementsForLocalName:@"test" URI:@"quack.com"] count];  // Returns node5
	NSUInteger ddTest13 = [[ddRoot elementsForLocalName:@"test" URI:@"quack.com"] count];  // Returns node5

	NSAssert(nsTest13 == ddTest13, @"Failed test 13");
}

+ (void)testXmlns
{
	NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

	NSString *parseMe = @"<query xmlns=\"jabber:iq:roster\"></query>";
	NSData *data = [parseMe dataUsingEncoding:NSUTF8StringEncoding];

	NSXMLDocument *nsDoc = [[NSXMLDocument alloc] initWithData:data options:0 error:nil];
	NSXMLElement *nsRootElement = [nsDoc rootElement];

	DDXMLDocument *ddDoc = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
	DDXMLElement *ddRootElement = [ddDoc rootElement];

	// Both URI and namespaceForPrefix:@"" should return "jabber:iq:roster"

	NSString *nsTest1 = [nsRootElement URI];
	NSString *ddTest1 = [ddRootElement URI];

	NSAssert([nsTest1 isEqualToString:ddTest1], @"Failed test 1");

	NSString *nsTest2 = [[nsRootElement namespaceForPrefix:@""] stringValue];
	NSString *ddTest2 = [[ddRootElement namespaceForPrefix:@""] stringValue];

	NSAssert([nsTest2 isEqualToString:ddTest2], @"Failed test 2");

	// In NSXML namespaceForPrefix:nil returns nil
	// In DDXML namespaceForPrefix:nil returns the same as namespaceForPrefix:@""
	//
	// This actually makes more sense, as many users would consider a prefix of nil or an empty string to be the same.
	// Plus many XML documents state that a prefix of nil or "" should be treated equally.
	//
	// This difference comes into play in other areas.
	//
	// In NSXML creating a namespace with prefix:nil doesn't work.
	// In DDXML creating a namespace with prefix:nil acts as if you had passed an empty string.

	NSUInteger nsTest3 = [[nsRootElement namespaces] count];
	NSUInteger ddTest3 = [[ddRootElement namespaces] count];

	NSAssert(nsTest3 == ddTest3, @"Failed test 3");

	// An odd quirk of NSXML is that if the data is parsed, then the namespaces array contains the default namespace.
	// However, if the XML tree is generated in code, and the default namespace was set via setting the URI,
	// then the namespaces array doesn't contain that default namespace.
	// If instead the addNamespace method is used to add the default namespace, then it is contained in the array,
	// and the URI is also properly set.
	//
	// I consider this to be a bug in NSXML.

	NSString *nsTest4 = [[nsRootElement resolveNamespaceForName:@""] stringValue];
	NSString *ddTest4 = [[ddRootElement resolveNamespaceForName:@""] stringValue];

	NSAssert([nsTest4 isEqualToString:ddTest4], @"Failed test 4");

	// Oddly enough, even though NSXML seems completely resistant to nil namespace prefixes, this works fine
	NSString *nsTest5 = [[nsRootElement resolveNamespaceForName:nil] stringValue];
	NSString *ddTest5 = [[ddRootElement resolveNamespaceForName:nil] stringValue];

	NSAssert([nsTest5 isEqualToString:ddTest5], @"Failed test 5");

	NSXMLElement *nsNode = [NSXMLElement elementWithName:@"query"];
	[nsNode addNamespace:[NSXMLNode namespaceWithName:@"" stringValue:@"jabber:iq:auth"]];

	DDXMLElement *ddNode = [DDXMLElement elementWithName:@"query"];
	[ddNode addNamespace:[DDXMLNode namespaceWithName:@"" stringValue:@"jabber:iq:auth"]];

	NSString *nsTest6 = [[nsNode resolveNamespaceForName:@""] stringValue];
	NSString *ddTest6 = [[ddNode resolveNamespaceForName:@""] stringValue];

	NSAssert([nsTest6 isEqualToString:ddTest6], @"Failed test 6");

	NSString *nsTest7 = [[nsNode resolveNamespaceForName:nil] stringValue];
	NSString *ddTest7 = [[ddNode resolveNamespaceForName:nil] stringValue];

	NSAssert([nsTest7 isEqualToString:ddTest7], @"Failed test 7");

	NSString *nsTest8 = [nsNode URI];
	NSString *ddTest8 = [ddNode URI];

	NSAssert([nsTest8 isEqualToString:ddTest8], @"Failed test 8");

	NSUInteger nsTest9 = [[nsNode namespaces] count];
	NSUInteger ddTest9 = [[ddNode namespaces] count];

	NSAssert(nsTest9 == ddTest9, @"Failed test 9");
}

@end
