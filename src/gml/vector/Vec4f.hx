package gml.vector;

import gml.Nat;
import gml.vector.Vec;
import gml.vector.Vec2f;
import gml.vector.Vec3f;

@:forward(dot, lensq, len, normalize)
abstract Vec4f( Vecf<Four> ) from Vecf<Four> to Vecf<Four> {
    public function new( x, y, z, w ) { this = new Vecf<Four>( [x, y, z, w] ); }

    private inline function vecf():Vecf<Four> {
        return this;
    }

    public var x(get, set): Float;
    public var y(get, set): Float;
    public var z(get, set): Float;
    public var w(get, set): Float;
    public var r(get, set): Float;
    public var g(get, set): Float;
    public var b(get, set): Float;
    public var a(get, set): Float;

    public var xy(get, never): Vec2f;
    public var xyz(get, never): Vec3f;

    @:arrayAccess
    public inline function get( i: Int ): Float {
        return this.get( i );
    }

    @:arrayAccess
    public inline function set( i: Int, v: Float ): Float {
        return this.set( i, v );
    }

    @:op(A + B)
    public static inline function add( lhs: Vec4f, rhs : Vec4f ): Vec4f {
        return lhs.vecf().add( rhs.vecf() );
    }

    @:op(A - B)
    public static inline function sub( lhs: Vec4f, rhs : Vec4f ): Vec4f {
        return lhs.vecf().sub( rhs.vecf() );
    }

    @:op(-B)
    public static inline function negate( rhs: Vec4f ): Vec4f {
        return rhs.vecf().negate();
    }

    @:op(A * B)
    public static inline function mul( lhs: Vec4f, rhs : Vec4f ): Vec4f {
        return lhs.vecf().mul( rhs.vecf() );
    }

    @:op(A * B) @:commutative
    public static inline function smul( lhs: Vec4f, rhs : Float ): Vec4f {
        return Vecf.smul( lhs, rhs );
    }

    @:op(A / B)
    public static inline function div( lhs: Vec4f, rhs: Vec4f ): Vec4f {
        return lhs.vecf().div( rhs );
    }

    @:op(A / B)
    public static inline function sdiv( lhs: Vec4f, rhs: Float ): Vec4f {
        return Vecf.sdiv( lhs, rhs );
    }

    @:op(A / B)
    public static inline function recip( lhs: Float, rhs: Vec4f ): Vec4f {
        return Vecf.recip( lhs, rhs.vecf() );
    }

    @:op(A == B)
    public static inline function eq_f( lhs: Vec4f, rhs : Vec4f ): Bool {
        return lhs.vecf().eq( rhs.vecf() );
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

    public function get_w() {
        return this[3];
    }

    public function get_a() {
        return this[3];
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

    public function set_w( w: Float ) {
        return this[3] = w;
    }

    public function set_a( a: Float ) {
        return this[3] = a;
    }

    public function get_xy() {
        return new Vec2f( this[0], this[1] );
    }

    public function get_xyz() {
        return new Vec3f( this[0], this[1], this[2] );
    }
}
