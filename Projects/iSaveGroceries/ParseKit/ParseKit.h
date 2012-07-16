//  Copyright 2010 Todd Ditchendorf
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

/*!
    @mainpage   ParseKit
                ParseKit is a Mac OS X Framework written by Todd Ditchendorf in Objective-C 2.0 and released under the MIT Open Source License.
				The framework is an Objective-C implementation of the tools described in <a href="http://www.amazon.com/Building-Parsers-Java-Steven-Metsker/dp/0201719622" title="Amazon.com: Building Parsers With Java(TM): Steven John Metsker: Books">"Building Parsers with Java" by Steven John Metsker</a>. 
				ParseKit includes some significant additions beyond the designs from the book (many of them hinted at in the book itself) in order to enhance the framework's feature set, usefulness and ease-of-use. Other changes have been made to the designs in the book to match common Cocoa/Objective-C design patterns and conventions. 
				However, these changes are relatively superficial, and Metsker's book is the best documentation available for this framework.
                
                Classes in the ParseKit Framework offer 2 basic services of general use to Cocoa developers:
    @li Tokenization via a tokenizer class
    @li Parsing via a high-level parser-building toolkit
                Learn more on the <a target="_top" href="http://parsekit.com">project site</a>
*/
 
#import <Foundation/Foundation.h>

// io
#import "PKTypes.h"
#import "PKReader.h"

// parse
#import "PKParser.h"
#import "PKAssembly.h"
#import "PKSequence.h"
#import "PKDifference.h"
#import "PKNegation.h"
#import "PKIntersection.h"
#import "PKCollectionParser.h"
#import "PKAlternation.h"
#import "PKRepetition.h"
#import "PKEmpty.h"
#import "PKTerminal.h"
#import "PKTrack.h"
#import "PKTrackException.h"

//chars
#import "PKCharacterAssembly.h"
#import "PKChar.h"
#import "PKSpecificChar.h"
#import "PKLetter.h"
#import "PKDigit.h"

// tokens
#import "PKToken.h"
#import "PKTokenizer.h"
#import "PKTokenArraySource.h"
#import "PKTokenAssembly.h"
#import "PKTokenizerState.h"
#import "PKNumberState.h"
#import "PKQuoteState.h"
#import "PKDelimitState.h"
#import "PKURLState.h"
#import "PKEmailState.h"
#import "PKTwitterState.h"
#import "PKCommentState.h"
#import "PKSingleLineCommentState.h"
#import "PKMultiLineCommentState.h"
#import "PKSymbolNode.h"
#import "PKSymbolRootNode.h"
#import "PKSymbolState.h"
#import "PKWordState.h"
#import "PKWhitespaceState.h"
#import "PKWord.h"
#import "PKUppercaseWord.h"
#import "PKLowercaseWord.h"
#import "PKNumber.h"
#import "PKQuotedString.h"
#import "PKWhitespace.h"
#import "PKDelimitedString.h"
#import "PKSymbol.h"
#import "PKComment.h"
#import "PKLiteral.h"
#import "PKCaseInsensitiveLiteral.h"
#import "PKAny.h"
#import "PKPattern.h"

// grammar
#import "PKParserFactory.h"
