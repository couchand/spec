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
global class FieldNotEqualToTest
{
	final static Decimal A_LOT_OF_MONEY = 1000000.00;
	final static Decimal NOT_A_LOT_OF_MONEY = 10.00;

	/*
	 * Verification methods
	 */

	global static testMethod void isSatisfiedByTest_True()
	{
		Opportunity smallOpportunity = new Opportunity( Amount = NOT_A_LOT_OF_MONEY );
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );

		Test.startTest();

			Boolean actualIsSatisfied = smallOpportunitySpec.isSatisfiedBy( smallOpportunity );

		Test.stopTest();

		System.assertEquals( true, actualIsSatisfied, 'A FNE spec is satisfied when the fields are not equal' );
	}

	global static testMethod void isSatisfiedByTest_False()
	{
		Opportunity bigOpportunity = new Opportunity( Amount = A_LOT_OF_MONEY );
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );

		Test.startTest();

			Boolean actualIsSatisfied = smallOpportunitySpec.isSatisfiedBy( bigOpportunity );

		Test.stopTest();

		System.assertEquals( false, actualIsSatisfied, 'A FE spec is not satisfied when the fields are not equal' );
	}

	/*
	 * Construction-to-order methods
	 */

	global static testMethod void makeToSatisfyTest()
	{
		// @TODO: implement
	}

	/*
	 * Database retrieval methods
	 */

	global static testMethod void toConditionTest()
	{
		// @TODO: implement
	}

	global static testMethod void toSoqlTest()
	{
		// @TODO: implement
	}

	/*
	 * Subsumption methods
	 */

	global static testMethod void isGeneralizationOfDispatchTest_True()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldNotEqualTo otherSpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );

		Test.startTest();

			Boolean actualIsGeneralization = smallOpportunitySpec.isGeneralizationOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( true, actualIsGeneralization, 'fne identity is generalization' );
	}

	global static testMethod void isGeneralizationOfDispatchTest_False()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldNotEqualTo otherSpec = new FieldNotEqualTo( 'Amount', NOT_A_LOT_OF_MONEY );

		Test.startTest();

			Boolean actualIsGeneralization = smallOpportunitySpec.isGeneralizationOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( false, actualIsGeneralization, 'fne with other value is not generalization' );
	}

	global static testMethod void isGeneralizationOfDispatchTest_OtherField()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldNotEqualTo otherSpec = new FieldNotEqualTo( 'Probability', 50 );

		Test.startTest();

			Boolean actualIsGeneralization = smallOpportunitySpec.isGeneralizationOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( false, actualIsGeneralization, 'Specs on other fields are unrelated' );
	}

	global static testMethod void isSpecialCaseOfDispatchTest_True()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldNotEqualTo otherSpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );

		Test.startTest();

			Boolean actualIsSpecialCase = smallOpportunitySpec.isSpecialCaseOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( true, actualIsSpecialCase, 'fne identity is generalization' );
	}

	global static testMethod void isSpecialCaseOfDispatchTest_False()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldNotEqualTo otherSpec = new FieldNotEqualTo( 'Amount', NOT_A_LOT_OF_MONEY );

		Test.startTest();

			Boolean actualIsSpecialCase = smallOpportunitySpec.isSpecialCaseOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( false, actualIsSpecialCase, 'fne with other value is not generalization' );
	}

	global static testMethod void isSpecialCaseOfDispatchTest_OtherField()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldNotEqualTo otherSpec = new FieldNotEqualTo( 'Probability', 50 );

		Test.startTest();

			Boolean actualIsSpecialCase = smallOpportunitySpec.isSpecialCaseOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( false, actualIsSpecialCase, 'Specs on other fields are unrelated' );
	}

	global static testMethod void isGeneralizationOfDispatchTest_FE_True()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldEqualTo otherSpec = new FieldEqualTo( 'Amount', NOT_A_LOT_OF_MONEY );

		Test.startTest();

			Boolean actualIsGeneralization = smallOpportunitySpec.isGeneralizationOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( true, actualIsGeneralization, 'fne is special case of fe of different edge case' );
	}

	global static testMethod void isGeneralizationOfDispatchTest_FE_False()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldEqualTo otherSpec = new FieldEqualTo( 'Amount', A_LOT_OF_MONEY );

		Test.startTest();

			Boolean actualIsGeneralization = smallOpportunitySpec.isGeneralizationOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( false, actualIsGeneralization, 'fne is not special case of fe with same value' );
	}

	global static testMethod void isGeneralizationOfDispatchTest_FE_OtherField()
	{
		FieldNotEqualTo smallOpportunitySpec = new FieldNotEqualTo( 'Amount', A_LOT_OF_MONEY );
		FieldEqualTo otherSpec = new FieldEqualTo( 'Probability', 50 );

		Test.startTest();

			Boolean actualIsGeneralization = smallOpportunitySpec.isGeneralizationOfDispatch( otherSpec );

		Test.stopTest();

		System.assertEquals( false, actualIsGeneralization, 'Specs on other fields are unrelated' );
	}

	/*
	 * Composition methods
	 */
	global static testMethod void notxTest()
	{
		FieldEqualTo bigOpportunitySpec = new FieldEqualTo( 'Amount', A_LOT_OF_MONEY );

		Test.startTest();

			SObjectSpecification actualNot = bigOpportunitySpec.notx();

		Test.stopTest();

		System.assert( actualNot instanceof FieldNotEqualTo, 'The inverse of a FE is a FNE' );
		System.assertEquals( A_LOT_OF_MONEY, ((FieldNotEqualTo)actualNot).value, 'The edge case of the inverse should be the same' );
	}
}