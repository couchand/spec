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

		System.assertEquals( false, bothFalseActual, 'if both are false, the and should be false' );
		System.assertEquals( false, leftFalseActual, 'if one is false, the and should be false' );
		System.assertEquals( false, rightFalseActual, 'if one is false, the and should be false' );
		System.assertEquals( true, bothTrueActual, 'if both are true, the and should be true' );
	}

	private static testMethod void testHasCompleteSoqlDescription()
	{
		AndSObjectSpecification bothFalse = new AndSObjectSpecification( new UnsoqlableSpec(), new UnsoqlableSpec() );
		AndSObjectSpecification leftFalse = new AndSObjectSpecification( new UnsoqlableSpec(), new SoqlableSpec() );
		AndSObjectSpecification rightFalse = new AndSObjectSpecification( new SoqlableSpec(), new UnsoqlableSpec() );
		AndSObjectSpecification bothTrue = new AndSObjectSpecification( new SoqlableSpec(), new SoqlableSpec() );

		Test.startTest();

			Boolean bothFalseActual = bothFalse.hasCompleteSoqlDescription();
			Boolean leftFalseActual = leftFalse.hasCompleteSoqlDescription();
			Boolean rightFalseActual = rightFalse.hasCompleteSoqlDescription();
			Boolean bothTrueActual = bothTrue.hasCompleteSoqlDescription();

		Test.stopTest();

		System.assertEquals( false, bothFalseActual, 'if both are false, the and should be false' );
		System.assertEquals( false, leftFalseActual, 'if one is false, the and should be false' );
		System.assertEquals( false, rightFalseActual, 'if one is false, the and should be false' );
		System.assertEquals( true, bothTrueActual, 'if both are true, the and should be true' );
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

	global class UnsoqlableSpec extends TestSObjectSpecification
	{
		global override Boolean hasCompleteSoqlDescription()
		{
			return false;
		}
	}
	global class SoqlableSpec extends TestSObjectSpecification
	{
		global override Boolean hasCompleteSoqlDescription()
		{
			return true;
		}
	}
}