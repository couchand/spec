global class PolymorphismTest
{
	global virtual class Grandparent
	{
		global virtual void accept( Visitor v )
		{
			v.visit( this );
		}
	}

	global virtual class Parent extends Grandparent
	{
	}

	global virtual class Child extends Parent
	{
	}

	global abstract class Visitor
	{
		global Integer gVisits = 0, pVisits = 0, cVisits = 0;

		global virtual void visit( Grandparent g )
		{
			gVisits++;
		}
	}

	global virtual class VisitorChild extends Visitor
	{
		global virtual override void visit( Grandparent g )
		{
			if( g instanceof Child ) this.visit( (Child)g );
			else if( g instanceof Parent ) this.visit( (Parent)g );
			else super.visit( g );
		}

		global virtual void visit( Parent p )
		{
			pVisits++;
		}

		global virtual void visit( Child c )
		{
			cVisits++;
		}
	}

	private static testMethod void testVisitor()
	{
		Grandparent g, p, c;

		g = new Grandparent();
		p = new Parent();
		c = new Child();

		Visitor v = new VisitorChild();

		Test.startTest();

			g.accept( v );
			p.accept( v );
			c.accept( v );

		Test.stopTest();

		System.assertEquals( 1, v.gVisits );
		System.assertEquals( 1, v.pVisits );
		System.assertEquals( 1, v.cVisits );
	}

	private static testMethod void testVisitorChild()
	{
		Grandparent g, p, c;

		g = new Grandparent();
		p = new Parent();
		c = new Child();

		VisitorChild v = new VisitorChild();

		Test.startTest();

			g.accept( v );
			p.accept( v );
			c.accept( v );

		Test.stopTest();

		System.assertEquals( 1, v.gVisits );
		System.assertEquals( 1, v.pVisits );
		System.assertEquals( 1, v.cVisits );
	}
}