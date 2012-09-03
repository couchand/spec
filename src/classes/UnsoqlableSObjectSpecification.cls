global virtual class UnsoqlableSObjectSpecification extends BaseSObjectSpecification
{
	/*
	 * Subsumption methods
	 */

	global virtual Boolean isGeneralizationOf( SObjectSpecification other )
	{
		return false;
	}

	global virtual Boolean isSpecialCaseOf( SObjectSpecification other )
	{
		return false;
	}

	global virtual Boolean isGeneralizationOfDispatch( SObjectSpecification other )
	{
		return false;
	}

	global virtual Boolean isSpecialCaseOfDispatch( SObjectSpecification other )
	{
		return false;
	}

	/*
	 * Database retrieval methods
	 */

	global Boolean toSoql()
	{
		throw new Exceptions.UnsoqlableSpecificationException();
	}

	global Boolean hasCompleteSoqlDescription()
	{
		return false;
	}

	/*
	 * Composition methods
	 */

	global virtual SObjectSpecification notx()
	{
		throw new Exceptions.UnnegatableSpecificationException();
	}
}