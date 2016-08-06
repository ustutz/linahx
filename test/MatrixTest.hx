package;

import linahx.LA;
import linahx.Matrix;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class MatrixTest {
	
	public function new() {	}
	
	@Test
	public function testZeros():Void {
		
		var matrix0 = new Matrix( 3, 2, 0 );
		Assert.isTrue( matrix0.siz == 6 );
	}
	

}