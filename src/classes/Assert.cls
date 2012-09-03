global virtual class Assert
{
	global void equal( SObjectSpecification expected, SObjectSpecification actual, String message )
	{
		System.assert( expected.equals( actual ), 
			'Expected: ' + expected + ' Actual: ' + actual '; ' + message );
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
}
