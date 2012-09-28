global virtual class PrimitiveMath
{
	global static al.PrimitiveComparator comparator
	{
		get
		{
			if( null == comparator )
			{
				comparator = new al.PrimitiveComparator();
			}
			return comparator;
		}
	}

	global static Boolean lessThan( Object left, Object right )
	{
		return -1 == comparator.compare( left, right );
	}

	global static Boolean lessThanOrEqualTo( Object left, Object right )
	{
system.debug( '' + left + ' <= ' + right + ' is ' + (0 >= comparator.compare( left, right ) ) );
		return 0 >= comparator.compare( left, right );
	}

	global static Boolean equalTo( Object left, Object right )
	{
		return 0 == comparator.compare( left, right );
	}

	global static Boolean greaterThanOrEqualTo( Object left, Object right )
	{
system.debug( '' + left + ' >= ' + right + ' is ' + (0 <= comparator.compare( left, right ) ) );
		return 0 <= comparator.compare( left, right );
	}

	global static Boolean greaterThan( Object left, Object right )
	{
		return 1 == comparator.compare( left, right );
	}

	global static Boolean notEqualTo( Object left, Object right )
	{
		return 0 != comparator.compare( left, right );
	}

	global static Object increment( Object valueToIncrement )
	{
		throw new Exceptions.UnimplementedFeatureException();
	}

	global static Object decrement( Object valueToDecrement )
	{
		throw new Exceptions.UnimplementedFeatureException();
	}
}