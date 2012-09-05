/*
 * Copyright (C) 2012 Andrew Couch
 *
 *	Permission is hereby granted, free of charge, to any person
 *	obtaining a copy of this software and associated documentation
 *	files (the "Software"), to deal in the Software without restriction,
 *	including without limitation the rights to use, copy, modify, merge,
 *	publish, distribute, sublicense, and/or sell copies of the Software,
 *	and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be
 *	included in all copies or substantial portions of the Software.
 *
 *	Except as contained in this notice, the name(s) of the above
 *	copyright holders shall not be used in advertising or otherwise to
 *	promote the sale, use or other dealings in this Software without
 *	prior written authorization.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 *	BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 *	ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *	SOFTWARE.
*/

@isTest
global class BaseSubsumptionDispatcherTest
{
	global static testMethod void testTwoFLTSpecs()
	{
		SObjectSpecification moreGeneral, moreSpecific;

		moreGeneral = new FieldLessThanSpecification( 'Amount', 5 );
		moreSpecific = new FieldLessThanSpecification( 'Amount', 3 );

		BaseSubsumptionDispatcher dispatcher = new BaseSubsumptionDispatcher();

		Test.startTest();

			Boolean generalGeneralizesSpecific = dispatcher.isGeneralizationOf( moreGeneral, moreSpecific );
			Boolean specificGeneralizesGeneral = dispatcher.isGeneralizationOf( moreSpecific, moreGeneral );

		Test.stopTest();

		System.assert( generalGeneralizesSpecific, 'A FLT spec with a higher bound generalizes one with a lower bound.' );
		System.assert( !specificGeneralizesGeneral, 'A FLT spec with a lower bound does not generalize one with a higher bound.' );
	}
}