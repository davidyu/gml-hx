package gml.matrix;

import gml.matrix.Matrix;
import gml.vector.Vec4f;

@:forward(get, set)
abstract Mat4( Matrix<Float> ) from Matrix<Float> to Matrix<Float> {
    public function new( r00, r01, r02, tx, r10, r11, r12, ty, r20, r21, r22, tz, m30, m31, m32, m33 ) {
        this = new Matrix<Float>( 4, 4, [ r00, r01, r02, tx, r10, r11, r12, ty, r20, r21, r22, tz, m30, m31, m32, m33 ] );
    }

    public var r00(get, set): Float;
    public var r01(get, set): Float;
    public var r02(get, set): Float;
    public var r10(get, set): Float;
    public var r11(get, set): Float;
    public var r12(get, set): Float;
    public var r20(get, set): Float;
    public var r21(get, set): Float;
    public var r22(get, set): Float;
    public var tx(get, set): Float;
    public var ty(get, set): Float;
    public var tz(get, set): Float;
    public var m30(get, set): Float;
    public var m31(get, set): Float;
    public var m32(get, set): Float;
    public var m33(get, set): Float;

    @:arrayAccess
    public inline function get_flat( i: Int ): Float {
        return this.get_flat(i);
    }

    @:arrayAccess
    public inline function set_flat( i: Int, v: Float ) {
        this.set_flat( i, v );
    }

    public function get_r00() {
        return this.get( 0, 0 );
    }

    public function set_r00( r00: Float ): Float {
        return this.set( 0, 0, r00 );
    }

    public function get_r01() {
        return this.get( 0, 1 );
    }

    public function set_r01( r01: Float ) {
        return this.set( 0, 1, r01 );
    }

    public function get_r02() {
        return this.get( 0, 2 );
    }

    public function set_r02( r02: Float ) {
        return this.set( 0, 2, r02 );
    }

    public function get_r10() {
        return this.get( 1, 0 );
    }

    public function set_r10( r10: Float ) {
        return this.set( 1, 0, r10 );
    }

    public function get_r11() {
        return this.get( 1, 1 );
    }

    public function set_r11( r11: Float ) {
        return this.set( 1, 1, r11 );
    }

    public function get_r12() {
        return this.get( 1, 2 );
    }

    public function set_r12( r12: Float ) {
        return this.set( 1, 2, r12 );
    }

    public function get_r20() {
        return this.get( 2, 0 );
    }

    public function set_r20( r20: Float ) {
        return this.set( 2, 0, r20 );
    }

    public function get_r21() {
        return this.get( 2, 1 );
    }

    public function set_r21( r21: Float ) {
        return this.set( 2, 1, r21 );
    }

    public function get_r22() {
        return this.get( 2, 2 );
    }

    public function set_r22( r22: Float ) {
        return this.set( 2, 2, r22 );
    }

    public function get_tx() {
        return this.get( 0, 3 );
    }

    public function set_tx( tx: Float ) {
        return this.set( 0, 3, tx );
    }

    public function get_ty() {
        return this.get( 1, 3 );
    }

    public function set_ty( ty: Float ) {
        return this.set( 1, 3, ty );
    }

    public function get_tz() {
        return this.get( 2, 3 );
    }

    public function set_tz( tz: Float ) {
        return this.set( 2, 3, tz );
    }

    public function get_m30() {
        return this.get( 3, 0 );
    }

    public function set_m30( m30: Float ) {
        return this.set( 3, 0, m30 );
    }

    public function get_m31() {
        return this.get( 3, 1 );
    }

    public function set_m31( m31: Float ) {
        return this.set( 3, 1, m31 );
    }

    public function get_m32() {
        return this.get( 3, 2 );
    }

    public function set_m32( m32: Float ) {
        return this.set( 3, 2, m32 );
    }

    public function get_m33() {
        return this.get( 3, 3 );
    }

    public function set_m33( m33 : Float ) {
        return this.set( 3, 3, m33 );
    }

    private static inline function makeMat4( ar: Array<Float> ): Mat4 {
        return new Mat4( ar[0] , ar[1] , ar[2] , ar[3]
                       , ar[4] , ar[5] , ar[6] , ar[7]
                       , ar[8] , ar[9] , ar[10], ar[11]
                       , ar[12], ar[13], ar[14], ar[15] );
    }

    @:op(A + B)
    public static inline function add( lhs: Mat4, rhs : Mat4 ): Mat4 {
        var c = new Array<Float>();
        for ( i in 0...16 ) {
            c.push( lhs[i] + rhs[i] );
        }

        return makeMat4( c );
    }

    @:op(A - B)
    public static inline function sub( lhs: Mat4, rhs : Mat4 ): Mat4 {
        var c = new Array<Float>();
        for ( i in 0...16 ) {
            c.push( lhs[i] - rhs[i] );
        }

        return makeMat4( c );
    }

    @:op(A * B)
    public static inline function matmul( lhs: Mat4, rhs: Mat4 ): Mat4 {
        var c = new Array<Float>();
        for ( j in 0...4 ) {
            for ( k in 0...4 ) {
                var sum = 0.0;
                for ( i in 0...4 ) {
                    sum += lhs.get( i, j ) * rhs.get( k, i );
                }
                c.push( sum );
            }
        }
        return makeMat4( c );
    }

    @:op(A * B)
    public static inline function matvec( lhs: Mat4, rhs: Vec4f ): Vec4f {
        var c = new Array<Float>();
        for ( j in 0...4 ) {
            var sum = 0.0;
            for ( i in 0...4 ) {
                sum += lhs.get( i, j ) * rhs[i];
            }
            c.push( sum );
        }
        return new Vec4f( c[0], c[1], c[2], c[3] );
    }

    @:op(A * B)
    public static inline function vecmat( lhs: Vec4f, rhs: Mat4 ): Vec4f {
        var c = new Array<Float>();
        for ( i in 0...4 ) {
            var sum = 0.0;
            for ( j in 0...4 ) {
                sum += lhs[j] * rhs.get( i, j );
            }
            c.push( sum );
        }
        return new Vec4f( c[0], c[1], c[2], c[3] );
    }
}
