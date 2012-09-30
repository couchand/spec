// A test to illustrate the Ambiguous Method Signature
// error in the Apex compiler.  Uncomment line 45 and
// attempt to push to Salesforce to see the error.

// Because the function call is resolved at compile-time,
// rather than at runtime as in a true polymorphic language,
// the compiler is unable to determine the appropriate
// version of the method to call.

public class PolymorphismTest2
{
	public interface Animal
	{
		void encounter( Animal other );
	}

	public virtual class Dog implements Animal
	{
		public virtual void encounter( Animal other )
		{
			// ignore
		}

		public virtual void encounter( Dog otherDog )
		{
			throw new BarkException();
		}
	}

	public virtual class BigDog extends Dog {}

	public virtual class SqueakyDog extends Dog
	{
		public virtual void encounter( BigDog otherDog )
		{
			throw new SqueakException();
		}
	}

	private static testMethod void testEncounters()
	{
		Dog squeakyDogTypedAsDog = new SqueakyDog();
		BigDog bigDog = new BigDog();

		//squeakyDogTypedAsDog.encounter( bigDog );
	}

	public virtual class BarkException extends Exception {}
	public virtual class SqueakException extends BarkException {}
}