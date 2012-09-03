global virtual class SoqlableSObjectSpecification extends BaseSObjectSpecification
{
	/*
	 * Subsumption methods
	 */

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOfDispatch( BaseSObjectSpecification other )
	{
		return other.isSpecialCaseOf( this );
	}

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOfDispatch( BaseSObjectSpecification other )
	{
		return other.isGeneralizationOf( this );
	}

	global virtual Boolean isGeneralizationOfDispatch( SoqlableSObjectSpecification other )
	{
		return false; // not in the general case
	}

	global virtual Boolean isSpecialCaseOfDispatch( SoqlableSObjectSpecification other )
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
