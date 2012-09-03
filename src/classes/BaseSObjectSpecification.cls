global virtual class BaseSObjectSpecification implements SObjectSpecification
{
	// Subsumption methods
	global virtual Boolean isGeneralizationOf( SObjectSpecification specification )
	{
		return specification.isSpecialCaseOf( this );
	}
	global virtual Boolean isSpecialCaseOf( SObjectSpecification specification )
	{
		return specification.isGeneralizationOf( this );
	}
	global virtual Boolean isGeneralizationOf( BaseSObjectSpecification specification )
	{
		return specification.isSpecialCaseOfDispatch( this );
	}
	global virtual Boolean isSpecialCaseOf( BaseSObjectSpecification specification )
	{
		return specification.isGeneralizationDispatch( this );
	}
	global virtual Boolean isGeneralizationOfDispatch( BaseSObjectSpecification specification )
	{
		return false; // not in the general case
	}
	global virtual Boolean isSpecialCaseOfDispatch( BaseSObjectSpecification specification )
	{
		return false; // not in the general case
	}

	// Composition methods
	global virtual SObjectSpecification andx( SObjectSpecification specification )
	{
		return new AndSObjectSpecification( this, specification );
	}
	global virtual SObjectSpecification orx( SObjectSpecification specification )
	{
		return new OrSObjectSpecification( this, specification )
	}
}
