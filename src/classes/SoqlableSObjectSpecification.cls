global abstract class SoqlableSObjectSpecification extends BaseSObjectSpecification
{
	/*
	 * Subsumption methods
	 */

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
	global virtual Boolean hasCompleteSoqlDescription()
	{
		return true;
	}
}