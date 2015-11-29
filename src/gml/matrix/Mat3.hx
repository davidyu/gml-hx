package gml.matrix;

import gml.matrix.Matrix;
import gml.vector.Vec3f;

@:forward(get, set)
abstract Mat3( Matrix<Float> ) from Matrix<Float> to Matrix<Float> {
    public function new( r00, r01, tx, r10, r11, ty, m20, m21, tz ) {
        this = new Matrix<Float>( 3, 3, [ r00, r01, tx, r10, r11, ty, m20, m21, tz ] );
    }

    public var r00(get, set): Float;
    public var r01(get, set): Float;
    public var r10(get, set): Float;
    public var r11(get, set): Float;
    public var m20(get, set): Float;
    public var m21(get, set): Float;
    public var tx(get, set): Float;
    public var ty(get, set): Float;
    public var tz(get, set): Float;

    @:arrayAccess
    public inline function get_flat( i: Int ): Float {
        return this.get_flat( i );
    }

    @:arrayAccess
    public inline function set_flat( i: Int, v: Float ) {
        this.set_flat( i, v );
    }

    public function get_r00() {
        return this.get( 0, 0 );
    }

    public function set_r00( r00: Float ) {
        return this.set( 0, 0, r00 );
    }

    public function get_r01() {
        return this.get( 0, 1 );
    }

    public function set_r01( r01: Float ) {
        return this.set( 0, 1, r01 );
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

    public function get_m20() {
        return this.get( 2, 0 );
    }

    public function set_m20( m20: Float ) {
        return this.set( 2, 0, m20 );
    }

    public function get_m21() {
        return this.get( 2, 1 );
    }

    public function set_m21( m21: Float ) {
        return this.set( 2, 1, m21 );
    }

    public function get_tx() {
        return this.get( 0, 2 );
    }

    public function set_tx( tx: Float ) {
        return this.set( 0, 2, tx );
    }

    public function get_ty() {
        return this.get( 1, 2 );
    }

    public function set_ty( ty: Float ) {
        return this.set( 1, 2, ty );
    }

    public function get_tz() {
        return this.get( 2, 2 );
    }

    public function set_tz( tz: Float ) {
        return this.set( 2, 2, tz );
    }

    private static inline function makeMat3( ar: Array<Float> ): Mat3 {
        return new Mat3( ar[0] , ar[1] , ar[2]
                       , ar[3] , ar[4] , ar[5]
                       , ar[6] , ar[7] , ar[8] );
    }

    @:op(A + B)
    public static inline function add( lhs: Mat3, rhs : Mat3 ): Mat3 {
        var c = new Array<Float>();
        for ( i in 0...9 ) {
            c.push( lhs[i] + rhs[i] );
        }

        return makeMat3( c );
    }

    @:op(A - B)
    public static inline function sub( lhs: Mat3, rhs : Mat3 ): Mat3 {
        var c = new Array<Float>();
        for ( i in 0...9 ) {
            c.push( lhs[i] - rhs[i] );
        }

        return makeMat3( c );
    }

    @:op(A * B)
    public static inline function matmul( lhs: Mat3, rhs: Mat3 ): Mat3 {
        var c = new Array<Float>();
        for ( j in 0...3 ) {
            for ( k in 0...3 ) {
                var sum = 0.0;
                for ( i in 0...3 ) {
                    sum += lhs.get( i, j ) * rhs.get( k, i );
                }
                c.push( sum );
            }
        }
        return makeMat3( c );
    }

    @:op(A * B)
    public static inline function matvec( lhs: Mat3, rhs: Vec3f ): Vec3f {
        var c = new Array<Float>();
        for ( j in 0...3 ) {
            var sum = 0.0;
            for ( i in 0...3 ) {
                sum += lhs.get( i, j ) * rhs[i];
            }
            c.push( sum );
        }
        return new Vec3f( c[0], c[1], c[2] );
    }

    @:op(A * B)
    public static inline function vecmat( lhs: Vec3f, rhs: Mat3 ): Vec3f {
        var c = new Array<Float>();
        for ( i in 0...3 ) {
            var sum = 0.0;
            for ( j in 0...3 ) {
                sum += lhs[j] * rhs.get( i, j );
            }
            c.push( sum );
        }
        return new Vec3f( c[0], c[1], c[2] );
    }
}
