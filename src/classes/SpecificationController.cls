global class SpecificationController
{
	global String specificationId { get; set; }

	global String query
	{
		get
		{
			if( null != specificationId )
			{
				SObjectSpecification spec = fetchSpec( specificationId );
System.debug(spec);
				spec = spec.andx( new TypeSpecification( getType( specificationId ) ) );
System.debug(spec);
				return spec.toSoql();
			}
			return '';
		}
		private set;
	}

	global List<SObject> satisfiers
	{
		get
		{
			if( null != specificationId )
			{
				return Database.query( query );
			}
			return new List<SObject>();
		}
		private set;
	}

	@RemoteAction
	global static List<String> getSObjectTypes()
	{
		List<String> sObjectTypes = new List<String>();

		for( String sObjectType : Schema.getGlobalDescribe().keySet() )
		{
			sObjectTypes.add( sObjectType );
		}

		sObjectTypes.sort();

		return sObjectTypes;
	}

	@RemoteAction
	global static List<String> getSObjectFields( String type )
	{
		List<String> sObjectFields = new List<String>();

		for( String sObjectField : Schema.getGlobalDescribe().get( type ).getDescribe().fields.getMap().keySet() )
		{
			sObjectFields.add( sObjectField );
		}

		sObjectFields.sort();

		return sObjectFields;
	}

	global SpecificationController()
	{
		String candidateId = ApexPages.currentPage().getParameters().get('id');

		if( null != candidateId )
		{
			validateId( candidateId );
			specificationId = candidateId;
		}
	}

	global PageReference init()
	{
		if( null == specificationId )
		{
			SObjectSpecification newSpec = createNewSpec();
			specificationId = storeSpec( 'My New Spec', 'Opportunity', newSpec );

			PageReference pageRef = new PageReference( '/apex/SpecBuilder?id=' + specificationId );
			pageRef.setRedirect( true );
			return pageRef;
		}

		return null;
	}

	global static SObjectSpecification createNewSpec()
	{
		AndSpecification newSpec = new AndSpecification();
		return newSpec;
	}

	global static String storeSpec( String name, String type, SObjectSpecification newSpec )
	{
		Spec__Specification__c specStorage = new Spec__Specification__c();
		specStorage.Name = name;
		specStorage.Type__c = type;
		specStorage.JSON_Representation__c = JSON.serialize( newSpec );
		insert specStorage;

		return specStorage.Id;
	}

	global static void storeSpec( SObjectSpecification newSpec, String specId )
	{
		updateSpecField( 'JSON_Representation__c', JSON.serialize( newSpec ), specId );
	}

	global static void updateSpecField( String field, String value, String specId )
	{
		Specification__c specStorage = new Specification__c( Id = specId );
		specStorage.put( field, value );
		update specStorage;
	}

	@RemoteAction
	global static void setName( String specId, String name )
	{
		validateId( specId );
		updateSpecField( 'Name', name, specId );
	}

	@RemoteAction
	global static String getName( String specId )
	{
		validateId( specId );
		return fetchSpecStorage( specId ).Name;
	}

	@RemoteAction
	global static void setSObjectType( String specId, String type )
	{
		validateId( specId );
		updateSpecField( 'Type__c', type, specId );
	}

	@RemoteAction
	global static String getType( String specId )
	{
		validateId( specId );
		return fetchSpecStorage( specId ).Type__c;
	}

	global static Spec__Specification__c fetchSpecStorage( String specId )
	{
		List<Spec__Specification__c> specStorage = [	SELECT Name, Type__c
								  FROM Spec__Specification__c
								 WHERE Id = :specId ];

		if( specStorage.isEmpty() )
		{
			throw new InvalidIdException();
		}

		return specStorage[0];
	}

	@RemoteAction
	global static SObjectSpecification getSpecification( String specId )
	{
		validateId( specId );

		SObjectSpecification spec = fetchSpec( specId );

		return spec;
	}

	@RemoteAction
	global static SObjectSpecification setSpecification( String specId, String jsonRepresentation )
	{
		validateId( specId );

		SObjectSpecification spec = SpecificationFactory.buildFromJson( jsonRepresentation );

		storeSpec( spec, specId );

		return spec;
	}

	global static void validateId( String specId )
	{
//		throw new InvalidIdException();
	}

	global static void validateType( String type )
	{
//		throw new InvalidTypeException();
	}

	global class InvalidIdException extends Exception {}

	global static SObjectSpecification fetchSpec( String specId )
	{
		List<Spec__Specification__c> specStorage = [	SELECT JSON_Representation__c
								  FROM Spec__Specification__c
								 WHERE Id = :specId ];

		if( specStorage.isEmpty() )
		{
			throw new InvalidIdException();
		}

		String jsonRepresentation = specStorage[0].JSON_Representation__c;
		return SpecificationFactory.buildFromJson( jsonRepresentation );
	}

	global static String serializeSpec( SObjectSpecification spec )
	{
		return JSON.serialize( spec );
	}
}
