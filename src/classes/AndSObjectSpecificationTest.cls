@isTest
global class AndSObjectSpecificationTest
{
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
}