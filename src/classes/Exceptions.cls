global virtual class Exceptions
{
	global virtual class UnimplementedFeatureException extends Exception {}

	global virtual class SpecificationException extends Exception {}

	global virtual class UngeneralizableSpecificationException extends SpecificationException {}
	global virtual class    UnnegateableSpecificationException extends SpecificationException {}
	global virtual class   UnsatisfiableSpecificationException extends SpecificationException {}
	global virtual class      UnsoqlableSpecificationException extends SpecificationException {}
}
