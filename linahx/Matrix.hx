package linahx;
import haxe.ds.Vector;

/**
 * ...
 * @author Urs Stutz
 */
class Matrix {
	
	public var rows:Int;
	public var columns:Int;
	
	public var data:Vector<Vector<Float>>;

	public function new( rows:Int, columns:Int, ?defaultvalue:Float ) {
		
		this.rows = rows;
		this.columns = columns;
		
		data = new Vector<Vector<Float>>( rows );
		for ( row in 0...rows ) {
			data[row] = new Vector<Float>(columns);
			
			if( defaultvalue != null ) {
				for ( column in 0...columns ) {
					data[row][column] = defaultvalue; //trace( "row " + row + "  column " + column + "  set to " + defaultvalue );
				}
			}
		}
	}
	
	public function transpose():Matrix {
		
		var transposedColumns = rows;
		var transposedRows = columns;
		
		var transposedMatrix = new Matrix( transposedColumns, transposedRows );
		for ( column in 0...transposedColumns ) {
			for ( row in 0...transposedRows ) {
				transposedMatrix.data[column][row] = data[row][column];
			}
		}
		return transposedMatrix;
	}
	
	public function dot( otherMatrix:Matrix ):Matrix {
		
		if ( columns != otherMatrix.rows ) {
			throw "Error: matrix must have " + columns + " rows.";
		}
		
		var resultMatrix = new Matrix(rows, otherMatrix.columns );
		
		for( otherColumn in 0...otherMatrix.columns ) {
			for ( row in 0...rows ) {
				var sum = 0.0;
				for ( column in 0...columns ) {
					for ( otherRow in 0...otherMatrix.rows ) {
						sum += data[row][column] * otherMatrix.data[otherRow][0];
					}
				}
				resultMatrix.data[row][otherColumn] = sum;
			}
		}
		
		return resultMatrix;
	}
	
	public function toString():String {
		
		var s = "[";
		for ( row in 0...rows ) {
			s += row == 0 ? "[" : " [";
			for( column in 0...columns ) {
				s += Std.string( data[row][column] ) + ( column<columns-1 ? "   " : "" ); 
			}
			s += row == rows-1 ? "]" : "]\n";
		}
		s += "]\n";
		
		return s;
	}
	
}