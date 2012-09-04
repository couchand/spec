global virtual class TestSObjectSpecification extends UnsoqlableSObjectSpecification
{
	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		return false;
	}

	global virtual void makeToSatisfy( SObject sObjectCandidate )
	{
		throw new Exceptions.UnsatisfiableSpecificationException();
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