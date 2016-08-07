package;

import linahx.LA;
import linahx.Matrix;
import linahx.Range;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class RangeTest {
	
	public function new() {	}
	
	@Test
	public function range1():Void {
		
		var r0 = Range.int( 0, 0 );
		Assert.isTrue( r0.length == 0 );
		
		var r1 = Range.int( 0, 1 );
		Assert.isTrue( r1.length == 1 );
		Assert.isTrue( r1[0] == 0 );
		
		var r2 = Range.int( 0, 5 );
		Assert.isTrue( r2.length == 5 );
		Assert.isTrue( r2[4] == 4 );
		
		var r3 = Range.int( 0, 10, 2 );
		Assert.isTrue( r3.length == 5 );
		Assert.isTrue( r3[4] == 8 );
		
		var r4 = Range.int( 4, 15, 2 );
		Assert.isTrue( r4.length == 6 );
		Assert.isTrue( r4[5] == 14 );
		
		var r5 = Range.int( 4, 8, 0 );
		Assert.isTrue( r5.length == 4 );
		Assert.isTrue( r5[3] == 7 );
		
		var r6 = Range.int( -4, 3 );
		Assert.isTrue( r6.length == 7 );
		Assert.isTrue( r6[6] == 2 );
		
		var r7 = Range.int( 8, 4, -1 );
		Assert.isTrue( r7.length == 4 );
		Assert.isTrue( r7[3] == 5 );
		
		var r8 = Range.int( 8, 4 );
		Assert.isTrue( r8.length == 4 );
		Assert.isTrue( r8[3] == 5 );
		
		var r9 = Range.int( 12, 4, 2 );
		Assert.isTrue( r9.length == 4 );
		Assert.isTrue( r9[3] == 6 );
		
		
		
	}
	

}