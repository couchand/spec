@isTest
global class PrimitiveMathTest
{
	global static testMethod void testLessThan()
	{
		final Object LARGE = 8;
		final Object SMALL = 3;

		Test.startTest();

			Boolean largeLTsmall = PrimitiveMath.lessThan( LARGE, SMALL );
			Boolean smallLTlarge = PrimitiveMath.lessThan( SMALL, LARGE );
			Boolean smallLTsmall = PrimitiveMath.lessThan( SMALL, SMALL );

		Test.stopTest();

		System.assert( !largeLTsmall, 'Large numbers are not less than small ones' );
		System.assert( smallLTlarge, 'Small numbers are less than large ones' );
		System.assert( !smallLTsmall, 'Small numbers are not less than small ones' );
	}

	global static testMethod void testLessThanOrEqualTo()
	{
		final Object LARGE = 8;
		final Object SMALL = 3;

		Test.startTest();

			Boolean largeLTEsmall = PrimitiveMath.lessThanOrEqualTo( LARGE, SMALL );
			Boolean smallLTElarge = PrimitiveMath.lessThanOrEqualTo( SMALL, LARGE );
			Boolean smallLTEsmall = PrimitiveMath.lessThanOrEqualTo( SMALL, SMALL );

		Test.stopTest();

		System.assert( !largeLTEsmall, 'Large numbers are not less than or equal to small ones' );
		System.assert( smallLTElarge, 'Small numbers are less than or equal to large ones' );
		System.assert( smallLTEsmall, 'Small numbers are less than or equal to small ones' );
	}

	global static testMethod void testEqualTo()
	{
		final Object LARGE = 8;
		final Object SMALL = 3;

		Test.startTest();

			Boolean largeEsmall = PrimitiveMath.equalTo( LARGE, SMALL );
			Boolean smallElarge = PrimitiveMath.equalTo( SMALL, LARGE );
			Boolean smallEsmall = PrimitiveMath.equalTo( SMALL, SMALL );

		Test.stopTest();

		System.assert( !largeEsmall, 'Large numbers are not equal to small ones' );
		System.assert( !smallElarge, 'Small numbers are not equal to large ones' );
		System.assert( smallEsmall, 'Small numbers are equal to small ones' );
	}
}