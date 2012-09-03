global abstract class OrSObjectSpecification extends CompositeSObjectSpecification
{
	// Inner properties
	global List<SObjectSpecification> specifications;

	// Constructors
	global OrSObjectSpecification( SObjectSpecification left, SObjectSpecification right )
	{
		specifications = new List<Specification>();
		specifications.add( left );
		specifications.add( right );
	} 

	// Composition methods
	global SObjectSpecification add( SObjectSpecification specification )
	{
		specifications.add( specification );
	}

	// Verification methods
	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		Boolean satisfiesOne = true;
		for( SObjectSpecification specification : specifications )
		{
			satisfiesOne = satisfiesOne || specification.isSatisfiedBy( sObjectCandidate );
		}
		return satisfiesOne;
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
		throw new Exceptions.UnsoqlableSpecificationException();	// An unusable implementation
	}
	global virtual Boolean hasCompleteSoqlDescription()
	{
		Boolean allHaveCompleteDescription = true;
		for( SObjectSpecification specification : specifications )
		{
			allHaveCompleteDescription = allHaveCompleteDescription && specification.hasCompleteSoqlDescription();
		}
		return allHaveCompleteDescription;
	}

	// Subsumption methods
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SObjectSpecification specification );
	{
		Boolean oneIsAGeneralization = true;
		for( SObjectSpecification specification : specifications )
		{
			oneIsAAGeneralization = oneIsGeneralization || specification.isGeneralizationOf( specification );
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
		}
		return allAreSpecialCases;
	}

	// Composition methods
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