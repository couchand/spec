global virtual class FieldLessThanSpecification extends FieldBoundSpecification
{
	// Verification methods
	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		return sObjectCandidate.get( field ) < value;
	}

	// Construction-to-order methods
	global virtual void makeToSatisfy( SObject sObjectCandidate );
		// Postcondition: the sObject will return true when
		//   passed to isSatisfiedBy
		// Throws: UnsatisfiableSpecificationException
	{
		try
		{
			sObjectCandidate.set( field, value - 1 );
		}
		catch( Exception ex )
		{
			throw new UnsatisfiableSpecificationException( ex );
		}
	}

	// Subsumption methods
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SoqlableSObjectSpecification specification )
	{
		return specification.isSpecialCaseOfDispatch( this );
	}
		// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SoqlableSObjectSpecification specification )
	{
		return specification.isGeneralizationOfDispatch( this );
	}

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

	// Composition methods
	global SObjectSpecification notx()
	{
		return FieldGreaterThanOrEqualToSpecification( field, value );
	}
}
