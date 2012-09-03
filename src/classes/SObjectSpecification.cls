global virtual interface SObjectSpecification
{
	// Verification methods
	global Boolean isSatisfiedBy( SObject sObjectCandidate );

	// Construction-to-order methods
	global void makeToSatisfy( SObject sObjectCandidate );
		// Postcondition: the sObject will return true when
		//   passed to isSatisfiedBy
		// Throws: UnsatisfiableSpecificationException

	// Database retrieval methods
	global String toSoql();
		// Throws: UnsoqlableSpecificationException
	global Boolean hasCompleteSoqlDescription();
		// If this returns false, database results
		//   must be filtered by isSatisfiedBy

	// Subsumption methods
	global Boolean isGeneralizationOf( SObjectSpecification specification );
		// Should recursively compute by calling the dispatch method
		//   specification.isSpecialCaseOfDispatch( this )
		// Throws:  UngeneralizableSpecificationException
	global Boolean isSpecialCaseOf( SObjectSpecification specification );
		// Should recursively compute by calling the dispatch method
		//   specification.isGeneralizationOfDispatch( this )
		// Throws:  UngeneralizableSpecificationException

	// Composition methods
	global SObjectSpecification andx( SObjectSpecification specification );
	global SObjectSpecification orx( SObjectSpecification specification );
	global SObjectSpecification notx();
		// Throws:  UnnegatableSpecificationException
}
