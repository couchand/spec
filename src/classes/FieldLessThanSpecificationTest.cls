@isTest
global class FieldLessThanSpecificationTest
{
	final static String FIELD_NAME = 'Amount';
	final static Double CUTOFF_VALUE = 9.0;
	final static Double SATISFYING_VALUE = 8.0;
	final static Double NON_SATISFYING_VALUE = 9.0;

	static SObjectSpecification testSpecification;

	private static void setup()
	{
		testSpecification = new FieldLessThanSpecification( FIELD_NAME, CUTOFF_VALUE );
	}

	private static testMethod void testIsSatisfiedBy()
	{
		setup();

		Opportunity testSatisfyingOpportunity = new Opportunity();
		testSatisfyingOpportunity.put( FIELD_NAME, SATISFYING_VALUE );

		Opportunity testNonsatisfyingOpportunity = new Opportunity();
		testNonsatisfyingOpportunity.put( FIELD_NAME, NON_SATISFYING_VALUE );

		Test.startTest();

			Boolean actualShouldSatisfy = testSpecification.isSatisfiedBy( testSatisfyingOpportunity );
			Boolean actualShouldNotSatisfy = testSpecification.isSatisfiedBy( testNonsatisfyingOpportunity );

		Test.stopTest();

		System.assertEquals( true, actualShouldSatisfy, 'The value below cutoff should satisfy the specification' );
		System.assertEquals( false, actualShouldNotSatisfy, 'The value at cutoff should not satisfy the specification' );
	}

	private static testMethod void testNot()
	{
		setup();

		Test.startTest();

			SObjectSpecification actualNot = testSpecification.notx();

		Test.stopTest();

		System.assert( actualNot instanceOf FieldGreaterThanOrEqualToSpecification,
			'The inverse of a FLT spec is a FGTE spec' );

		FieldGreaterThanOrEqualToSpecification actualFGTESpec =
			(FieldGreaterThanOrEqualToSpecification) actualNot;

		System.assertEquals( CUTOFF_VALUE, actualFGTESpec.value,
			'The cutoff value of the inverse is the same' );
		System.assertEquals( FIELD_NAME, actualFGTESpec.field,
			'The field name of the inverse is the same' );
	}

	private static testMethod void testIsGeneralizationOf()
	{
		setup();

		SObjectSpecification moreGeneralSpec = new FieldLessThanSpecification( FIELD_NAME, NON_SATISFYING_VALUE );

		Test.startTest();

			Boolean actualTestIsGeneralizationOfMoreGeneral = testSpecification.isGeneralizationOf( moreGeneralSpec );
			Boolean actualMoreGeneralIsGeneralizationOfTest = moreGeneralSpec.isGeneralizationOf( testSpecification );

		Test.stopTest();

		System.assertEquals( false, actualTestIsGeneralizationOfMoreGeneral,
			'A FLT spec with a lower number is not a generalization of one with a higher number' );
		System.assertEquals( true, actualMoreGeneralIsGeneralizationOfTest,
			'A FLT spec with a higher number is a generalization of one with a lower number' );
	}
}
