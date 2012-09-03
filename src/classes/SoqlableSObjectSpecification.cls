global virtual class SoqlableSObjectSpecification extends BaseSObjectSpecification
{
	// Subsumption methods
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOfDispatch( SoqlableSpecification specification );
	global virtual Boolean isSpecialCaseOfDispatch( CompositeSObjectSpecification specification )
	{
		return specification.isGeneralizationOf( this );
	}
	global virtual Boolean isSpecialCaseOfDispatch( UnsoqlableSpecification specification )
	{
		return false;
	}
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOfiDispatch( SoqlableSpecification specification );
	global virtual Boolean isGeneralizationOfDispatch( CompositeSObjectSpecification specification )
	{
		return specification.isSpecialCaseOfDispatch( this );
	}
	global virtual Boolean isGeneralizationOf( UnsoqlableSpecification specification )
	{
		return false;
	}

	// Database retrieval methods
	global Boolean hasCompleteSoqlDescription()
	{
		return true;
	}
}
