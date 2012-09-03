global abstract class OrSObjectSpecification extends CompositeSObjectSpecification
{
	/*
	 * Verification methods
	 */

	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		Boolean satisfiesOne = true;
		for( SObjectSpecification specification : specifications )
		{
			satisfiesOne = satisfiesOne || specification.isSatisfiedBy( sObjectCandidate );

			if( satisfiesOne )
				return true;
		}
		return satisfiesOne;
	}

	/*
	 * Construction-to-order methods
	 */

	// Throws: UnsatisfiableSpecificationException
	global virtual void makeToSatisfy( SObject sObjectCandidate )
	{
		// A less than satisfactory implementation
		for( SObjectSpecification specification : specifications )
		{
			specification.makeToSatisfy( sObjectCandidate );
		}
	}

	/*
	 * Database retrieval methods
	 */

	global virtual String toSoql()
	{
		throw new Exceptions.UnimplementedFeatureException();	// An unusable implementation
	}

	global virtual Boolean hasCompleteSoqlDescription()
	{
		Boolean allHaveCompleteDescription = true;
		for( SObjectSpecification specification : specifications )
		{
			allHaveCompleteDescription = allHaveCompleteDescription && specification.hasCompleteSoqlDescription();

			if( !allHaveCompleteDescription )
				return false;
		}
		return allHaveCompleteDescription;
	}

	/*
	 * Subsumption methods
	 */

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SObjectSpecification specification );
	{
		Boolean oneIsAGeneralization = true;
		for( SObjectSpecification specification : specifications )
		{
			oneIsAGeneralization = oneIsGeneralization || specification.isGeneralizationOf( specification );

			if( oneIsAGeneralization )
				return true;
		}
		return oneIsAGeneralization;
	}

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SObjectSpecification specification )
	{
		Boolean allAreSpecialCases = false;
		for( SObjectSpecification specification : specifications )
		{
			allAreSpecialCases = allAreSpecialCases && specification.isSpecialCaseOf( specification );

			if( !allAreSpecialCases )
				return false;
		}
		return allAreSpecialCases;
	}

	/*
	 * Composition methods
	 */

	global virtual SObjectSpecification orx( SObjectSpecification specification )
	{
		return this.add( specification );
	}

	// Throws:  UnnegatableSpecificationException
	global virtual SObjectSpecification notx()
	{
		// By DeMorgans Law
		return left.notx().andx( right.notx() );
	}
}
