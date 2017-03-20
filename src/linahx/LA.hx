package linahx;

class LA {

	public static function column_stack( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.concatenate( matrix2, 1 );
	}
	
	public static function concatenate( matrix1:Matrix, matrix2:Matrix, dimension:Int = 0 ):Matrix {
		return matrix1.concatenate( matrix2, dimension );
	}
	
	public static function divide( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1 / matrix2;
	}
	
	public static function dot( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.dot( matrix2 );
	}
	
	public static function eye( n:Int ):Matrix {
		
		var e = new Matrix( n, n, 0 );
		for ( i in 0...n ) {
			e[i][i] = 1;
		}
		return e;
	}
	
	public static function hstack( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.concatenate( matrix2, 1 );
	}
	
	public static function multiply( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.multiply( matrix2 );
	}
	
	public static function ones( rows:Int, columns:Int ):Matrix {
		return new Matrix( rows, columns, 1 );
	}
	
	public static function pow( matrix1:Matrix, exp:Float ):Matrix {
		return matrix1.pow( exp );
	}
	
	public static function power( matrix1:Matrix, exp:Float ):Matrix {
		return matrix1.pow( exp );
	}
	
	public static function rand( rows:Int, columns:Int ):Matrix {
		
		var r = new Matrix( rows, columns, 0.0 );
		for ( row in 0...r.rows ) {
			for ( column in 0...r.columns ) {
				r[row][column] = Math.random();
			}
		}
		return r;
	}
	
	public static function row_stack( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.concatenate( matrix2 );
	}
	
	public static function sadd( matrix1:Matrix, value:Float ):Matrix {
		return matrix1.sadd( value );
	}
	
	public static function sdivide( matrix1:Matrix, value:Float ):Matrix {
		return matrix1.sdivide( value );
	}
	
	public static function shape( matrix:Matrix, ?dimension ):Matrix {
		return matrix.shape( dimension );
	}
	
	public static function smultiply( matrix1:Matrix, value:Float ):Matrix {
		return matrix1.smultiply( value );
	}
	
	public static function ssubtract( matrix1:Matrix, value:Float ):Matrix {
		return matrix1.ssubtract( value );
	}
	
	public static function size( matrix:Matrix ):Int {
		return matrix.siz;
	}
	
	public static function sum( matrix:Matrix, ?dimension ):Matrix {
		return matrix.sum( dimension );
	}
	
	public static function sumToFloat( matrix:Matrix ):Float { //trace( "sumToFloat" );
		
		if ( matrix.columns == 0 && matrix.rows == 0 ) { //trace( "matrix.columns == 0 && matrix.rows == 0" );
			return 0;
		} if ( matrix.columns == 1 && matrix.rows == 1 ) { //trace( "matrix.columns == 1 && matrix.rows == 1" );
			return matrix[0][0];
		} else {
			if ( matrix.rows > 1 ) { //trace( "matrix.rows > 1" );
				matrix = matrix.sum( 0 );
			}
			if ( matrix.columns > 1 ) { //trace( "matrix.columns > 1" );
				matrix = matrix.sum( 1 );
			}
			return matrix[0][0];
		}
	}
	
	public static function vstack( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.concatenate( matrix2 );
	}
	
	public static function zeros( rows:Int, columns:Int ):Matrix {
		return new Matrix( rows, columns, 0 );
	}
	
}