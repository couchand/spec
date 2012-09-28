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

global class BaseDispatcher implements SubsumptionDispatcher
{
	global void mustBeBaseSpecification( SObjectSpecification spec )
	{
		if( !isBase( spec ) )
		{
			throw new Exceptions.UnknownClassException();
		}
	}

	global Boolean isBase( SObjectSpecification spec )
	{
		return spec instanceof BaseSpecification;
	}

	global Boolean isComposite( SObjectSpecification spec )
	{
		return spec instanceof CompositeSpecification;
	}

	global Boolean isSoqlable( SObjectSpecification spec )
	{
		return spec instanceof SoqlableSpecification;
	}

	global Boolean isUnsoqlable( SObjectSpecification spec )
	{
		return spec instanceof UnsoqlableSpecification;
	}

	global Boolean isGeneralizationOf( SObjectSpecification left, SObjectSpecification right )
	{
		mustBeBaseSpecification( left );
		mustBeBaseSpecification( right );
/*
		if( isSoqlable( left ) && isSoqlable( right ) )
		{
			return ((SoqlableSpecification)left).isGeneralizationOf( (SoqlableSpecification)right );
		}

		else if( isComposite( left ) && isComposite( right ) )
		{
			return isGeneralizationOfComposites( left, right );
		}
		else if( isComposite( left ) && isSoqlable( right ) )
		{
			return isGeneralizationOfCompositeSoqlable( left, right );
		}
		else if( isSoqlable( left ) && isComposite( right ) )
		{
			return isGeneralizationOfCompositeSoqlable( right, left );
		}
		else if( isUnsoqlable( left ) )
		{
			return isGeneralizationOfUnsoqlable( left, right );
		}
		else if( isUnsoqlable( right ) )
		{
			return isGeneralizationOfUnsoqlable( right, left );
		}
*/
		return false;
	}

	global Boolean isSpecialCaseOf( SObjectSpecification left, SObjectSpecification right )
	{
		return false;
	}
}
