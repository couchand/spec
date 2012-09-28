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
global class AndSpecificationTest
{
	private static testMethod void testIsSatisfiedBy()
	{
		AndSpecification bothFalse = new AndSpecification(
							new MockSpecification.UnsatisfiedSpec(),
							new MockSpecification.UnsatisfiedSpec() );
		AndSpecification leftFalse = new AndSpecification(
							new MockSpecification.UnsatisfiedSpec(),
							new MockSpecification.SatisfiedSpec() );
		AndSpecification rightFalse = new AndSpecification(
							new MockSpecification.SatisfiedSpec(),
							new MockSpecification.UnsatisfiedSpec() );
		AndSpecification bothTrue = new AndSpecification(
							new MockSpecification.SatisfiedSpec(),
							new MockSpecification.SatisfiedSpec() );

		Test.startTest();

			Boolean bothFalseActual = bothFalse.isSatisfiedBy( new Lead() );
			Boolean leftFalseActual = leftFalse.isSatisfiedBy( new Lead() );
			Boolean rightFalseActual = rightFalse.isSatisfiedBy( new Lead() );
			Boolean bothTrueActual = bothTrue.isSatisfiedBy( new Lead() );

		Test.stopTest();

		System.assertEquals( false, bothFalseActual, 'all specifications must be satisfied' );
		System.assertEquals( false, leftFalseActual, 'all specifications must be satisfied' );
		System.assertEquals( false, rightFalseActual, 'all specifications must be satisfied' );
		System.assertEquals( true, bothTrueActual, 'all specifications must be satisfied' );
	}

	private static testMethod void testHasCompleteSoqlDescription()
	{
		AndSpecification bothFalse = new AndSpecification(
							new MockSpecification.IncompleteSoqlSpec(),
							new MockSpecification.IncompleteSoqlSpec() );
		AndSpecification leftFalse = new AndSpecification(
							new MockSpecification.IncompleteSoqlSpec(),
							new MockSpecification.CompleteSoqlSpec() );
		AndSpecification rightFalse = new AndSpecification(
							new MockSpecification.CompleteSoqlSpec(),
							new MockSpecification.IncompleteSoqlSpec() );
		AndSpecification bothTrue = new AndSpecification(
							new MockSpecification.CompleteSoqlSpec(),
							new MockSpecification.CompleteSoqlSpec() );

		Test.startTest();

			Boolean bothFalseActual = bothFalse.hasCompleteSoqlDescription();
			Boolean leftFalseActual = leftFalse.hasCompleteSoqlDescription();
			Boolean rightFalseActual = rightFalse.hasCompleteSoqlDescription();
			Boolean bothTrueActual = bothTrue.hasCompleteSoqlDescription();

		Test.stopTest();

		System.assertEquals( false, bothFalseActual, 'all specifications must have a complete soql description' );
		System.assertEquals( false, leftFalseActual,'all specifications must have a complete soql description'  );
		System.assertEquals( false, rightFalseActual, 'all specifications must have a complete soql description' );
		System.assertEquals( true, bothTrueActual, 'all specifications must have a complete soql description' );
	}

	private static testMethod void testIsGeneralizationOf()
	{
		SObjectSpecification testSpec = new MockSpecification.GeneralSpec();

		AndSpecification bothFalse = new AndSpecification(
							new MockSpecification.NotGeneralSpec(),
							new MockSpecification.NotGeneralSpec() );
		AndSpecification leftFalse = new AndSpecification(
							new MockSpecification.NotGeneralSpec(),
							new MockSpecification.GeneralSpec() );
		AndSpecification rightFalse = new AndSpecification(
							new MockSpecification.GeneralSpec(),
							new MockSpecification.NotGeneralSpec() );
		AndSpecification bothTrue = new AndSpecification(
							new MockSpecification.GeneralSpec(),
							new MockSpecification.GeneralSpec() );

		Test.startTest();

			Boolean bothFalseActual = bothFalse.isGeneralizationOf( testSpec );
			Boolean leftFalseActual = leftFalse.isGeneralizationOf( testSpec );
			Boolean rightFalseActual = rightFalse.isGeneralizationOf( testSpec );
			Boolean bothTrueActual = bothTrue.isGeneralizationOf( testSpec );

		Test.stopTest();

		System.assertEquals( false, bothFalseActual, 'all specifications must be generalizations' );
		System.assertEquals( false, leftFalseActual, 'all specifications must be generalizations' );
		System.assertEquals( false, rightFalseActual, 'all specifications must be generalizations' );
		System.assertEquals( true, bothTrueActual, 'all specifications must be generalizations' );
	}

	private static testMethod void testIsSpecialCaseOf()
	{
		SObjectSpecification testSpec = new MockSpecification.SpecialSpec();

		AndSpecification bothFalse = new AndSpecification(
							new MockSpecification.NotSpecialSpec(),
							new MockSpecification.NotSpecialSpec() );
		AndSpecification leftFalse = new AndSpecification(
							new MockSpecification.NotSpecialSpec(),
							new MockSpecification.SpecialSpec() );
		AndSpecification rightFalse = new AndSpecification(
							new MockSpecification.SpecialSpec(),
							new MockSpecification.NotSpecialSpec() );
		AndSpecification bothTrue = new AndSpecification(
							new MockSpecification.SpecialSpec(),
							new MockSpecification.SpecialSpec() );

		Test.startTest();

			Boolean bothFalseActual = bothFalse.isSpecialCaseOf( testSpec );
			Boolean leftFalseActual = leftFalse.isSpecialCaseOf( testSpec );
			Boolean rightFalseActual = rightFalse.isSpecialCaseOf( testSpec );
			Boolean bothTrueActual = bothTrue.isSpecialCaseOf( testSpec );

		Test.stopTest();

		System.assertEquals( false, bothFalseActual, 'one specification must be a generalization' );
		System.assertEquals( true, leftFalseActual, 'one specification must be a generalization' );
		System.assertEquals( true, rightFalseActual, 'one specification must be a generalization' );
		System.assertEquals( true, bothTrueActual, 'one specification must be a generalization' );
	}
}