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
}
