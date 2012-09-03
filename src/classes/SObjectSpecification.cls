global virtual interface SObjectSpecification
{
	/*
	 * Verification methods
	 */

	global Boolean isSatisfiedBy( SObject sObjectCandidate );

	/*
	 * Construction-to-order methods
	 */

	// Postcondition: the sObject will return true when
	//   passed to isSatisfiedBy
	// Throws: UnsatisfiableSpecificationException
	global void makeToSatisfy( SObject sObjectCandidate );

	/*
	 * Database retrieval methods
	 */

	// Throws: UnsoqlableSpecificationException
	global String toSoql();

	// If this returns false, database results
	//   must be filtered by isSatisfiedBy
	global Boolean hasCompleteSoqlDescription();

	/*
	 * Subsumption methods
	 */

	// Should recursively compute by calling the dispatch method
	//   specification.isSpecialCaseOfDispatch( this )
	// Throws:  UngeneralizableSpecificationException
	global Boolean isGeneralizationOf( SObjectSpecification specification );

	// Should recursively compute by calling the dispatch method
	//   specification.isGeneralizationOfDispatch( this )
	// Throws:  UngeneralizableSpecificationException
	global Boolean isSpecialCaseOf( SObjectSpecification specification );

	// Throws:  UngeneralizableSpecificationException
	global Boolean isGeneralizationOfDispatch( SObjectSpecification specification );

	// Throws:  UngeneralizableSpecificationException
	global Boolean isSpecialCaseOfDispatch( SObjectSpecification specification );

	/*
	 * Composition methods
	 */

	global SObjectSpecification andx( SObjectSpecification specification );

	global SObjectSpecification orx( SObjectSpecification specification );

	// Throws:  UnnegatableSpecificationException
	global SObjectSpecification notx();
}
