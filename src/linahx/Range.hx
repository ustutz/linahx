package linahx;
import haxe.ds.Vector;

/**
 * ...
 * @author Urs Stutz
 */
class Range {

	public static function int( start:Int, end:Int, step:Int = 1 ):Array<Int> {
		
		var length = Std.int((end - start ) / step ); trace( "length " + length );
		var range = new Vector<Int>( length );
		
		var i = start;
		while( i < end ) {
			
			trace( "assign " + i + " to element " + (i - start ));
			range[i - start] = i;
			i += step;
		}
		
		return range.toArray();
	}
}