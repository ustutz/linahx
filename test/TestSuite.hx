import massive.munit.TestSuite;

import LATest;
import MatrixCreationTest;
import MatrixTest;
import RangeTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(LATest);
		add(MatrixCreationTest);
		add(MatrixTest);
		add(RangeTest);
	}
}
