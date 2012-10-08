global class SpecificationController
{
	global String specificationId { get; set; }

	global String query
	{
		get
		{
			if( null != specificationId )
			{
				AndSpecification spec = (AndSpecification)fetchSpec( specificationId );

				for( SObjectSpecification child : spec.specifications )
				{
					if( child instanceof FieldBoundSpecification )
					{
						FieldBoundSpecification fieldBound = (FieldBoundSpecification)child;

						if( !hasField3 )
						{
							field3 = fieldBound.field;
						}
						else if( field3 != fieldBound.field && !hasField4 )
						{
							field4 = fieldBound.field;
						}
					}
				}

				al.SoqlBuilder builder = new al.SoqlBuilder();
				builder.selectx('Id').selectx('Name');
				if( hasField3 ) builder.selectx( field3 );
				if( hasField4 ) builder.selectx( field4 );
				builder.fromx( getType( specificationId ) );
				builder.wherex( spec.toCondition() );
				return builder.toSoql();
			}
			return '';
		}
		private set;
	}

	global String field3 { get; set; }
	global Boolean hasField3 { get { return null != field3; } private set; }
	global String field4 { get; set; }
	global Boolean hasField4 { get { return null != field4; } private set ; }

	global class Result
	{
		global SObject obj;
		global String Id { get { return (String)obj.get('Id'); } private set; }
		global String Name { get { return (String)obj.get('Name'); } private set; }
		global String field3 { get; set; }
		global Boolean hasField3 { get { return null != field3; } private set; }
		global Object field3val { get { return hasField3 ? obj.get( field3 ) : null; } private set; }
		global String field4 { get; set; }
		global Boolean hasField4 { get { return null != field4; } private set ; }
		global Object field4val { get { return hasField4 ? obj.get( field4 ) : null; } private set; }

		global Result( SObject obj, String field3, String field4 )
		{
			this.obj = obj;
			this.field3 = field3;
			this.field4 = field4;
		}
	}

	global List<Result> satisfiers
	{
		get
		{
			String theQuery = query;
			if( '' != theQuery )
			{
				satisfiers = new List<Result>();
				for( SObject obj : Database.query( theQuery ) )
				{
					satisfiers.add( new Result( obj, field3, field4 ) );
				}
				return satisfiers;
			}
			return new List<Result>();
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