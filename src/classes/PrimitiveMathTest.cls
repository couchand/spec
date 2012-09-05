@isTest
global class PrimitiveMathTest
{
	global static testMethod void testLessThan()
	{
		final Object LARGE = 8;
		final Object SMALL = 3;

		Test.startTest();

			Boolean largeLessThanSmall = PrimitiveMath.lessThan( LARGE, SMALL );
			Boolean smallLessThanLarge = PrimitiveMath.lessThan( SMALL, LARGE );

		Test.stopTest();

		System.assert( !largeLessThanSmall, 'Large numbers are not less than small ones' );
		System.assert( smallLessThanLarge, 'Small numbers are less than large ones' );
	}
}