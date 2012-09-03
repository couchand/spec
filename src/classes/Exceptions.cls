global virtual class Exceptions
{
	global class UnimplementedFeatureException extends Exception {}

	global class SpecificationException extends Exception {}

	global class UngeneralizableSpecificationException extends SpecificationException {}
	global class   UnnegatabableSpecificationException extends SpecificationException {}
	global class   UnsatisfiableSpecificationException extends SpecificationException {}
	global class      UnsoqlableSpecificationException extends SpecificationException {}
}
