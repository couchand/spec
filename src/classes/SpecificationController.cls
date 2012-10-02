global class SpecificationController
{
	global String specificationId { get; set; }

	global SpecificationController()
	{
		String candidateId = ApexPages.currentPage().getParameters().get('id');

		if( null != candidateId )
		{
			validateId( candidateId );
			specificationId = candidateId;
		}
	}

	global void init()
	{
		if( null == specificationId )
		{
			SObjectSpecification newSpec = createNewSpec();
			specificationId = storeSpec( newSpec );
		}
	}

	global static SObjectSpecification createNewSpec()
	{
		AndSpecification newSpec = new AndSpecification();
		newSpec.add( new TypeSpecification( 'Opportunity' ) );
		return newSpec;
	}

	global static String storeSpec( SObjectSpecification newSpec )
	{
		Spec__Specification__c specStorage = new Spec__Specification__c();
		specStorage.JSON_Representation__c = JSON.serialize( newSpec );
		insert specStorage;

		return specStorage.Id;
	}

	global static void storeSpec( SObjectSpecification newSpec, String specId )
	{
		Spec__Specification__c specStorage = new Spec__Specification__c( Id = specId );
		specStorage.JSON_Representation__c = JSON.serialize( newSpec );
		update specStorage;
	}

	@RemoteAction
	global static String getSpecification( String specId )
	{
		validateId( specId );

		SObjectSpecification spec = fetchSpec( specId );

		return serializeSpec( spec );
	}

	@RemoteAction
	global static String setSpec( String specId, String jsonRepresentation )
	{
		validateId( specId );

		SObjectSpecification spec = SpecificationFactory.buildFromJson( jsonRepresentation );

		storeSpec( spec, specId );

		return serializeSpec( spec );
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
