global virtual class FieldBoundSpecification extends SoqlableSObjectSpecification
{
	global String field;
	global Object value;

	global virtual class FieldLessThanSpecification extends FieldBoundSpecification
	{
		// Verification methods
		global Boolean isSatisfiedBy( SObject sObjectCandidate )
		{
			return sObjectCandidate.get( field ) < value;
		}

		// Construction-to-order methods
		global void makeToSatisfy( SObject sObjectCandidate );
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
		global Boolean isGeneralizationOf( SoqlableSObjectSpecification specification )
		{
			return specification.isSpecialCaseOfDispatch( this );
		}
			// Throws:  UngeneralizableSpecificationException
		global Boolean isSpecialCaseOf( SoqlableSObjectSpecification specification )
		{
			return specification.isGeneralizationOfDispatch( this );
		}

		global Boolean isGeneralizationOfDispatch( FieldEqualToSpecification specification )
		{
			return this.value > specification.value;
		}

		global Boolean isGeneralizationOfDispatch( FieldLessThanOrEqualToSpecification specification )
		{
			return this.value > specification.value;
		}

		global Boolean isGeneralizationOfDispatch( FieldLessThanSpecification specification )
		{
			return this.value >= specification.value;
		}

		global Boolean isSpecialCaseOfDispatch( FieldLessThanOrEqualToSpecification specification )
		{
			return this.value <= specification.value;
		}

		global Boolean isSpecialCaseOfDispatch( FieldLessThanSpecification specification )
		{
			return this.value <= specification.value;
		}

		// Composition methods
		global SObjectSpecification notx()
		{
			return FieldGreaterThanOrEqualToSpecification( field, value );
		}
	}
}
