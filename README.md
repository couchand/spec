Spec
====

An implementation of the specification pattern in Apex


 * License
 * Overview of Specification Pattern
 * How To Use Specifications
 * Further Reading
 * Implementation Specifics


License
-------

This project is released under the MIT/X11 license.
Please see the file LICENSE for details.

Overview of Specification Pattern
---------------------------------

A Specification is a pattern to describe a minimum set of
acceptable criteria for an object.  It is used for three
primary purposes: validation, selection, and making-to-
order.

In the context of Apex, this pattern is applied to
SObjects.  In particular, this means:

 * validation - ensure an SObject meets particular criteria
 * selection - query for SObjects meeting those criteria
 * making-to-order - construct SObjects that meet the criteria

The library provides functionality around a core subset
of all possible specifications, namely those that are
expressable in a SOQL statement.

In addition to these basic uses of Specifications, the
library provides subsumption checking, that is, whether
a given Specification is a generalization or special
case of another.

How To Use Specifications
-------------------------

The selection use of Specifications is probably the
quickest to directly apply to your existing Apex code.
Any time you would directly make a query, instead
develop an appropriate Specification.  This encourages
the use of reusable code.

Previously...

	List<Opportunity> opportunities = [SELECT Id FROM Opportunity WHERE Amount > 5.0 AND StageName = 'Closed/Won'];

Now...

	spec.SObjectSpecification opportunitySpec = new spec.Type( 'Opportunity' );
	spec.SObjectSpecification amountMoreThanFive = new spec.FieldGreaterThan( 'Amount', 5.0 );
	spec.SObjectSpecification stageClosedWon = new spec.FieldEqual( 'StageName', 'Closed/Won' );
	spec.SObjectSpecification interestingOpportunitySpec = opportunitySpec.and( amountMoreThanFive ).and( stageClosedWon );

	List<Opportunity> opportunities = interestingOpportunitySpec.findSatisfiers();

They also make short work of trigger filtering.

Previously...

	List<Opportunity> interestingOpportunities = new List<Opportunity>();

	for( Opportunity anOpportunity : Trigger.new )
	{
		if( anOpportunity.Amount > 5.0 && anOpportunity.StageName == 'Closed/Won' )
		{
			interestingOpportunities.add( anOpportunity );
		}
	}

	doSomethingImportant( interestingOpportunities );

Now...

	List<Opportunity> interestingOpportunties = interestingOpportunitySpec.findSatisfiers( Trigger.new );
	doSomethingImportant( interestingOpportunities );

Further Reading
---------------

 * Specifications, Martin Fowler, [martinfowler.com/apsupp/spec.pdf](http://martinfowler.com/apsupp/spec.pdf)
 * Domain-Driven Design, Eric Evans, 2004, pages 224-229 & 273-281

Implementation Specifics
------------------------

The subsumption methods isGeneralization of and
isSpecialCaseOf are implemented using the Visitor pattern,
as suggested by	Fowler and Evans.  Because the polymorphic
capabilities of Apex are quite limited, the double
dispatch is necessarily performed by an external dispatch
class.  One such dispatcher exists for each level of the
inheritance hierarchy, so all calls to the subsumption
methods go through a ping-pong down the hierarchy.

	  BaseSpecification lessThanFive =
	    new FieldLessThanSpecification( 'Amount', 5.0 );
	  BaseSpecification lessThanThree =
	    new FieldLessThanSpecification( 'Amount', 3.0 );

	> lessThanThree.isSpecialCaseOf( lessThanFive );
	  > (new BaseDispatcher()).isSpecialCaseOf( lessThanThree, lessThanFive );
	    > ((SoqlableSpecification)lessThanThree).isSpecialCaseOf( (SoqlableSpecification)lessThanFive );
	      > (new SoqlableDispatcher()).isSpecialCaseOf( lessThanThree, lessThanFive );
		> ((FieldBoundSpecification)lessThanThree).isSpecialCaseOf( (FieldBoundSpecification)lessThanFive );
		  > (new FieldBoundDispatcher()).isSpecialCaseOf( lessThanFive );
		    > ((FieldLessThanSpecification)lessThanThree).isSpecialCaseOfDispatch( (FieldLessThanSpecification)lessThanFive );
		      > return lessThanThree.bound < lessThanFive.bound;
	> true

Except I think Apex at least resolves the class of the
callee, so it probably is simply this.

	> lessThanThree.isSpecialCaseOf( lessThanFive );
	  > (new FieldBoundDispatcher()).isSpecialCaseOf( lessThanFive );
	    > ((FieldLessThanSpecification)lessThanThree).isSpecialCaseOfDispatch( (FieldLessThanSpecification)lessThanFive );
	      > return lessThanThree.bound < lessThanFive.bound;
	> true

That is, unless we only implement the husk subsumption
methods on BaseSpecification and do the ping-pong.
