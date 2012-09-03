global virtual class UnsoqlableSObjectSpecification extends BaseSObjectSpecification
{
	// Subsumption methods
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SoqlableSpecification specification )
	{
		throw new Exceptions.UngeneralizableSpecificationException();
	}
	global virtual Boolean isSpecialCaseOf( CompositeSObjectSpecification specification )
	{
		throw new Exceptions.UngeneralizableSpecificationException();
	}
	global virtual Boolean isSpecialCaseOf( UnsoqlableSpecification specification )
	{
		throw new Exceptions.UngeneralizableSpecificationException();
	}
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SoqlableSpecification specification )
	{
		throw new Exceptions.UngeneralizableSpecificationException();
	}
	global virtual Boolean isGeneralizationOf( CompositeSObjectSpecification specification )
	{
		throw new Exceptions.UngeneralizableSpecificationException();
	}
	global virtual Boolean isGeneralizationOf( UnsoqlableSpecification specification )
	{
		throw new Exceptions.UngeneralizableSpecificationException();
	}

	// Database retrieval methods
	global Boolean toSoql()
	{
		throw new Exceptions.UnsoqlableSpecificationException();
	}
	global Boolean hasCompleteSoqlDescription()
	{
		throw new Exceptions.UnsoqlableSpecificationException();
	}

	// Composition methods
	global virtual SObjectSpecification notx()
	{
		throw new Exceptions.UnnegatableSpecificationException();
	}
}
