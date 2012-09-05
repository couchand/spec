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
global class FieldGreaterThanOrEqualToSpecTest
{
	final static String FIELD_NAME = 'Amount';

	final static Double CUTOFF_VALUE = 9.0;

	final static Double SATISFYING_VALUE = 9.0;
	final static Double NON_SATISFYING_VALUE = 8.0;

	final static Double GENERALIZING_NUMBER = 10.0;

	static FieldGreaterThanOrEqualToSpecification testSpecification;

	private static void setup()
	{
		testSpecification = new FieldGreaterThanOrEqualToSpecification( FIELD_NAME, CUTOFF_VALUE );
	}

	private static testMethod void testIsSatisfiedBy()
	{
		setup();

		Opportunity testSatisfyingOpportunity = new Opportunity();
		testSatisfyingOpportunity.put( FIELD_NAME, SATISFYING_VALUE );

		Opportunity testNonsatisfyingOpportunity = new Opportunity();
		testNonsatisfyingOpportunity.put( FIELD_NAME, NON_SATISFYING_VALUE );

		Test.startTest();

			Boolean actualShouldSatisfy = testSpecification.isSatisfiedBy( testSatisfyingOpportunity );
			Boolean actualShouldNotSatisfy = testSpecification.isSatisfiedBy( testNonsatisfyingOpportunity );

		Test.stopTest();

		System.assert( actualShouldSatisfy, 'The value at cutoff should satisfy the specification' );
		System.assert( !actualShouldNotSatisfy, 'The value below cutoff should not satisfy the specification' );
	}

	private static testMethod void testNot()
	{
		setup();

		Test.startTest();

			SObjectSpecification actualNot = testSpecification.notx();

		Test.stopTest();

		System.assert( actualNot instanceOf FieldLessThanSpecification,
			'The inverse of a FGTE spec is a FLT spec' );

		FieldLessThanSpecification actualFLTSpec =
			(FieldLessThanSpecification) actualNot;

		System.assertEquals( CUTOFF_VALUE, actualFLTSpec.value,
			'The cutoff value of the inverse is the same' );
		System.assertEquals( FIELD_NAME, actualFLTSpec.field,
			'The field name of the inverse is the same' );
	}

	private static testMethod void testIsGeneralizationOfDispatch_FGTE()
	{
		setup();

		FieldGreaterThanOrEqualToSpecification moreGeneralSpec =
			new FieldGreaterThanOrEqualToSpecification( FIELD_NAME, GENERALIZING_NUMBER );

		Test.startTest();

			Boolean specificIsGeneralizationOfGeneral = testSpecification.isGeneralizationOfDispatch( moreGeneralSpec );
			Boolean generalIsGeneralizationOfSpecific = moreGeneralSpec.isGeneralizationOfDispatch( testSpecification );

		Test.stopTest();

		System.assert( !specificIsGeneralizationOfGeneral,
			'A FGTE spec with a lower number is not a generalization of one with a higher number' );
		System.assert( generalIsGeneralizationOfSpecific,
			'A FGTE spec with a higher number is a generalization of one with a lower number' );
	}

	private static testMethod void testIsSpecialCaseOfDispatch_FGTE()
	{
		setup();

		FieldGreaterThanOrEqualToSpecification moreGeneralSpec =
			new FieldGreaterThanOrEqualToSpecification( FIELD_NAME, GENERALIZING_NUMBER );

		Test.startTest();

			Boolean specificIsSpecialCaseOfGeneral = testSpecification.isSpecialCaseOfDispatch( moreGeneralSpec );
			Boolean generalIsSpecialCaseOfSpecific = moreGeneralSpec.isSpecialCaseOfDispatch( testSpecification );

		Test.stopTest();

		System.assert( specificIsSpecialCaseOfGeneral,
			'A FGTE spec with a lower number is not a generalization of one with a higher number' );
		System.assert( !generalIsSpecialCaseOfSpecific,
			'A FGTE spec with a higher number is a generalization of one with a lower number' );
	}
}