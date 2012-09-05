/*
 * Copyright (C) 2012 Andrew Couch
 *
 *	Permission is hereby granted, free of charge, to any person
 *	obtaining a copy of this software and associated documentation
 *	files (the "Software"), to deal in the Software without restriction,
 *	including without limitation the rights to use, copy, modify, merge,
 *	publish, distribute, sublicense, and/or sell copies of the Software,
 *	and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be
 *	included in all copies or substantial portions of the Software.
 *
 *	Except as contained in this notice, the name(s) of the above
 *	copyright holders shall not be used in advertising or otherwise to
 *	promote the sale, use or other dealings in this Software without
 *	prior written authorization.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 *	BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 *	ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *	SOFTWARE.
*/

global virtual class FieldGreaterThanOrEqualToSpecification extends FieldBoundSpecification
{
	/*
	 * Constructors
	 */

	global FieldGreaterThanOrEqualToSpecification( String field, Object value )
	{
		super( field, value );
	}

	/*
	 * Verification methods
	 */

	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		return PrimitiveMath.greaterThanOrEqualTo( sObjectCandidate.get( field ), value );
	}

	/*
	 * Construction-to-order methods
	 */

	// Postcondition: the sObject will return true when
	//   passed to isSatisfiedBy
	// Throws: UnsatisfiableSpecificationException
	global virtual void makeToSatisfy( SObject sObjectCandidate )
	{
		try
		{
			sObjectCandidate.put( field, value );
		}
		catch( Exception ex )
		{
			throw new Exceptions.UnsatisfiableSpecificationException( ex );
		}
	}

	/*
	 * Database retrieval methods
	 */

	global virtual String toSoql()
	{
		throw new Exceptions.UnimplementedFeatureException();
	}

	/*
	 * Subsumption methods
	 */

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SObjectSpecification specification )
	{
		return specification.isSpecialCaseOfDispatch( this );
	}

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SObjectSpecification specification )
	{
		return specification.isGeneralizationOfDispatch( this );
	}

	global virtual Boolean isGeneralizationOfDispatch( FieldGreaterThanOrEqualToSpecification other )
	{
		return PrimitiveMath.lessThanOrEqualTo( value, other.value );
	}
/*
	global virtual Boolean isGeneralizationOfDispatch( FieldLessThanOrEqualToSpecification specification )
	{
		return this.value > specification.value;
	}

	global virtual Boolean isGeneralizationOfDispatch( FieldLessThanSpecification specification )
	{
		return this.value >= specification.value;
	}

	global virtual Boolean isSpecialCaseOfDispatch( FieldLessThanOrEqualToSpecification specification )
	{
		return this.value <= specification.value;
	}
*/
	global virtual Boolean isSpecialCaseOfDispatch( FieldGreaterThanOrEqualToSpecification other )
	{
		return PrimitiveMath.greaterThanOrEqualTo( value, other.value );
	}

	/*
	 * Composition methods
	 */
	global SObjectSpecification notx()
	{
		return new FieldLessThanSpecification( field, value );
	}
}