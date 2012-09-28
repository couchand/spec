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

global virtual class AndSpecification extends CompositeSpecification
{
	/*
	 * Constructors
	 */

	global AndSpecification()
	{
		super();
	}

	global AndSpecification( SObjectSpecification left, SObjectSpecification right )
	{
		super( left, right );
	}

	/*
	 * Verification methods
	 */

	global virtual Boolean isSatisfiedBy( SObject sObjectCandidate )
	{
		Boolean satisfiesAll = true;
		for( SObjectSpecification specification : specifications )
		{
			satisfiesAll = satisfiesAll && specification.isSatisfiedBy( sObjectCandidate );

			if( !satisfiesAll )
				return false;
		}
		return satisfiesAll;
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
		Boolean allAreGeneralizations = true;
		for( SObjectSpecification specification : specifications )
		{
			allAreGeneralizations = allAreGeneralizations && specification.isGeneralizationOf( other );

			if( !allAreGeneralizations )
				return false;
		}
		return allAreGeneralizations;
	}

	// Throws:  UngeneralizableSpecificationException
	global virtual Boolean isSpecialCaseOf( SObjectSpecification other )
	{
		Boolean oneIsASpecialCase = false;
		for( SObjectSpecification specification : specifications )
		{
			oneIsASpecialCase = oneIsASpecialCase || specification.isSpecialCaseOf( other );

			if( oneIsASpecialCase )
				return true;
		}
		return oneIsASpecialCase;
	}

	/*
	 * Composition methods
	 */

	global virtual override SObjectSpecification andx( SObjectSpecification other )
	{
		return this.add( other );
	}

	// Throws:  UnnegatableSpecificationException
	global virtual SObjectSpecification notx()
	{
		// By DeMorgans Law
		OrSObjectSpecification newSpec = new OrSObjectSpecification();

		for( SObjectSpecification spec : specifications )
		{
			newSpec.add( spec.notx() );
		}

		return newSpec;
	}
}
