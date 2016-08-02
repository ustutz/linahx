package linahx;
import haxe.ds.Vector;

/**
 * ...
 * @author Urs Stutz
 */
class Matrix<T> {
	
	public var columns:Int;
	public var rows:Int;
	
	public var data:Vector<Vector<T>>;

	public function new( columns:Int, rows:Int, defaultvalue:T ) {
		this.rows = rows;
		this.columns = columns;
		
		data = new Vector<Vector<T>>(columns);
		for ( column in 0...columns ) {
			data[column] = new Vector<T>(rows);
			for ( row in 0...rows ) {
				data[column][row] = defaultvalue;
			}
		}
	}
	
	
	
	public function toString():String {
		
		var s = "[";
		for ( column in 0...columns ) {
			s += column == 0 ? "[" : " [";
			for( row in 0...rows ) {
				s += Std.string( data[column][row] ) + "   "; 
			}
			s += column == columns-1 ? "]" : "]\n";
		}
		s += "]\n";
		
		return s;
	}
}