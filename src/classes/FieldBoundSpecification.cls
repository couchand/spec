global virtual class FieldBoundSpecification extends SoqlableSObjectSpecification
{
	global String field;
	global Object value;

	// Constructors
	global virtual FieldBoundSpecification( String field, Object value )
	{
		this.field = field;
		this.value = value;
	}

	// Subsumption methods
	global virtual Boolean isGeneralizationOfDispatch( FieldBoundSpecification specification )
	{
		return false; // not in the general case
	}

	global virtual Boolean isSpecialCaseOfDispatch( FieldBoundSpecification specification )
	{
		return false; // not in the general case
	}
}
