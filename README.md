# linahx - Linear Algebra library for Haxe

...aims to be similar to NumPy, Matlab and Octave

##How to use

####Matrix

A matrix is always a two dimensional Array of type Float. Actually I used the Haxe [Vector<Float>](http://api.haxe.org/haxe/ds/Vector.html) type because it's supposed to be faster.

####There is a variety of way to create a matrix:

New matrix with 3 rows, 2 columns and default value 0

    var matrix = new Matrix( 3, 2, 0 );

Create matrix from one-dimensional array of floats

    var matrix = Matrix.fromArray1( [1, 2, 3, 4] );


Create matrix from two-dimensional array of floats.

    matrix = Matrix.fromArray2( [[1, 2],[3, 4],[5, 6]] );


Create matrix from String that is loaded from a CSV file where columns are separated by ',' and rows are separated by new lines.

    matrix = Matrix.fromCSV( csvString, ',' );

Create matrix from String  
Default for column separator is SPACE, default for row separator is ','

    var matrix = Matrix.fromString( "1 2 3; 4 5 6" );

You can set custom column and row separators in the method arguments

    matrix = Matrix.fromString( "1, 2, 3\n 4, 5, 6", ",", "\n" );


You can see the currently implemented features in this [html document](https://github.com/ustutz/linahx/blob/master/documentation/index.html).

####...check the source code for more information on the implemented methods.