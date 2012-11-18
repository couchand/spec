global class SpecificationController2
{
	global static String getQuery( String typeName, SObjectSpecification spec )
	{
		al.SoqlBuilder builder = new al.SoqlBuilder();

		builder.selectx('Id').selectx('Name');
		builder.fromx( typeName );
		builder.wherex( ((BaseSpecification)spec).toCondition() );

		return builder.toSoql();
	}

	global class Result
	{
		global SObject obj;
		global String Id { get { return (String)obj.get('Id'); } private set; }
		global String Name { get { return (String)obj.get('Name'); } private set; }

		global Result( SObject obj )
		{
			this.obj = obj;
		}
	}

	@RemoteAction
	global static List<Result> getSatisfiers( String jsonRepresentation )
	{
		SObjectSpecification specification = SpecificationFactory.buildFromJson( jsonRepresentation );
		String theQuery = getQuery('Opportunity', specification);
		List<Result> satisfiers = new List<Result>();

		for( SObject obj : Database.query( theQuery ) )
		{
			satisfiers.add( new Result( obj ) );
		}

		return satisfiers;
	}
}