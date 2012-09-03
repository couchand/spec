global virtual class FieldGreaterThanOrEqualToSpecification extends FieldBoundSpecification
{
	/*
	 * Verification methods
	 */

	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		return sObjectCandidate.get( field ) >= value;
	}

	/*
	 * Construction-to-order methods
	 */

	// Postcondition: the sObject will return true when
	//   passed to isSatisfiedBy
	// Throws: UnsatisfiableSpecificationException
	global virtual void makeToSatisfy( SObject sObjectCandidate )
	{
		try
		{
			sObjectCandidate.set( field, value );
		}
		catch( Exception ex )
		{
			throw new Exceptions.UnsatisfiableSpecificationException( ex );
		}
	}

	/*
	 * Subsumption methods
	 */

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SObjectSpecification specification )
	{
		return specification.isSpecialCaseOfDispatch( this );
	}

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SObjectSpecification specification )
	{
		return specification.isGeneralizationOfDispatch( this );
	}
/*
	global virtual Boolean isGeneralizationOfDispatch( FieldEqualToSpecification specification )
	{
		return this.value > specification.value;
	}

	global virtual Boolean isGeneralizationOfDispatch( FieldLessThanOrEqualToSpecification specification )
	{
		return this.value > specification.value;
	}

	global virtual Boolean isGeneralizationOfDispatch( FieldLessThanSpecification specification )
	{
		return this.value >= specification.value;
	}

	global virtual Boolean isSpecialCaseOfDispatch( FieldLessThanOrEqualToSpecification specification )
	{
		return this.value <= specification.value;
	}

	global virtual Boolean isSpecialCaseOfDispatch( FieldLessThanSpecification specification )
	{
		return this.value <= specification.value;
	}
*/
	/*
	 * Composition methods
	 */
	global SObjectSpecification notx()
	{
		return new FieldLessThanSpecification( field, value );
	}
}
