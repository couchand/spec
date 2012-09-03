global virtual class CompositeSObjectSpecification implements SObjectSpecification
{
	/*
	 * Composition methods
	 */

	global virtual SObjectSpecification add( SObjectSpecification specification );

	/*
	 * Subsumption methods
	 */

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOfDispatch( BaseSObjectSpecification other )
	{
		return false;
	{

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOfDispatch( BaseSObjectSpecification other );
	{
		return false;
	}
}
