public virtual interface SObjectSpecification
{
	// Verification methods
	Boolean isSatisfiedBy( SObject sObjectCandidate );

	// Construction-to-order methods
	void makeToSatisfy( SObject sObjectCandidate );
		// Postcondition: the sObject will return true when
		//   passed to isSatisfiedBy
		// Throws: UnsatisfiableSpecificationException

	// Database retrieval methods
	String toSoql();
		// Throws: UnsoqlableSpecificationException
	Boolean hasCompleteSoqlDescription();
		// If this returns false, database results
		//   must be filtered by isSatisfiedBy

	// Subsumption methods
	Boolean isGeneralizationOf( SObjectSpecification specification );
		// Throws:  UngeneralizableSpecificationException
	Boolean isSpecialCaseOf( SObjectSpecification specification );
		// Throws:  UngeneralizableSpecificationException

	// Composition methods
	SObjectSpecification andx( SObjectSpecification specification );
	SObjectSpecification orx( SObjectSpecification specification );
	SObjectSpecification notx();
		// Throws:  UnnegatableSpecificationException
}
