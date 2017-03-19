package linahx;
import haxe.ds.Vector;

abstract Matrix(Vector<Vector<Float>>) {
	
	public var rows(get, never):Int;
	public var columns(get, never):Int;
	
	public function get_rows():Int {
		return this.length;
	}
	
	public function get_columns():Int {
		return this[0].length;
	}
	
	public function new( rows:Int, columns:Int, ?defaultvalue:Float ) {
		
		this = new Vector<Vector<Float>>( rows );
		for ( row in 0...rows ) {
			this[row] = new Vector<Float>( columns );
			
			if( defaultvalue != null ) {
				for ( column in 0...columns ) {
					this[row][column] = defaultvalue;
				}
			}
		}
	}
	
	//
	// create matrix from String. Matlab uses ' ' as separator for the column and ';' as separator for rows
	// var matrix4 = Matrix.fromString( "1 2 3; 4 5 6" );
	//
	public static function fromString( string:String, columnSeparator:String = " ", rowSeparator:String = ";" ):Matrix {
		
 		string = StringTools.replace( string, String.fromCharCode(13), "" );
		string = StringTools.trim( string );
		
		while ( string.charAt( string.length - 1 ) == rowSeparator ) {
			string = string.substr( 0, string.length - 1 );
		}
		
		if ( string == "" ) {
			return new Matrix( 0, 0 );
		}
		
		var stringMatrix = new Array<Array<String>>();
		
		var lines = string.split( rowSeparator );
		for( i in 0...lines.length ) {
			lines[i] = StringTools.trim( lines[i] );
			
			if( columnSeparator == " " ) {
				var r = ~/  +/g; // replace spaces with regular expression
				lines[i] = r.replace( lines[i], " " );
			}
			
			var lineArray = lines[i].split( columnSeparator );
			stringMatrix.push( lineArray );
			
		}
		
		var columnsNumber = getColumnsNumber( stringMatrix );
		
		var matrix = new Matrix( stringMatrix.length, columnsNumber );
		var rows = stringMatrix.length;
		var columns = stringMatrix[0].length;
		
		var data = new Vector<Vector<Float>>( rows );
		for ( row in 0...rows ) {
			
			for ( column in 0...stringMatrix[row].length ) {
				matrix[row][column] = Std.parseFloat( stringMatrix[row][column] );
			}
		}
		return matrix;
			
	}
	
	//
	// get column number of a two-dimensional array, check if all rows have the same number of elements
	// - only used internally
	//
	static function getColumnsNumber( array:Array<Array<Dynamic>>):Int {
		
		var columnsNumber = 0;
		
		for( row in 0...array.length ) {
			
			var currentColumnNumber = array[row].length;
			
			if ( columnsNumber == 0 ) {
				columnsNumber = currentColumnNumber;
			} else {
				if ( currentColumnNumber != columnsNumber ) {
					trace( "Matrix.fromString Warning: Line " + row + " has a different number of elements." );
					if ( currentColumnNumber > columnsNumber ) {
						columnsNumber = currentColumnNumber;
					}
				}
			}
		}
		return columnsNumber;
	}
	
	@:arrayAccess
	public inline function get( i:Int ) {
		return this[i];
	}
	
	//
	// add value to matrix;
	//
	@:op( A + B )
	public static function addScalar( matrix:Matrix, value:Float ):Matrix {
		
		var resultMatrix = new Matrix( matrix.rows, matrix.columns );
		for ( row in 0...matrix.rows ) {
			for ( column in 0...matrix.columns ) {
				resultMatrix[row][column] = matrix[row][column] + value;
			}
		}
		return resultMatrix;
	}
	
	//
	// add two matrices;
	//
	@:op( A + B )
	public static function addMatrix( matrix1:Matrix, matrix2:Matrix ):Matrix {
		
		if ( matrix1.rows != matrix2.rows || matrix1.columns != matrix2.columns ) {
			throw( "Error: both matrices must have the same amount of columns and rows" );
		}
		
		var resultMatrix = new Matrix( matrix1.rows, matrix1.columns );
		for ( row in 0...matrix1.rows ) {
			for ( column in 0...matrix1.columns ) {
				resultMatrix[row][column] = matrix1[row][column] + matrix2[row][column];
			}
		}
		return resultMatrix;
	}
	
	//
	// return a copy of the matrix
	// var matrixCopy = matrix.copy();
	//
	public function copy():Matrix {
		
		var matrixCopy = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				matrixCopy[row][column] = this[row][column];
			}
		}
		return matrixCopy;
	}
	
	//
	// convert the matrix to a string
	//
	public function toString():String {
		
		var s = "[";
		for ( row in 0...rows ) {
			s += row == 0 ? "[" : " [";
			for( column in 0...columns ) {
				s += Std.string( this[row][column] ) + ( column<columns-1 ? "   " : "" ); 
			}
			s += row == rows-1 ? "]" : "]\n";
		}
		s += "]\n";
		
		return s;
	}
	
	//
	// return transposed matrix
	//
	public function transpose():Matrix {
		
		var transposedMatrix = new Matrix( columns, rows );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				transposedMatrix[column][row] = this[row][column];
			}
		}
		return transposedMatrix;
	}
 	
}