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

global abstract class BaseSpecification implements SObjectSpecification
{
	/*
	 * Equality method
	 */

	global virtual Boolean equalTo( SObjectSpecification other )
	{
		return other.isGeneralizationOf( this ) && other.isSpecialCaseOf( this );
	}

	/*
	 * Subsumption methods
	 */

	global virtual Boolean isGeneralizationOfDispatch( SObjectSpecification other )
	{
		return false; // not in the general case
	}

	global virtual Boolean isSpecialCaseOfDispatch( SObjectSpecification other )
	{
		return false; // not in the general case
	}

	global virtual Boolean isGeneralizationOfDispatch( BaseSpecification other )
	{
		return false; // not in the general case
	}

	global virtual Boolean isSpecialCaseOfDispatch( BaseSpecification other )
	{
		return false; // not in the general case
	}

	/*
	 * Composition methods
	 */

	global virtual SObjectSpecification andx( SObjectSpecification other )
	{
		return new AndSpecification( this, other );
	}

	global virtual SObjectSpecification orx( SObjectSpecification other )
	{
		return new OrSpecification( this, other );
	}

	/*
	 * Database retrieval methods
	 */

	global abstract Query toSoqlQuery();

	global virtual String toSoql()
	{
		return toSoqlQuery().toSoqlBuilder().selectAll().toSoql();
	}
}
