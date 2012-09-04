global virtual class Assert
{
	global void equals( SObjectSpecification expected, SObjectSpecification actual, String message )
	{
		System.assert( expected.equalTo( actual ), 
			'Expected: ' + expected + ' Actual: ' + actual + '; ' + message );
	}

	global void generalizes( SObjectSpecification testSpec, SObjectSpecification other, String message )
	{
		System.assert( testSpec.isGeneralizationOf( other ),
			'Expected ' + testSpec + ' to be a generalization of ' + other + '. ' + message );
	}

	global void specializes( SObjectSpecification testSpec, SObjectSpecification other, String message )
	{
		System.assert( testSpec.isSpecialCaseOf( other ),
			'Expected ' + testSpec + ' to be a special case of ' + other + '. ' + message );
	}

	global void satisfies( SObjectSpecification testSpec, SObject testObject, String message )
	{
		System.assert( testSpec.isSatisfiedBy( testObject ),
			'Expected ' + testObject + ' to satisfy ' + testSpec + '. ' + message );
	}
}