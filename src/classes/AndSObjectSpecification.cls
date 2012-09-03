global abstract class AndSObjectSpecification extends CompositeSObjectSpecification
{
	// Verification methods
	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		Boolean satisfiesAll = true;
		for( SObjectSpecification specification : specifications )
		{
			satisfiesAll = satisfiesAll && specification.isSatisfiedBy( sObjectCandidate );

			if( !satisfiesAll )
				return false;
		}
		return satisfiesAll;
	}

	// Construction-to-order methods
		// Throws: UnsatisfiableSpecificationException
	global virtual void makeToSatisfy( SObject sObjectCandidate )
	{
		// A less than satisfactory implementation
		for( SObjectSpecification specification : specifications )
		{
			specification.makeToSatisfy( sObjectCandidate );
		}
	}

	// Database retrieval methods
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

	// Subsumption methods
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SObjectSpecification specification );
	{
		Boolean allAreGeneralizations = true;
		for( SObjectSpecification specification : specifications )
		{
			allAreGeneralizations = allAreGeneralizations && specification.isGeneralizationOf( specification );

			if( !allAreGeneralizations )
				return false;
		}
		return allAreGeneralizations;
	}
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SObjectSpecification specification )
	{
		Boolean oneIsASpecialCase = false;
		for( SObjectSpecification specification : specifications )
		{
			oneIsASpecialCase = oneIsASpecialCase || specification.isSpecialCaseOf( specification );

			if( oneIsASpecialCase )
				return true;
		}
		return oneIsASpecialCase;
	}

	// Composition methods
	global virtual SObjectSpecification andx( SObjectSpecification specification )
	{
		return this.add( specification );
	}
		// Throws:  UnnegatableSpecificationException
	global virtual SObjectSpecification notx()
	{
		// By DeMorgans Law
		return left.notx().orx( right.notx() );
	}
}
