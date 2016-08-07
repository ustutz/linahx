package;

import linahx.LA;
import linahx.Matrix;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class MatrixTest {
	
	public function new() {	}
	
	@Test
	public function testSum():Void {
		
		var matrix1 = Matrix.fromString( "1 3 2;4 0 1" );
		
		var autoSumMatrix1 = matrix1.sum();
		Assert.isTrue( autoSumMatrix1.rows == 1 );
		Assert.isTrue( autoSumMatrix1.columns == 3 );
		Assert.isTrue( autoSumMatrix1.data[0][0] == 5 );
		
		var columnSumMatrix1 = matrix1.sum( 0 );
		Assert.isTrue( columnSumMatrix1.rows == 1 );
		Assert.isTrue( columnSumMatrix1.columns == 3 );
		Assert.isTrue( columnSumMatrix1.data[0][0] == 5 );
		
		var rowSumMatrix1 = matrix1.sum( 1 );
		Assert.isTrue( rowSumMatrix1.rows == 2 );
		Assert.isTrue( rowSumMatrix1.columns == 1 );
		Assert.isTrue( rowSumMatrix1.data[0][0] == 6 );
		
		
		var matrix2 = Matrix.fromString( "1;0;5" );
		
		var autoSumMatrix2 = matrix2.sum();
		Assert.isTrue( autoSumMatrix2.rows == 1 );
		Assert.isTrue( autoSumMatrix2.columns == 1 );
		Assert.isTrue( autoSumMatrix2.data[0][0] == 6 );
		
		var columnSumMatrix2 = matrix2.sum( 0 );
		Assert.isTrue( columnSumMatrix2.rows == 1 );
		Assert.isTrue( columnSumMatrix2.columns == 1 );
		Assert.isTrue( columnSumMatrix2.data[0][0] == 6 );
		
		var rowSumMatrix2 = matrix2.sum( 1 );
		Assert.isTrue( rowSumMatrix2.rows == 3 );
		Assert.isTrue( rowSumMatrix2.columns == 1 );
		Assert.isTrue( rowSumMatrix2.data[0][0] == 1 );
		
		
		var matrix3 = Matrix.fromString( "1 0 5" );

		var autoSumMatrix3 = matrix3.sum();
		Assert.isTrue( autoSumMatrix3.rows == 1 );
		Assert.isTrue( autoSumMatrix3.columns == 1 );
		Assert.isTrue( autoSumMatrix3.data[0][0] == 6 );
		
		var columnSumMatrix3 = matrix3.sum( 0 );
		Assert.isTrue( columnSumMatrix3.rows == 1 );
		Assert.isTrue( columnSumMatrix3.columns == 3 );
		Assert.isTrue( columnSumMatrix3.data[0][0] == 1 );
		
		var rowSumMatrix3 = matrix3.sum( 1 );
		Assert.isTrue( rowSumMatrix3.rows == 1 );
		Assert.isTrue( rowSumMatrix3.columns == 1 );
		Assert.isTrue( rowSumMatrix3.data[0][0] == 6 );
		
		
		var matrix4 = Matrix.fromString( "1" );

		var autoSumMatrix4 = matrix4.sum();
		Assert.isTrue( autoSumMatrix4.rows == 1 );
		Assert.isTrue( autoSumMatrix4.columns == 1 );
		Assert.isTrue( autoSumMatrix4.data[0][0] == 1 );
		
		var columnSumMatrix4 = matrix4.sum( 0 );
		Assert.isTrue( columnSumMatrix4.rows == 1 );
		Assert.isTrue( columnSumMatrix4.columns == 1 );
		Assert.isTrue( columnSumMatrix4.data[0][0] == 1 );
		
		var rowSumMatrix4 = matrix4.sum( 1 );
		Assert.isTrue( rowSumMatrix4.rows == 1 );
		Assert.isTrue( rowSumMatrix4.columns == 1 );
		Assert.isTrue( rowSumMatrix4.data[0][0] == 1 );
		
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
	public function testSubtract():Void {
		
		var matrix1 = LA.zeros( 2, 3 );
		var matrix2 = LA.ones( 2, 3 );
		
		var addedMatrix = matrix1.subtract( matrix2 );
		Assert.isTrue( addedMatrix.data[0][0] == -1 );
		
		var scalarAddedMatrix = matrix1.ssubtract( 4 );
		Assert.isTrue( scalarAddedMatrix.data[0][0] == -4 );
		
	}
	
	@Test
	public function testTranspose():Void {
		
		var matrix = Matrix.fromString( "1 2 3; 4 5 6" );
		var transposedMatrix = matrix.transpose();
		
		Assert.areEqual( matrix.rows, transposedMatrix.columns );
		Assert.areEqual( matrix.columns, transposedMatrix.rows );
		Assert.areEqual( matrix.data[0][1], transposedMatrix.data[1][0] );
		
	}
	
	@Test
	public function testZeros():Void {
		
		var matrix0 = new Matrix( 3, 2, 0 );
		Assert.isTrue( matrix0.siz == 6 );
	}
	
}