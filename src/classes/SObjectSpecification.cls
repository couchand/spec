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

global virtual interface SObjectSpecification
{
	/*
	 * Verification methods
	 */

	Boolean isSatisfiedBy( SObject sObjectCandidate );

	/*
	 * Construction-to-order methods
	 */

	// Postcondition: the sObject will return true when
	//   passed to isSatisfiedBy
	// Throws: UnsatisfiableSpecificationException
	void makeToSatisfy( SObject sObjectCandidate );

	/*
	 * Database retrieval methods
	 */

	// Throws: UnsoqlableSpecificationException
	String toSoql();

	// If this returns false, database results
	//   must be filtered by isSatisfiedBy
	Boolean hasCompleteSoqlDescription();

	/*
	 * Subsumption methods
	 */

	// Should recursively compute by calling the dispatch method
	//   specification.isSpecialCaseOfDispatch( this )
	// Throws:  UngeneralizableSpecificationException
	Boolean isGeneralizationOf( SObjectSpecification specification );

	// Should recursively compute by calling the dispatch method
	//   specification.isGeneralizationOfDispatch( this )
	// Throws:  UngeneralizableSpecificationException
	Boolean isSpecialCaseOf( SObjectSpecification specification );

	// Throws:  UngeneralizableSpecificationException
	Boolean isGeneralizationOfDispatch( SObjectSpecification specification );

	// Throws:  UngeneralizableSpecificationException
	Boolean isSpecialCaseOfDispatch( SObjectSpecification specification );

	/*
	 * Equality method
	 */

	// Probably isGeneralizationOf && isSpecialCaseOf
	Boolean equalTo( SObjectSpecification other );

	/*
	 * Composition methods
	 */

	SObjectSpecification andx( SObjectSpecification specification );

	SObjectSpecification orx( SObjectSpecification specification );

	// Throws:  UnnegatableSpecificationException
	SObjectSpecification notx();
}