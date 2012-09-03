global virtual interface SObjectSpecification
{
	/*
	 * Verification methods
	 */

	Boolean isSatisfiedBy( SObject sObjectCandidate );

	/*
	 * Construction-to-order methods
	 */

	// Postcondition: the sObject will return true when
	//   passed to isSatisfiedBy
	// Throws: UnsatisfiableSpecificationException
	void makeToSatisfy( SObject sObjectCandidate );

	/*
	 * Database retrieval methods
	 */

	// Throws: UnsoqlableSpecificationException
	String toSoql();

	// If this returns false, database results
	//   must be filtered by isSatisfiedBy
	Boolean hasCompleteSoqlDescription();

	/*
	 * Subsumption methods
	 */

	// Should recursively compute by calling the dispatch method
	//   specification.isSpecialCaseOfDispatch( this )
	// Throws:  UngeneralizableSpecificationException
	Boolean isGeneralizationOf( SObjectSpecification specification );

	// Should recursively compute by calling the dispatch method
	//   specification.isGeneralizationOfDispatch( this )
	// Throws:  UngeneralizableSpecificationException
	Boolean isSpecialCaseOf( SObjectSpecification specification );

	// Throws:  UngeneralizableSpecificationException
	Boolean isGeneralizationOfDispatch( SObjectSpecification specification );

	// Throws:  UngeneralizableSpecificationException
	Boolean isSpecialCaseOfDispatch( SObjectSpecification specification );

	/*
	 * Equality method
	 */

	// Probably isGeneralizationOf && isSpecialCaseOf
	Boolean equalTo( SObjectSpecification other );

	/*
	 * Composition methods
	 */

	SObjectSpecification andx( SObjectSpecification specification );

	SObjectSpecification orx( SObjectSpecification specification );

	// Throws:  UnnegatableSpecificationException
	SObjectSpecification notx();
}
