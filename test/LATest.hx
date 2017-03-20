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
		
		Assert.isTrue( matrix0[1][1] == 0 );
		
	}
	
	@Test
	public function testOnes():Void {
		
		var matrix0 = LA.ones( 3, 2 );
		Assert.isTrue( matrix0.rows == 3 );
		Assert.isTrue( matrix0.columns == 2 );
		
		Assert.isTrue( matrix0[1][1] == 1 );
		
	}
	
	@Test
	public function testEye():Void {
		
		var matrix0 = LA.eye( 3 );
		Assert.isTrue( matrix0.rows == 3 );
		Assert.isTrue( matrix0.columns == 3 );
		
		Assert.isTrue( matrix0[0][1] == 0 );
		Assert.isTrue( matrix0[1][1] == 1 );
		
	}
	
	@Test
	public function testRand():Void {
		
		var matrix0 = LA.rand( 2, 5 );
		Assert.isTrue( matrix0.rows == 2 );
		Assert.isTrue( matrix0.columns == 5 );
		
		Assert.isTrue( matrix0[0][1] >= 0 );
		Assert.isTrue( matrix0[0][1] < 1 );
		
	}
	
	@Test
	public function testDot():Void {
		
		var matrix1 = Matrix.fromString( "1 2 3; 4 5 6" );
		var matrix2 = Matrix.fromString( "1; 2; 3" );
		
		var dotMatrix = LA.dot( matrix1, matrix2 );
		
		Assert.isTrue( dotMatrix.rows == 2 );
		Assert.isTrue( dotMatrix.columns == 1 );
		Assert.isTrue( dotMatrix[0][0] == 14 );
		Assert.isTrue( dotMatrix[1][0] == 32 );
	}
	
	@Test
	public function testMultiply():Void {
		
		var matrix1 = Matrix.fromString( "1 2 3; 4 5 6" );
		var matrix2 = Matrix.fromString( "2 2 2; 3 3 3" );
		
		var dotMatrix = LA.multiply( matrix1, matrix2 );
		
		Assert.isTrue( dotMatrix.rows == 2 );
		Assert.isTrue( dotMatrix.columns == 3 );
		Assert.isTrue( dotMatrix[0][0] == 2 );
		Assert.isTrue( dotMatrix[1][2] == 18 );
	}
	
	@Test
	public function testSize():Void {
		var matrix0 = new Matrix( 3, 2, 0 );
		Assert.isTrue( LA.size( matrix0 ) == 6 );
	}
	
	@Test
	public function testShape():Void {
		
		var matrix1 = Matrix.fromString( "1 2 3; 4 5 6" );
		var shapeMatrix = LA.shape( matrix1 );
		
		Assert.isTrue( shapeMatrix.rows == 1 );
		Assert.isTrue( shapeMatrix.columns == 2 );
		Assert.isTrue( shapeMatrix[0][1] == 3 );
	}
	
	@Test
	public function testSumToFloat():Void {
		
		var matrix1 = Matrix.fromString( "1 3 2;4 0 1" );
		var sumMatrix1 = LA.sumToFloat( matrix1 );
		Assert.isTrue( sumMatrix1 == 11 );
		
		var matrix2 = Matrix.fromString( "1;0;5" );
		var sumMatrix2 = LA.sumToFloat( matrix2 );
		Assert.isTrue( sumMatrix2 == 6 );
		
		var matrix3 = Matrix.fromString( "1 0 5" );
		var sumMatrix3 = LA.sumToFloat( matrix3 );
		Assert.isTrue( sumMatrix3 == 6 );

		var matrix4 = Matrix.fromString( "1" );
		var sumMatrix4 = LA.sumToFloat( matrix4 );
		Assert.isTrue( sumMatrix4 == 1 );

	}
	

}