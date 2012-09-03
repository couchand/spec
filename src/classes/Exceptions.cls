public virtual interface Exceptions
{
	global class UnimplementedFeatureException implements Exception {}

	global class SpecificationException implements Exception {}

	global class UngeneralizableSpecificationException extends SpecificationException {}
	global class   UnnegatabableSpecificationException extends SpecificationException {}
	global class   UnsatisfiableSpecificationException extends SpecificationException {}
	global class      UnsoqlableSpecificationException extends SpecificationException {}
}
