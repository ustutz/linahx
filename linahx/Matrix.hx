package linahx;
import haxe.ds.Vector;

/**
 * ...
 * @author Urs Stutz
 */
class Matrix {
	
	static inline var CHARCODE_NEWLINE:String = String.fromCharCode(10);
	static inline var CR:String = String.fromCharCode(13);
	
	public var rows:Int;
	public var columns:Int;
	
	public var data:Vector<Vector<Float>>;

	public static function fromCSV( csvString:String, columnSeparator:String, rowSeparator:String = CHARCODE_NEWLINE ):Matrix {
		
		return Matrix.fromString( csvString, columnSeparator, rowSeparator );
	}
	
	// create Matrix from String. Matlab uses ',' as separator for the column and ';' as separator for rows
	public static function fromString( string:String, columnSeparator:String = ",", rowSeparator:String = ";" ):Matrix {
		
		string = StringTools.replace( string, CR, "" );
		
		var stringMatrix = new Array<Array<String>>();
		
		var rowElementsNumber = -1;
		
		var lines = string.split( rowSeparator );
		for( i in 0...lines.length ) {
			var lineArray = lines[i].split( columnSeparator );
			stringMatrix.push( lineArray );
			
			var currentRowElementsNumber = lineArray.length;
			
			if ( rowElementsNumber == -1 ) {
				rowElementsNumber = currentRowElementsNumber;
			} else {
				if ( currentRowElementsNumber != rowElementsNumber ) {
					trace( "Warning: Line " + i + " has a different number of elements." );
					if ( currentRowElementsNumber > rowElementsNumber ) {
						rowElementsNumber = currentRowElementsNumber;
					}
				}
			}
			//trace( "rowElementsNumber " + rowElementsNumber );
		}
		
		if( stringMatrix.length > 0 ) {
			
			var matrix = new Matrix( stringMatrix.length, rowElementsNumber );
			var rows = stringMatrix.length;
			var columns = stringMatrix[0].length;
			
			var data = new Vector<Vector<Float>>( rows );
			for ( row in 0...rows ) {
				
				for ( column in 0...stringMatrix[row].length ) {
					matrix.data[row][column] = Std.parseFloat( stringMatrix[row][column] );
				}
			}
			return matrix;
			
		} else {
			return null;
		}
	}
	
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
/*	
	[[1 3 2]
	 [4 0 1]]
	 
	 x
	 
	[[1]
	 [0]
	 [5]]
	
	= 1*1 + 3*0 + 2*5
	  4*1 + 0*0 + 1*5
	
	= [[11]
	   [ 9]]
	   
*/	
	public function dot( otherMatrix:Matrix ):Matrix {
		
		if ( columns != otherMatrix.rows ) {
			throw "Error: 2nd matrix must have " + columns + " rows.";
		}
		
		var resultMatrix = new Matrix(rows, otherMatrix.columns );
		
		for( otherColumn in 0...otherMatrix.columns ) {
			for ( row in 0...rows ) {
				
				trace( "data[" + row +"][" + otherColumn + "] = " );
				
				var sum = 0.0;
				for ( column in 0...columns ) {
					
					var otherRow = column;
					var multiplication = data[row][column] * otherMatrix.data[otherRow][otherColumn];
					trace( "+ " + multiplication );
					sum += multiplication;
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