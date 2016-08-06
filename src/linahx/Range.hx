package linahx;
import haxe.ds.Vector;

/**
 * ...
 * @author Urs Stutz
 */
class Range {

	public static function int( start:Int, end:Int, step:Int = 1 ):Array<Int> {
		
		var elementNumber = Std.instance((end - start ) / step);
		var range = new Vector<Int>( elementNumber );
		
		while( i < end ) {
			
			range[i - start] = i;
			i += step;
		}
		
		return range.toArray();
	}
}