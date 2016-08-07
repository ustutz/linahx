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
	public function testConcatenate():Void {
	
		var matrix1 = LA.zeros( 1, 3 );
		var matrix2 = LA.ones( 2, 3 );
		var verticalConcatenatedMatrix = LA.concatenate( matrix1, matrix2 );
		
		Assert.isTrue( verticalConcatenatedMatrix.rows == 3 );
		Assert.isTrue( verticalConcatenatedMatrix.columns == 3 );
		Assert.isTrue( verticalConcatenatedMatrix.data[1][1] == 1 );
		
		var matrix3 = LA.zeros( 4, 1 );
		var matrix4 = LA.ones( 4, 2 );
		var horizontalConcatenatedMatrix = LA.concatenate( matrix3, matrix4, 1 );
		
		Assert.isTrue( horizontalConcatenatedMatrix.rows == 4 );
		Assert.isTrue( horizontalConcatenatedMatrix.columns == 3 );
		Assert.isTrue( horizontalConcatenatedMatrix.data[1][1] == 1 );
		
	}

	@Test
	public function testAdd():Void {
		
		var matrix1 = LA.zeros( 2, 3 );
		var matrix2 = LA.ones( 2, 3 );
		
		var addedMatrix = matrix1.add( matrix2 );
		Assert.isTrue( addedMatrix.data[0][0] == 1 );
		
		var scalarAddedMatrix = matrix1.sadd( 4 );
		Assert.isTrue( scalarAddedMatrix.data[0][0] == 4 );
		
	}
	
	@Test
	public function testSubtract():Void {
		
		var matrix1 = LA.zeros( 2, 3 );
		var matrix2 = LA.ones( 2, 3 );
		
		var addedMatrix = matrix1.subtract( matrix2 );
		Assert.isTrue( addedMatrix.data[0][0] == -1 );
		
		var scalarAddedMatrix = matrix1.ssubtract( 4 );
		Assert.isTrue( scalarAddedMatrix.data[0][0] == -4 );
		
	}
}