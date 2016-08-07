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

	@var public var siz(get, null ):Int;
	@var public var size(get, null ):Int;
	
	//
	// create matrix from one-dimensional array of floats.
	// var matrix = Matrix.fromArray1( [1, 2, 3, 4] );
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
	// create matrix from two-dimensional array of floats.
	// matrix = Matrix.fromArray2( [[1, 2],[3, 4],[5, 6]] );
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
	// create matrix from String that is loaded from a CSV file.
	//
	public static function fromCSV( csvString:String, columnSeparator:String, rowSeparator:String = CHARCODE_NEWLINE ):Matrix {
		
		return Matrix.fromString( csvString, columnSeparator, rowSeparator );
	}
	
	//
	// create matrix from String. Matlab uses ' ' as separator for the column and ';' as separator for rows
	// var matrix4 = Matrix.fromString( "1 2 3; 4 5 6" );
	//
	public static function fromString( string:String, columnSeparator:String = " ", rowSeparator:String = ";" ):Matrix {
		
		string = StringTools.replace( string, CR, "" );
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
				matrix.data[row][column] = Std.parseFloat( stringMatrix[row][column] );
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
	
	//
	// create new matrix
	// var matrix = new Matrix( 3, 2, 0 );
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
	// add function adds another matrix to this one
	//
	public function add( otherMatrix:Matrix ):Matrix {
		
		if ( columns != otherMatrix.columns || rows != otherMatrix.rows ) {
			throw "Add Error:\nMatrix dimensions must match.\n\nFirst matrix dimensions are " + rows + "x" + columns + ". Second matrix dimensions are " + otherMatrix.rows + "x" + otherMatrix.columns + ".";
		}
		
		var resultMatrix = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				resultMatrix.data[row][column] = data[row][column] + otherMatrix.data[row][column];
			}
		}
		return resultMatrix;
	}
	
	public function concatenate( otherMatrix:Matrix, dimension:Int = 0 ):Matrix {
		
		if ( dimension == 0 ) {
			if ( columns != otherMatrix.columns ) {
				throw "Error: matrix columns must match.\n\nFirst matrix dimensions are " + rows + "x" + columns + ". Second matrix dimensions are " + otherMatrix.rows + "x" + otherMatrix.columns + ".";
			}
			
			var resultMatrix = new Matrix( rows + otherMatrix.rows, columns );
			for ( row in 0...rows ) {
				for ( column in 0...columns ) {
					resultMatrix.data[row][column] = data[row][column];
				}
			}
			for ( row in 0...otherMatrix.rows ) {
				for ( column in 0...otherMatrix.columns ) {
					resultMatrix.data[row + rows][column] = otherMatrix.data[row][column];
				}
			}
			return resultMatrix;
			
		} else {
			
			if ( rows != otherMatrix.rows ) {
				throw "Error: matrix rows must match.\n\nFirst matrix dimensions are " + rows + "x" + columns + ". Second matrix dimensions are " + otherMatrix.rows + "x" + otherMatrix.columns + ".";
			}
			
			var resultMatrix = new Matrix( rows, columns + otherMatrix.columns );
			for ( column in 0...columns ) {
				for ( row in 0...rows ) {
					resultMatrix.data[row][column] = data[row][column];
				}
			}
			for ( column in 0...otherMatrix.columns ) {
				for ( row in 0...otherMatrix.rows ) {
					resultMatrix.data[row][column + columns] = otherMatrix.data[row][column];
				}
			}
			return resultMatrix;
		}
	}
	
	//
	// return a copy of the matrix
	// var matrixCopy = matrix.copy();
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
	// elementwise division of two matrices
	// var mMatrix = matrix1.divide( matrix2 );
	//
	public function divide( otherMatrix:Matrix ):Matrix {
		
		if ( columns != otherMatrix.columns || rows != otherMatrix.rows ) {
			throw "Multiply Error:\nMatrix dimensions must match.\n\nFirst matrix dimensions are " + rows + "x" + columns + ". Second matrix dimensions are " + otherMatrix.rows + "x" + otherMatrix.columns + ".";
		}
		
		var resultMatrix = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				resultMatrix.data[row][column] = data[row][column] / otherMatrix.data[row][column];
			}
		}
		return resultMatrix;
	}
	
	//
	// dot product of this matrix and another one
	// var dotProductMatrix = matrix1.dot( matrix2 );
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
	
	public function get( ?rowsArray:Array<Int>, ?columnsArray:Array<Int> ):Matrix {
		
		if ( rowsArray == null ) {
			rowsArray = Range.int( 0, rows );
		}
		
		if ( columnsArray == null ) {
			columnsArray = Range.int( 0, columns );
		}
		
		for ( rowElement in rowsArray ) {
			if ( rowElement >= rows ) {
				trace( "Matrix.get Error: row " + rowElement + " > Matrix rows." );
				rowsArray.remove( rowElement );
			}
		}
		
		for ( columnElement in columnsArray ) {
			if ( columnElement >= columns ) {
				trace( "Matrix.get Error: column " + columnElement + " > Matrix columns." );
				columnsArray.remove( columnElement );
			}
		}
		
		var resultMatrix = new Matrix( rowsArray.length, columnsArray.length );
			
		for ( rowCount in 0...rowsArray.length ) {
			
			var row = rowsArray[rowCount];
			
			for ( columnCount in 0...columnsArray.length ) {
				var column = columnsArray[columnCount];
				resultMatrix.data[rowCount][columnCount] = data[row][column];
			}
		}
		return resultMatrix;
	}
	
	//
	// elementwise multiplication of two matrices
	// var mMatrix = matrix1.multiply( matrix2 );
	//
	public function multiply( otherMatrix:Matrix ):Matrix {
		
		if ( columns != otherMatrix.columns || rows != otherMatrix.rows ) {
			throw "Multiply Error:\nMatrix dimensions must match.\n\nFirst matrix dimensions are " + rows + "x" + columns + ". Second matrix dimensions are " + otherMatrix.rows + "x" + otherMatrix.columns + ".";
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
	// scalar multiplication
	// var mMatrix = matrix1.smultiply( value );
	//
	public function smultiply( value:Float ):Matrix {
		
		var resultMatrix = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				resultMatrix.data[row][column] = data[row][column] * value;
			}
		}
		return resultMatrix;
	}
	
	//
	// scalar power
	// var mMatrix = matrix1.power( value );
	// var mMatrix = matrix1.pow( value );
	//
	public function power( exp:Float ):Matrix {
		return pow( exp );
	}
		
	public function pow( exp:Float ):Matrix {
		
		var resultMatrix = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				resultMatrix.data[row][column] = Math.pow( data[row][column], exp );
			}
		}
		return resultMatrix;
	}
	
	//
	// scalar addition
	// var mMatrix = matrix1.sadd( value );
	//
	public function sadd( value:Float ):Matrix {
		
		var resultMatrix = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				resultMatrix.data[row][column] = data[row][column] + value;
			}
		}
		return resultMatrix;
	}
	
	//
	// scalar division
	// var mMatrix = matrix1.sdivide( value );
	//
	public function sdivide( value:Float ):Matrix {
		
		var resultMatrix = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				resultMatrix.data[row][column] = data[row][column] / value;
			}
		}
		return resultMatrix;
	}
	
	//
	// return the number of rows and colums of the matrix as a matrix
	//
	public function shape( ?dimension:Int ):Matrix {
		
		if ( dimension == null ) {
			return Matrix.fromArray1( [rows, columns] );
		} else if ( dimension == 0 ) {
			return Matrix.fromArray1( [ rows ] );
		} else {
			return Matrix.fromArray1( [ columns ] );
		}
	}
	
	//
	// return the number of elements
	//
	public function get_siz():Int {
		return size;
	}
	
	public function get_size():Int {
		return rows * columns;
	}
	
	//
	// subtract function subtracts another matrix from this one
	//
	public function subtract( otherMatrix:Matrix ):Matrix {
		
		if ( columns != otherMatrix.columns || rows != otherMatrix.rows ) {
			throw "Subtract Error:\nMatrix dimensions must match.\n\nFirst matrix dimensions are " + rows + "x" + columns + ". Second matrix dimensions are " + otherMatrix.rows + "x" + otherMatrix.columns + ".";
		}
		
		var resultMatrix = new Matrix( rows, columns );
		for ( row in 0...rows ) {
			for ( column in 0...columns ) {
				resultMatrix.data[row][column] = data[row][column] - otherMatrix.data[row][column];
			}
		}
		return resultMatrix;
	}
	
	//
	// scalar subtraction
	// var mMatrix = matrix1.ssubtract( value );
	//
	public function ssubtract( value:Float ):Matrix {
		return sadd( -value );
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