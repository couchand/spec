global virtual class CompositeSObjectSpecification extends BaseSObjectSpecification
{
	/*
	 * Inner properties
	 */

	global List<SObjectSpecification> specifications;

	/*
	 * Constructors
	 */

	global CompositeSObjectSpecification()
	{
		specifications = new List<SObjectSpecification>();
	}

	global CompositeSObjectSpecification( SObjectSpecification left, SObjectSpecification right )
	{
		specifications = new List<SObjectSpecification>();
		specifications.add( left );
		specifications.add( right );
	}

	/*
	 * Composition methods
	 */

	global virtual SObjectSpecification add( SObjectSpecification specification )
	{
		CompositeSObjectSpecification clone = this.clone();

		for( SObjectSpecification spec : specifications )
		{
			clone.specifications.add( spec );
		}

		clone.specifications.add( specification );
		return clone;
	}

	/*
	 * Subsumption methods
	 */

	global virtual override Boolean isSpecialCaseOfDispatch( BaseSObjectSpecification other )
	{
		return false;
	}

	global virtual override Boolean isGeneralizationOfDispatch( BaseSObjectSpecification other )
	{
		return false;
	}
}
