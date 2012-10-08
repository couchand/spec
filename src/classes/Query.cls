/*
Copyright (C) 2012 Andrew Couch

	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without restriction,
	including without limitation the rights to use, copy, modify, merge,
	publish, distribute, sublicense, and/or sell copies of the Software,
	and to permit persons to whom the Software is furnished to do so,
	subject to the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	Except as contained in this notice, the name(s) of the above
	copyright holders shall not be used in advertising or otherwise to
	promote the sale, use or other dealings in this Software without
	prior written authorization.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
	BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
	ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
*/
global class Query
{
	global String type { get; set; }
	global al.Condition condition { get; set; }

	global Query(){}

	global Query( String type )
	{
		this.type = type;
	}

	global al.SoqlBuilder toSoqlBuilder()
	{
		if( null == type ) type='opportunity';//throw new Exceptions.UnsoqlableSpecificationException();

		al.SoqlBuilder builder =  new al.SoqlBuilder().fromx( type );

		if( null != condition )
		{
			builder.wherex( condition );
		}

		return builder;
	}

	global static String commonType( String left, String right )
	{
		if( null != left &&
		    ( null == right || left == right ) )
		{
			return left;
		}
		else if( null != right )
		{
			return right;
		}
		else if( null == left && null == right )
		{
			return null;
		}

		throw new Exceptions.UnsoqlableSpecificationException();
	}

	global static al.Condition buildComposite( al.ConditionGroup condition, al.Condition left, al.Condition right )
	{
		if( null != left )
		{
			condition.add( left );
		}
		if( null != right )
		{
			condition.add( right );
		}

		return condition;
	}

	global Query wherex( al.Condition condition )
	{
		Query newQ = new Query( type );
		newQ.condition = condition;
		return newQ;
	}

	global Query andx( Query other )
	{
		Query newQuery = new Query( commonType( type, other.type ) );

		newQuery.condition = buildComposite( new al.AndCondition(), condition, other.condition );

		return newQuery;
	}

	global Query orx( Query other )
	{
		Query newQuery = new Query( commonType( type, other.type ) );

		newQuery.condition = buildComposite( new al.OrCondition(), condition, other.condition );

		return newQuery;
	}
}	
