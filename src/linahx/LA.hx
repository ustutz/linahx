package linahx;

/**
 * ...
 * @author Urs Stutz
 */
class LA {

	public static function column_stack( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.concatenate( matrix2, 1 );
	}
	
	public static function concatenate( matrix1:Matrix, matrix2:Matrix, dimension:Int = 0 ):Matrix {
		return matrix1.concatenate( matrix2, dimension );
	}
	
	public static function divide( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.divide( matrix2 );
	}
	
	public static function dot( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.dot( matrix2 );
	}
	
	public static function eye( n:Int ):Matrix {
		
		var e = new Matrix( n, n, 0 );
		for ( i in 0...n ) {
			e.data[i][i] = 1;
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
	
	public static function power( matrix1:Matrix, exp:Float ):Matrix {
		return matrix1.power( exp );
	}
	
	public static function rand( rows:Int, columns:Int ):Matrix {
		
		var r = new Matrix( rows, columns, 0.0 );
		for ( row in 0...r.rows ) {
			for ( column in 0...r.columns ) {
				r.data[row][column] = Math.random();
			}
		}
		return r;
	}
	
	public static function row_stack( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.concatenate( matrix2 );
	}
	
	public static function sdivide( matrix1:Matrix, value:Float ):Matrix {
		return matrix1.sdivide( value );
	}
	
	public static function smultiply( matrix1:Matrix, value:Float ):Matrix {
		return matrix1.smultiply( value );
	}
	
	public static function size( matrix:Matrix ):Int {
		return matrix.siz;
	}
	
	public static function shape( matrix:Matrix, ?dimension ):Matrix {
		return matrix.shape( dimension );
	}
	
	public static function sum( matrix:Matrix, ?dimension ):Matrix {
		return matrix.sum( dimension );
	}
	
	public static function vstack( matrix1:Matrix, matrix2:Matrix ):Matrix {
		return matrix1.concatenate( matrix2 );
	}
	
	public static function zeros( rows:Int, columns:Int ):Matrix {
		return new Matrix( rows, columns, 0 );
	}
	
}