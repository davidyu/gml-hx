package gml.matrix;

import gml.vector.Vec;

// warning: all operators and accessors have no bounds checks; assumes all parameters are the correct size
// this is done for performance reasons

// generic base matrix -- we need this to store rows and cols
// in general, we external users don't need to use this class
class BaseMatrix<T> {
    public var rows: Int;
    public var cols: Int;
    public var data: Array<T>;

    public function new( cols: Int, rows: Int, xs: Array<T> ) {
        this.rows = rows;
        this.cols = cols;
        this.data = xs;
    }

    public function get( r: Int, c: Int ): T {
        return this.data[ r * this.cols + c ];
    }

    public function set( r: Int, c: Int, v: T ) {
        return this.data[ r * this.cols + c ] = v;
    }
}

// generic matrix, with some useful accessors (array accessors, overloaded operations for Matrix<Floats>)
@:forward(get, set, rows, cols)
abstract Matrix<T>( BaseMatrix<T> ) from BaseMatrix<T> to BaseMatrix<T> {
    public function new( cols: Int, rows: Int, xs: Array<T> ) {
        this = new BaseMatrix( cols, rows, xs );
    }

    @:arrayAccess
    public function get_flat( i: Int ): T {
        return this.data[i];
    }

    @:arrayAccess
    public function set_flat( i: Int, v: T ) {
        this.data[i] = v;
    }

    @:op(A + B)
    public static inline function add( lhs: Matrix<Float>, rhs : Matrix<Float> ): Matrix<Float> {
        var c = new Array<Float>();
        for ( i in 0...lhs.rows * lhs.cols ) {
            c.push( lhs.get_flat( i ) + rhs.get_flat( i ) );
        }

        return new BaseMatrix<Float>( lhs.cols, rhs.rows, c );
    }

    @:op(A - B)
    public static inline function sub( lhs: Matrix<Float>, rhs : Matrix<Float> ): Matrix<Float> {
        var c = new Array<Float>();
        for ( i in 0...lhs.rows * lhs.cols ) {
            c.push( lhs.get_flat( i ) - rhs.get_flat( i ) );
        }

        return new BaseMatrix<Float>( lhs.cols, rhs.rows, c );
    }

    @:op(A * B)
    public static inline function matmul( lhs: Matrix<Float>, rhs: Matrix<Float> ): Matrix<Float> {
        var c = new Array<Float>();
        for ( j in 0...lhs.rows ) {
            for ( k in 0...rhs.cols ) {
                var sum = 0.0;
                for ( i in 0...rhs.rows ) {
                    sum += lhs.get( i, j ) * rhs.get( k, i );
                }
                c.push( sum );
            }
        }
        return new BaseMatrix<Float>( rhs.cols, lhs.rows, c );
    }

    @:op(A * B)
    public static inline function matvec<N:Nat>( lhs: Matrix<Float>, rhs: Vecf<N> ): Vecf<N> {
        var c = new Array<Float>();
        for ( j in 0...lhs.rows ) {
            var sum = 0.0;
            for ( i in 0...rhs.length ) {
                sum += lhs.get( i, j ) * rhs[i];
            }
            c.push( sum );
        }
        return new Vecf<N>( c );
    }

    @:op(A * B)
    public static inline function vecmat<N:Nat>( lhs: Vecf<N>, rhs: Matrix<Float> ): Vecf<N> {
        var c = new Array<Float>();
        for ( i in 0...rhs.cols ) {
            var sum = 0.0;
            for ( j in 0...lhs.length ) {
                sum += lhs[j] * rhs.get( i, j );
            }
            c.push( sum );
        }
        return new Vecf<N>( c );
    }
}
