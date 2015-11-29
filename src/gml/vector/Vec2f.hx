package gml.vector;

import gml.vector.Vec;
import gml.Nat;

@:forward(dot, lensq, len, normalize)
abstract Vec2f( Vecf<Two> ) from Vecf<Two> to Vecf<Two> {
    public function new( x, y ) { this = new Vecf<Two>( [x, y] ); }

    private inline function vecf():Vecf<Two> {
        return this;
    }

    public var x(get, set): Float;
    public var y(get, set): Float;
    public var r(get, set): Float;
    public var g(get, set): Float;

    @:arrayAccess
    public inline function get( i: Int ): Float {
        return this.get( i );
    }

    @:arrayAccess
    public inline function set( i: Int, v: Float ): Float {
        return this.set( i, v );
    }

    public inline function orthogonal( flipY : Bool = false ) : Vec2f {
        if ( flipY )
            return new Vec2f( -y, x );
        else
            return new Vec2f( y, -x );
    }

    public inline function reflect( normal: Vec2f ): Vec2f {
        return this - ( 2 * this.dot( normal ) ) * normal;
    }

    @:op(A + B)
    public static inline function add( lhs: Vec2f, rhs : Vec2f ): Vec2f {
        return lhs.vecf().add( rhs.vecf() );
    }

    @:op(A - B)
    public static inline function sub( lhs: Vec2f, rhs : Vec2f ): Vec2f {
        return lhs.vecf().sub( rhs.vecf() );
    }

    @:op(-B)
    public static inline function negate( rhs: Vec2f ): Vec2f {
        return rhs.vecf().negate();
    }

    @:op(A * B)
    public static inline function mul( lhs: Vec2f, rhs : Vec2f ): Vec2f {
        return lhs.vecf().mul( rhs.vecf() );
    }

    @:op(A * B) @:commutative
    public static inline function smul( lhs: Vec2f, rhs : Float ): Vec2f {
        return Vecf.smul( lhs, rhs );
    }

    @:op(A / B)
    public static inline function div( lhs: Vec2f, rhs: Vec2f ): Vec2f {
        return lhs.vecf().div( rhs );
    }

    @:op(A / B)
    public static inline function sdiv( lhs: Vec2f, rhs: Float ): Vec2f {
        return Vecf.sdiv( lhs, rhs );
    }

    @:op(A / B)
    public static inline function recip( lhs: Float, rhs: Vec2f ): Vec2f {
        return Vecf.recip( lhs, rhs.vecf() );
    }

    @:op(A == B)
    public static inline function eq_f( lhs: Vec2f, rhs : Vec2f ): Bool {
        return lhs.vecf().eq( rhs.vecf() );
    }

    public function cross( rhs: Vec2f ): Float {
        return this[0] * rhs[1] - this[1] * rhs[0];
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
}
