package;

import linahx.Matrix;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class MatrixCreationTest {
	
	public function new() {	}
	
	@Test
	public function testNewMatrix():Void {
		
		var matrix0 = new Matrix( 0, 0, 0 );
		Assert.isTrue( matrix0.rows == 0 );
		Assert.isTrue( matrix0.columns == 0 );
		Assert.isTrue( matrix0.data.length == 0 );
		
		
		var matrix1 = new Matrix( 3, 2, 0 );
		Assert.isTrue( matrix1.rows == 3 );
		Assert.isTrue( matrix1.columns == 2 );
		Assert.isTrue( matrix1.data[0][0] == 0 );
		
	}
	
	@Test
	public function testFromArray1():Void {
		
		var matrix0 = Matrix.fromArray1( [] );
		Assert.isTrue( matrix0.rows == 0 );
		Assert.isTrue( matrix0.columns == 0 );
		Assert.isTrue( matrix0.data.length == 0 );
		
		
		var matrix1 = Matrix.fromArray1( [1] );
		Assert.isTrue( matrix1.rows == 1 );
		Assert.isTrue( matrix1.columns == 1 );
		Assert.isTrue( matrix1.data[0][0] == 1 );
		
		
		var matrix2 = Matrix.fromArray1( [1, 2, 3, 4] );
		Assert.isTrue( matrix2.rows == 1 );
		Assert.isTrue( matrix2.columns == 4 );
		Assert.isTrue( matrix2.data[0][2] == 3 );
		
	}

	@Test
	public function testFromArray2():Void {
		
		var matrix0 = Matrix.fromArray2( [] );
		Assert.isTrue( matrix0.rows == 0 );
		Assert.isTrue( matrix0.columns == 0 );
		Assert.isTrue( matrix0.data.length == 0 );
		
		var matrix1 = Matrix.fromArray2( [[1]] );
		Assert.isTrue( matrix1.rows == 1 );
		Assert.isTrue( matrix1.columns == 1 );
		Assert.isTrue( matrix1.data[0][0] == 1 );
		
		var matrix2 = Matrix.fromArray2( [[1, 2, 3]] );
		Assert.isTrue( matrix2.rows == 1 );
		Assert.isTrue( matrix2.columns == 3 );
		Assert.isTrue( matrix2.data[0][2] == 3 );
		
		var matrix3 = Matrix.fromArray2( [[1],[2],[3]] );
		Assert.isTrue( matrix3.rows == 3 );
		Assert.isTrue( matrix3.columns == 1 );
		Assert.isTrue( matrix3.data[2][0] == 3 );
		
		var matrix3 = Matrix.fromArray2( [[1, 2],[3, 4],[5, 6]] );
		Assert.isTrue( matrix3.rows == 3 );
		Assert.isTrue( matrix3.columns == 2 );
		Assert.isTrue( matrix3.data[1][1] == 4 );
		
	}
	
	@Test
	public function testFromString():Void {
		
		var matrix0 = Matrix.fromString( "" );
		Assert.isTrue( matrix0.rows == 0 );
		Assert.isTrue( matrix0.columns == 0 );
		Assert.isTrue( matrix0.data.length == 0 );
		
		var matrix1 = Matrix.fromString( "  " );
		Assert.isTrue( matrix1.rows == 0 );
		Assert.isTrue( matrix1.columns == 0 );
		Assert.isTrue( matrix1.data.length == 0 );
		
		var matrix2 = Matrix.fromString( "x" );
		Assert.isTrue( matrix2.rows == 1 );
		Assert.isTrue( matrix2.columns == 1 );
		
		var matrix3 = Matrix.fromString( "1 2 3" );
		Assert.isTrue( matrix3.rows == 1 );
		Assert.isTrue( matrix3.columns == 3 );
		Assert.isTrue( matrix3.data[0][2] == 3 );
		
		var matrix4 = Matrix.fromString( "1 2 3; 4 5 6" );
		Assert.isTrue( matrix4.rows == 2 );
		Assert.isTrue( matrix4.columns == 3 );
		Assert.isTrue( matrix4.data[1][2] == 6 );
		
		var matrix5 = Matrix.fromString( "1, 2, 3\n 4, 5, 6", ",", "\n" );
		Assert.isTrue( matrix5.rows == 2 );
		Assert.isTrue( matrix5.columns == 3 );
		Assert.isTrue( matrix5.data[1][2] == 6 );
		
	}
	
	@Test
	public function testCopy():Void {
		
		var matrix0 = new Matrix( 3, 2, 0 );
		var matrixCopy = matrix0.copy();
		
		Assert.isTrue( matrixCopy.rows == 3 );
		Assert.isTrue( matrixCopy.columns == 2 );
		
		matrixCopy.data[0][0] = 1;
		Assert.areNotEqual( matrix0.data[0][0], matrixCopy.data[0][0] );
	}
		

}