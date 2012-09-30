global class SpecificationFactory
{
	global static Map<String, String> nodeNameToClassName = new Map<String, String>
	{
		AndSpecification.NODE_TYPE			=> 'AndSpecification',
		OrSpecification.NODE_TYPE			=> 'OrSpecification',
		FieldLessThanSpecification.NODE_TYPE		=> 'FieldLessThanSpecification',
		FieldLessThanOrEqualToSpecification.NODE_TYPE	=> 'FieldLessThanOrEqualToSpecification',
		TypeSpecification.NODE_TYPE			=> 'TypeSpecification'
	};

	global static String NODE_KEY = 'node';
	global static String CHILDREN_KEY = 'specifications';

	global static String TYPE_KEY = 'type';
	global static String FIELD_KEY = 'field';
	global static String VALUE_KEY = 'value';

	global static SObjectSpecification buildFromJson( String jsonRepresentation )
	{
		Map<String, Object> anyMap = (Map<String, Object>)JSON.deserializeUntyped( jsonRepresentation );

		return buildFromAnyMap( anyMap );
	}

	global static SObjectSpecification buildFromAnyMap( Map<String, Object> anyMap )
	{
		if( !anyMap.containsKey( NODE_KEY ) )
		{
			throw new IllegalStructureException();
		}

		String nodeName = (String)anyMap.get( NODE_KEY );

		if( !nodeNameToClassName.containsKey( nodeName ) )
		{
			throw new IllegalNodeException();
		}

		Type t = type.forName( nodeNameToClassName.get( nodeName ) );

		SObjectSpecification spec = (SObjectSpecification)t.newInstance();

		if( anyMap.containsKey( TYPE_KEY ) )
		{
			((TypeSpecification)spec).type = (String)anyMap.get( TYPE_KEY );
		}
		if( anyMap.containsKey( FIELD_KEY ) )
		{
			((FieldBoundSpecification)spec).field = (String)anyMap.get( FIELD_KEY );
		}
		if( anyMap.containsKey( VALUE_KEY ) )
		{
			((FieldBoundSpecification)spec).value = anyMap.get( VALUE_KEY );
		}
		if( anyMap.containsKey( CHILDREN_KEY ) )
		{
			for( Object childMap : (List<Object>)anyMap.get( CHILDREN_KEY ) )
			{
				((CompositeSpecification)spec).add( buildFromAnyMap( (Map<String, Object>)childMap ) );
			}
		}

		return spec;
	}

	global class IllegalStructureException extends Exception {}
	global class IllegalNodeException extends Exception {}
}