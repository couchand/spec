@isTest
global class AndSObjectSpecificationTest
{
	global class UnsatisfiedSpec extends UnsoqlableSObjectSpecification
	{
		Boolean isSatisfiedBy( SObject sObjectCandidate )
		{
			return false;
		}

		void makeToSatisfy( SObject sObjectCandidate )
		{
			throw new Exceptions.UnsatisfiableSpecificationException();
		}

		String toSoql()
		{
			return '';
		}

		Boolean equalTo( SObjectSpecification other )
		{
			return false;
		}

		SObjectSpecification notx()
		{
			return new SatisfiedSpec();
		}
	}

	global class SatisfiedSpec extends UnsoqlableSObjectSpecification
	{
		Boolean isSatisfiedBy( SObject sObjectCandidate )
		{
			return true;
		}

		void makeToSatisfy( SObject sObjectCandidate )
		{
		}

		String toSoql()
		{
			return '';
		}

		Boolean equalTo( SObjectSpecification other )
		{
			return false;
		}

		SObjectSpecification notx()
		{
			return new UnsatisfiedSpec();
		}
	}
}
