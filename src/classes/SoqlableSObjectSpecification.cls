global virtual class SoqlableSObjectSpecification extends BaseSObjectSpecification
{
	/*
	 * Subsumption methods
	 */

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOfDispatch( BaseSObjectSpecification other )
	{
		return other.isSpecialCaseOfDispatch( this );
	}

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOfDispatch( BaseSObjectSpecification other )
	{
		return other.isGeneralizationOf( this );
	}

	global virtual Boolean isGeneralizationOf( SoqlableSpecification other )
	{
		return false; // not in the general case
	}

	global virtual Boolean isSpecialCaseOfDispatch( SoqlableSpecification other )
	{
		return false; // not in the general case
	}

	/*
	 * Database retrieval methods
	 */
	global Boolean hasCompleteSoqlDescription()
	{
		return true;
	}
}
