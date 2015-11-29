package gml.vector;

import gml.Nat;
import gml.vector.Vec;
import gml.vector.Vec2f;

@:forward(dot, lensq, len, normalize)
abstract Vec3f( Vecf<Three> ) from Vecf<Three> to Vecf<Three> {
    public function new( x, y, z ) { this = new Vecf<Three>( [x, y, z] ); }

    private inline function vecf():Vecf<Three> {
        return this;
    }

    public var x(get, set): Float;
    public var y(get, set): Float;
    public var z(get, set): Float;
    public var r(get, set): Float;
    public var g(get, set): Float;
    public var b(get, set): Float;

    public var xy(get, never): Vec2f;

    @:arrayAccess
    public inline function get( i: Int ): Float {
        return this.get( i );
    }

    @:arrayAccess
    public inline function set( i: Int, v: Float ): Float {
        return this.set( i, v );
    }

    @:op(A + B)
    public static inline function add( lhs: Vec3f, rhs : Vec3f ): Vec3f {
        return lhs.vecf().add( rhs.vecf() );
    }

    @:op(A - B)
    public static inline function sub( lhs: Vec3f, rhs : Vec3f ): Vec3f {
        return lhs.vecf().sub( rhs.vecf() );
    }

    @:op(-B)
    public static inline function negate( rhs: Vec3f ): Vec3f {
        return rhs.vecf().negate();
    }

    @:op(A * B)
    public static inline function mul( lhs: Vec3f, rhs : Vec3f ): Vec3f {
        return lhs.vecf().mul( rhs.vecf() );
    }

    @:op(A * B) @:commutative
    public static inline function smul_f( lhs: Vec3f, rhs : Float ): Vec3f {
        return Vecf.smul( lhs, rhs );
    }

    @:op(A / B)
    public static inline function div( lhs: Vec3f, rhs: Vec3f ): Vec3f {
        return lhs.vecf().div( rhs );
    }

    @:op(A / B)
    public static inline function sdiv( lhs: Vec3f, rhs: Float ): Vec3f {
        return Vecf.sdiv( lhs, rhs );
    }

    @:op(A / B)
    public static inline function recip( lhs: Float, rhs: Vec3f ): Vec3f {
        return Vecf.recip( lhs, rhs.vecf() );
    }

    @:op(A == B)
    public static inline function eq_f( lhs: Vec3f, rhs : Vec3f ): Bool {
        return lhs.vecf().eq( rhs.vecf() );
    }

    public function cross( rhs: Vec3f ): Vec3f {
        return new Vec3f( this[1] * rhs[2] - this[2] * rhs[1]
                        , this[2] * rhs[0] - this[0] * rhs[2]
                        , this[0] * rhs[1] - this[1] * rhs[0] );
    }

    public function get_x() {
        return this[0];
    }

    public function get_r() {
        return this[0];
    }

    public function get_y() {
        return this[1];
    }

    public function get_g() {
        return this[1];
    }

    public function get_z() {
        return this[2];
    }

    public function get_b() {
        return this[2];
    }

    public function set_x( x: Float ) {
        return this[0] = x;
    }

    public function set_r( r: Float ) {
        return this[0] = r;
    }

    public function set_y( y: Float ) {
        return this[1] = y;
    }

    public function set_g( g: Float ) {
        return this[1] = g;
    }

    public function set_z( z: Float ) {
        return this[2] = z;
    }

    public function set_b( b: Float ) {
        return this[2] = b;
    }

    public function get_xy() {
        return new Vec2f( this[0], this[1] );
    }
}
