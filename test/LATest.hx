package;

import linahx.LA;
import linahx.Matrix;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class LATest {
	
	public function new() {	}
	
	@Test
	public function testZeros():Void {
		
		var matrix0 = LA.zeros( 3, 2 );
		Assert.isTrue( matrix0.rows == 3 );
		Assert.isTrue( matrix0.columns == 2 );
		
		Assert.isTrue( matrix0.data[1][1] == 0 );
		
	}
	
	@Test
	public function testOnes():Void {
		
		var matrix0 = LA.ones( 3, 2 );
		Assert.isTrue( matrix0.rows == 3 );
		Assert.isTrue( matrix0.columns == 2 );
		
		Assert.isTrue( matrix0.data[1][1] == 1 );
		
	}
	
	@Test
	public function testEye():Void {
		
		var matrix0 = LA.eye( 3 );
		Assert.isTrue( matrix0.rows == 3 );
		Assert.isTrue( matrix0.columns == 3 );
		
		Assert.isTrue( matrix0.data[0][1] == 0 );
		Assert.isTrue( matrix0.data[1][1] == 1 );
		
	}
	
	@Test
	public function testRand():Void {
		
		var matrix0 = LA.rand( 2, 5 );
		Assert.isTrue( matrix0.rows == 2 );
		Assert.isTrue( matrix0.columns == 5 );
		
		Assert.isTrue( matrix0.data[0][1] >= 0 );
		Assert.isTrue( matrix0.data[0][1] < 1 );
		
	}
	

}