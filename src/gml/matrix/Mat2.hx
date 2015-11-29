package gml.matrix;

import gml.matrix.Matrix;
import gml.vector.Vec2f;

@:forward(get, set)
abstract Mat2( Matrix<Float> ) from Matrix<Float> to Matrix<Float> {
    public function new( r00, r01, r10, r11 ) {
        this = new Matrix<Float>( 2, 2, [ r00, r01, r10, r11 ] );
    }

    public var r00(get, set): Float;
    public var r01(get, set): Float;
    public var r10(get, set): Float;
    public var r11(get, set): Float;

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

    private static inline function makeMat2( ar: Array<Float> ): Mat2 {
        return new Mat2( ar[0] , ar[1]
                       , ar[2] , ar[3] );
    }

    @:op(A + B)
    public static inline function add( lhs: Mat2, rhs : Mat2 ): Mat2 {
        var c = new Array<Float>();
        for ( i in 0...4 ) {
            c.push( lhs[i] + rhs[i] );
        }

        return makeMat2( c );
    }

    @:op(A - B)
    public static inline function sub( lhs: Mat2, rhs : Mat2 ): Mat2 {
        var c = new Array<Float>();
        for ( i in 0...4 ) {
            c.push( lhs[i] - rhs[i] );
        }

        return makeMat2( c );
    }

    @:op(A * B)
    public static inline function matmul( lhs: Mat2, rhs: Mat2 ): Mat2 {
        var c = new Array<Float>();
        for ( j in 0...2 ) {
            for ( k in 0...2 ) {
                var sum = 0.0;
                for ( i in 0...2 ) {
                    sum += lhs.get( i, j ) * rhs.get( k, i );
                }
                c.push( sum );
            }
        }
        return makeMat2( c );
    }

    @:op(A * B)
    public static inline function matvec( lhs: Mat2, rhs: Vec2f ): Vec2f {
        var c = new Array<Float>();
        for ( j in 0...2 ) {
            var sum = 0.0;
            for ( i in 0...2 ) {
                sum += lhs.get( i, j ) * rhs[i];
            }
            c.push( sum );
        }
        return new Vec2f( c[0], c[1] );
    }

    @:op(A * B)
    public static inline function vecmat( lhs: Vec2f, rhs: Mat2 ): Vec2f {
        var c = new Array<Float>();
        for ( i in 0...2 ) {
            var sum = 0.0;
            for ( j in 0...2 ) {
                sum += lhs[j] * rhs.get( i, j );
            }
            c.push( sum );
        }
        return new Vec2f( c[0], c[1] );
    }
}
