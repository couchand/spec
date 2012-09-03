global virtual class CompositeSObjectSpecification implements SObjectSpecification
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
		specifications = new List<Specification>();
	}

	global CompositeSObjectSpecification( SObjectSpecification left, SObjectSpecification right )
	{
		specifications = new List<Specification>();
		specifications.add( left );
		specifications.add( right );
	}

	/*
	 * Composition methods
	 */

	global virtual SObjectSpecification add( SObjectSpecification specification )
	{
		CompositeSObjectSpecification clone = this.clone();
		clone.specifications.add( left );
		clone.specifications.add( right );
		clone.specifications.add( specification );
		return clone;
	}

	/*
	 * Subsumption methods
	 */

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOfDispatch( BaseSObjectSpecification other )
	{
		return false;
	{

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOfDispatch( BaseSObjectSpecification other )
	{
		return false;
	}
}
