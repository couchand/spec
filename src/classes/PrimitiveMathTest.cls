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

	global static testMethod void testGreaterThanOrEqualTo()
	{
		final Object LARGE = 8;
		final Object SMALL = 3;

		Test.startTest();

			Boolean largeGTEsmall = PrimitiveMath.greaterThanOrEqualTo( LARGE, SMALL );
			Boolean smallGTElarge = PrimitiveMath.greaterThanOrEqualTo( SMALL, LARGE );
			Boolean smallGTEsmall = PrimitiveMath.greaterThanOrEqualTo( SMALL, SMALL );

		Test.stopTest();

		System.assert( largeGTEsmall, 'Large numbers are greater than or equal to small ones' );
		System.assert( !smallGTElarge, 'Small numbers are not greater than or equal to large ones' );
		System.assert( smallGTEsmall, 'Small numbers are greater than or equal to small ones' );
	}

	global static testMethod void testGreaterThan()
	{
		final Object LARGE = 8;
		final Object SMALL = 3;

		Test.startTest();

			Boolean largeGTsmall = PrimitiveMath.greaterThan( LARGE, SMALL );
			Boolean smallGTlarge = PrimitiveMath.greaterThan( SMALL, LARGE );
			Boolean smallGTsmall = PrimitiveMath.greaterThan( SMALL, SMALL );

		Test.stopTest();

		System.assert( largeGTsmall, 'Large numbers are greater than small ones' );
		System.assert( !smallGTlarge, 'Small numbers are not greater than large ones' );
		System.assert( !smallGTsmall, 'Small numbers are not greater than small ones' );
	}

	global static testMethod void testNotEqualTo()
	{
		final Object LARGE = 8;
		final Object SMALL = 3;

		Test.startTest();

			Boolean largeNEsmall = PrimitiveMath.notEqualTo( LARGE, SMALL );
			Boolean smallNElarge = PrimitiveMath.notEqualTo( SMALL, LARGE );
			Boolean smallNEsmall = PrimitiveMath.notEqualTo( SMALL, SMALL );

		Test.stopTest();

		System.assert( largeNEsmall, 'Large numbers are not equal to small ones' );
		System.assert( smallNElarge, 'Small numbers are not equal to large ones' );
		System.assert( !smallNEsmall, 'Small numbers are not not equal to small ones' );
	}
}