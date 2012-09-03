global virtual class CompositeSObjectSpecification implements SObjectSpecification
{
	// Composition methods
	global virtual SObjectSpecification add( SObjectSpecification specification );

	// Subsumption methods
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SoqlableSpecification specification );
	global virtual Boolean isSpecialCaseOf( CompositeSObjectSpecification specification );
	global virtual Boolean isSpecialCaseOf( UnsoqlableSpecification specification )
	{
		return false;
	}
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SoqlableSpecification specification );
	global virtual Boolean isGeneralizationOf( CompositeSObjectSpecification specification );
	global virtual Boolean isGeneralizationOf( UnsoqlableSpecification specification )
	{
		return false;
	}
}
