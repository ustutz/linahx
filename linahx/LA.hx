package linahx;

/**
 * ...
 * @author Urs Stutz
 */
class LA {

	public static function eye( n:Int ):Matrix<Int> {
		
		var e = new Matrix<Int>( n, n, 0 );
		for ( i in 0...n ) {
			e.data[i][i] = 1;
		}
		return e;
	}
	
}