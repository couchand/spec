@isTest
global class AndSObjectSpecificationTest
{
	private static testMethod void testIsSatisfiedBy()
	{
		AndSObjectSpecification bothFalse = new AndSObjectSpecification( new UnsatisfiedSpec(), new UnsatisfiedSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification( new UnsatisfiedSpec(), new SatisfiedSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification( new SatisfiedSpec(), new UnsatisfiedSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification( new SatisfiedSpec(), new SatisfiedSpec() );

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
		AndSObjectSpecification bothFalse = new AndSObjectSpecification( new IncompleteSoqlSpec(), new IncompleteSoqlSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification( new IncompleteSoqlSpec(), new CompleteSoqlSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification( new CompleteSoqlSpec(), new IncompleteSoqlSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification( new CompleteSoqlSpec(), new CompleteSoqlSpec() );

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
		SObjectSpecification testSpec = new GeneralSpec();

		AndSObjectSpecification bothFalse = new AndSObjectSpecification( new NotGeneralSpec(), new NotGeneralSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification( new NotGeneralSpec(), new GeneralSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification( new GeneralSpec(), new NotGeneralSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification( new GeneralSpec(), new GeneralSpec() );

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
		SObjectSpecification testSpec = new SpecialSpec();

		AndSObjectSpecification bothFalse = new AndSObjectSpecification( new NotSpecialSpec(), new NotSpecialSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification( new NotSpecialSpec(), new SpecialSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification( new SpecialSpec(), new NotSpecialSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification( new SpecialSpec(), new SpecialSpec() );

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

	global class UnsatisfiedSpec extends TestSObjectSpecification
	{
		global override Boolean isSatisfiedBy( SObject sObjectCandidate )
		{
			return false;
		}
	}
	global class SatisfiedSpec extends TestSObjectSpecification
	{
		global override Boolean isSatisfiedBy( SObject sObjectCandidate )
		{
			return true;
		}
	}

	global class IncompleteSoqlSpec extends TestSObjectSpecification
	{
		global override Boolean hasCompleteSoqlDescription()
		{
			return false;
		}
	}
	global class CompleteSoqlSpec extends TestSObjectSpecification
	{
		global override Boolean hasCompleteSoqlDescription()
		{
			return true;
		}
	}

	global class NotGeneralSpec extends TestSObjectSpecification
	{
		global override Boolean isGeneralizationOf( SObjectSpecification other )
		{
			return false;
		}
	}
	global class GeneralSpec extends TestSObjectSpecification
	{
		global override Boolean isGeneralizationOf( SObjectSpecification other )
		{
			return true;
		}
	}

	global class NotSpecialSpec extends TestSObjectSpecification
	{
		global override Boolean isSpecialCaseOf( SObjectSpecification other )
		{
			return false;
		}
	}
	global class SpecialSpec extends TestSObjectSpecification
	{
		global override Boolean isSpecialCaseOf( SObjectSpecification other )
		{
			return true;
		}
	}
}