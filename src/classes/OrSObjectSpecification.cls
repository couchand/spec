global virtual class OrSObjectSpecification extends CompositeSObjectSpecification
{
	/*
	 * Constructors
	 */

	global OrSObjectSpecification()
	{
		super();
	}

	global OrSObjectSpecification( SObjectSpecification left, SObjectSpecification right )
	{
		super( left, right );
	}

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
	global virtual Boolean isGeneralizationOf( SObjectSpecification other )
	{
		Boolean oneIsAGeneralization = true;
		for( SObjectSpecification specification : specifications )
		{
			oneIsAGeneralization = oneIsAGeneralization || specification.isGeneralizationOf( other );

			if( oneIsAGeneralization )
				return true;
		}
		return oneIsAGeneralization;
	}

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SObjectSpecification other )
	{
		Boolean allAreSpecialCases = false;
		for( SObjectSpecification specification : specifications )
		{
			allAreSpecialCases = allAreSpecialCases && specification.isSpecialCaseOf( other );

			if( !allAreSpecialCases )
				return false;
		}
		return allAreSpecialCases;
	}

	/*
	 * Composition methods
	 */

	global virtual override SObjectSpecification orx( SObjectSpecification other )
	{
		return this.add( other );
	}

	// Throws:  UnnegatableSpecificationException
	global virtual SObjectSpecification notx()
	{
		// By DeMorgans Law
		AndSObjectSpecification newSpec = new AndSObjectSpecification();

		for( SObjectSpecification spec : specifications )
		{
			newSpec.add( spec.notx() );
		}

		return newSpec;
	}
}
