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

	//
	// create Matrix from one-dimensional array of floats.
	//
	public static function fromArray1( array:Array<Float> ):Matrix {
		
		if ( array.length == 0 ) {
			return new Matrix( 0, 0 );
		}
		
		var matrix = new Matrix( 1, array.length );
		for ( column in 0...array.length ) {
			matrix.data[0][column] = array[column];
		}
		return matrix;
	}
	
	//
	// create Matrix from two-dimensional array of floats.
	//
	public static function fromArray2( array:Array<Array<Float>> ):Matrix {
		
		var rowsNumber = array.length;
		var columnsNumber = getColumnsNumber( array );
		
		var matrix = new Matrix( rowsNumber, columnsNumber );
		for( row in 0...rowsNumber ) {
			for ( column in 0...columnsNumber ) {
				if( column < array[row].length ) {
					matrix.data[row][column] = array[row][column];
				}
			}
		}
		return matrix;
	}
	
	//
	// create Matrix from String that is loaded from a CSV file.
	//
	public static function fromCSV( csvString:String, columnSeparator:String, rowSeparator:String = CHARCODE_NEWLINE ):Matrix {
		
		return Matrix.fromString( csvString, columnSeparator, rowSeparator );
	}
	
	//
	// create Matrix from String. Matlab uses ' ' as separator for the column and ';' as separator for rows
	//
	public static function fromString( string:String, columnSeparator:String = " ", rowSeparator:String = ";" ):Matrix {
		
		string = StringTools.replace( string, CR, "" );
		string = StringTools.trim( string );
		
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
				matrix.data[row][column] = Std.parseFloat( stringMatrix[row][column] );
			}
		}
		return matrix;
			
	}
	
	//
	// create new matrix
	//
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
	
	//
	// get column number of a two-dimensional array, check if all rows have the same number of elements
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
	
	//
	// return a copy of the matrix
	//
	public function copy():Matrix {
		
		var matrixCopy = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				matrixCopy.data[row][column] = data[row][column];
			}
		}
		return matrixCopy;
	}
	
	//
	// dot product of this matrix and another one
	//
	public function dot( otherMatrix:Matrix ):Matrix {
		
		if ( columns != otherMatrix.rows ) {
			throw "Dot Product Error:\nFirst matrix must have " + otherMatrix.rows + " columns or Second matrix must have " + columns + " rows.\nFirst matrix dimensions are " + rows + "x" + columns + ". Second matrix dimensions are " + otherMatrix.rows + "x" + otherMatrix.columns + ".";
		}
		
		var resultMatrix = new Matrix(rows, otherMatrix.columns );
		
		for( otherColumn in 0...otherMatrix.columns ) {
			for ( row in 0...rows ) {
				
				var sum = 0.0;
				for ( column in 0...columns ) {
					
					var otherRow = column;
					sum += data[row][column] * otherMatrix.data[otherRow][otherColumn];
				}
				resultMatrix.data[row][otherColumn] = sum;
			}
		}
		
		return resultMatrix;
	}
	
	//
	// elementwise multiplication of two matrices
	//
	public function multiply( otherMatrix:Matrix ):Matrix {
		
		if ( columns != otherMatrix.columns || rows != otherMatrix.rows ) {
			throw "Multiply Error:\nMatrix dimensions must be identical.\n\nFirst matrix dimensions are " + rows + "x" + columns + ". Second matrix dimensions are " + otherMatrix.rows + "x" + otherMatrix.columns + ".";
		}
		
		var resultMatrix = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				resultMatrix.data[row][column] = data[row][column] * otherMatrix.data[row][column];
			}
		}
		return resultMatrix;
	}
	
	//
	// return the size of the matrix as a matrix
	//
	public function size( ?dimension:Int ):Matrix {
		
		if ( dimension == null ) {
			return Matrix.fromArray1( [rows, columns] );
		} else if ( dimension == 0 ) {
			return Matrix.fromArray1( [ rows ] );
		} else {
			return Matrix.fromArray1( [ columns ] );
		}
	}
	
	//
	// sum function adds all the elements in one direction together: dimension=0 -> columns  dimension=1 -> rows
	//
	public function sum( ?dimension:Int ):Matrix {
		
		if ( dimension == null ) {
			if ( columns > 1 ) {
				return sumColumns();
			} else {
				return sumRows();
			}
		} else if ( dimension == 0 ) {
			return sumColumns();
		} else {
			return sumRows();
		}
	}
	
	//
	// sum of the elements in every column
	//
	function sumColumns():Matrix {
		
		var sumMatrix = new Matrix( 1, columns );
		for ( column in 0...columns ) {
			var sum = 0.0;
			for ( row in 0...rows ) {
				sum += data[row][column];
			}
			sumMatrix.data[0][column] = sum;
		}
		return sumMatrix;
	}
	
	//
	// sum of the elements in every row
	//
	function sumRows():Matrix {
		
		var sumMatrix = new Matrix( rows, 1 );
		for ( row in 0...rows ) {
			var sum = 0.0;
			for ( column in 0...columns ) {
				sum += data[row][column];
			}
			sumMatrix.data[row][0] = sum;
		}
		return sumMatrix;
	}
	
	//
	// convert the matrix to a string
	//
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
	
	//
	// return transposed matrix
	//
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
 	
}