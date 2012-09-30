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

global virtual class OrSpecification extends CompositeSpecification
{
	/*
	 * Properties
	 */

	public static String NODE_TYPE = 'or';
	public String node = NODE_TYPE;
	/*
	 * Constructors
	 */

	global OrSpecification()
	{
		super();
	}

	global OrSpecification( SObjectSpecification left, SObjectSpecification right )
	{
		super( left, right );
	}

	/*
	 * Verification methods
	 */

	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		Boolean satisfiesOne = true;
		for( SObjectSpecification specification : specifications )
		{
			satisfiesOne = satisfiesOne || specification.isSatisfiedBy( sObjectCandidate );

			if( satisfiesOne )
				return true;
		}
		return satisfiesOne;
	}

	/*
	 * Construction-to-order methods
	 */

	// Throws: UnsatisfiableSpecificationException
	global virtual void makeToSatisfy( SObject sObjectCandidate )
	{
		// A less than satisfactory implementation
		for( SObjectSpecification specification : specifications )
		{
			specification.makeToSatisfy( sObjectCandidate );
		}
	}

	/*
	 * Database retrieval methods
	 */

	global virtual String toSoql()
	{
		throw new Exceptions.UnimplementedFeatureException();	// An unusable implementation
	}

	global virtual Boolean hasCompleteSoqlDescription()
	{
		Boolean allHaveCompleteDescription = true;
		for( SObjectSpecification specification : specifications )
		{
			allHaveCompleteDescription = allHaveCompleteDescription && specification.hasCompleteSoqlDescription();

			if( !allHaveCompleteDescription )
				return false;
		}
		return allHaveCompleteDescription;
	}

	/*
	 * Subsumption methods
	 */

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isGeneralizationOf( SObjectSpecification other )
	{
		Boolean oneIsAGeneralization = true;
		for( SObjectSpecification specification : specifications )
		{
			oneIsAGeneralization = oneIsAGeneralization || specification.isGeneralizationOf( other );

			if( oneIsAGeneralization )
				return true;
		}
		return oneIsAGeneralization;
	}

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SObjectSpecification other )
	{
		Boolean allAreSpecialCases = false;
		for( SObjectSpecification specification : specifications )
		{
			allAreSpecialCases = allAreSpecialCases && specification.isSpecialCaseOf( other );

			if( !allAreSpecialCases )
				return false;
		}
		return allAreSpecialCases;
	}

	/*
	 * Composition methods
	 */

	global virtual override SObjectSpecification orx( SObjectSpecification other )
	{
		return this.add( other );
	}

	// Throws:  UnnegatableSpecificationException
	global virtual SObjectSpecification notx()
	{
		// By DeMorgans Law
		AndSpecification newSpec = new AndSpecification();

		for( SObjectSpecification spec : specifications )
		{
			newSpec.add( spec.notx() );
		}

		return newSpec;
	}
}