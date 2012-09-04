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
global class AndSObjectSpecificationTest
{
	private static testMethod void testIsSatisfiedBy()
	{
		AndSObjectSpecification bothFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.UnsatisfiedSpec(),
							new TestSObjectSpecification.UnsatisfiedSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.UnsatisfiedSpec(),
							new TestSObjectSpecification.SatisfiedSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.SatisfiedSpec(),
							new TestSObjectSpecification.UnsatisfiedSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification(
							new TestSObjectSpecification.SatisfiedSpec(),
							new TestSObjectSpecification.SatisfiedSpec() );

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
		AndSObjectSpecification bothFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.IncompleteSoqlSpec(),
							new TestSObjectSpecification.IncompleteSoqlSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.IncompleteSoqlSpec(),
							new TestSObjectSpecification.CompleteSoqlSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.CompleteSoqlSpec(),
							new TestSObjectSpecification.IncompleteSoqlSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification(
							new TestSObjectSpecification.CompleteSoqlSpec(),
							new TestSObjectSpecification.CompleteSoqlSpec() );

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
		SObjectSpecification testSpec = new TestSObjectSpecification.GeneralSpec();

		AndSObjectSpecification bothFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.NotGeneralSpec(),
							new TestSObjectSpecification.NotGeneralSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.NotGeneralSpec(),
							new TestSObjectSpecification.GeneralSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.GeneralSpec(),
							new TestSObjectSpecification.NotGeneralSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification(
							new TestSObjectSpecification.GeneralSpec(),
							new TestSObjectSpecification.GeneralSpec() );

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
		SObjectSpecification testSpec = new TestSObjectSpecification.SpecialSpec();

		AndSObjectSpecification bothFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.NotSpecialSpec(),
							new TestSObjectSpecification.NotSpecialSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.NotSpecialSpec(),
							new TestSObjectSpecification.SpecialSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification(
							new TestSObjectSpecification.SpecialSpec(),
							new TestSObjectSpecification.NotSpecialSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification(
							new TestSObjectSpecification.SpecialSpec(),
							new TestSObjectSpecification.SpecialSpec() );

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