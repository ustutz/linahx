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
	
	@Test
	public function testLength():Void {
		
		var matrix0 = new Matrix( 3, 2, 0 );
		Assert.isTrue( matrix0.length == 3 );
		
		var matrix1 = new Matrix( 2, 4, 0 );
		Assert.isTrue( matrix1.length == 4 );
	}
	

}