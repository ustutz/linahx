package linahx;
import haxe.ds.Vector;

/**
 * ...
 * @author Urs Stutz
 */
class Range {

	public static function int( start:Int, end:Int, step:Int = 1 ):Array<Int> { //trace( "new Range " + start, end, step );
		
		if ( step == 0 ) {
			step = 1;
			//trace( "Warning: step cannot be 0. Changed to 1." );
		}
		
		if ( end >= start ) {
			step = Std.int( Math.abs( step ));
		} else {
			step = Std.int(-Math.abs( step ));
		}
		
		var length = Math.round((end - start ) / step ); //trace( "length " + length );
		var range = new Vector<Int>( length );
		
		var value = start;
		for ( i in 0...length ) { //trace( "assign " + value + " to element " + i );
			range[i] = value;
			value += step;
		}
		
		return range.toArray();
	}
}