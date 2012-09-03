global virtual class BaseSObjectSpecification implements SObjectSpecification
{
	/*
	 * Equality method
	 */

	global virtual Boolean equalTo( SObjectSpecification other )
	{
		return this.isGeneralizationOf( other ) && this.isSpecialCaseOf( other );
	}

	/*
	 * Subsumption methods
	 */

	global virtual Boolean isGeneralizationOfDispatch( BaseSObjectSpecification other )
	{
		return false; // not in the general case
	}

	global virtual Boolean isSpecialCaseOfDispatch( BaseSObjectSpecification other )
	{
		return false; // not in the general case
	}

	/*
	 * Composition methods
	 */

	global virtual SObjectSpecification andx( SObjectSpecification other )
	{
		return new AndSObjectSpecification( this, other );
	}

	global virtual SObjectSpecification orx( SObjectSpecification other )
	{
		return new OrSObjectSpecification( this, other )
	}
}
