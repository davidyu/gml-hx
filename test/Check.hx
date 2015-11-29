package test;

import gml.Angle;
import gml.Nat;
import gml.matrix.Matrix;
import gml.matrix.Mat2;
import gml.matrix.Mat3;
import gml.matrix.Mat4;
import gml.vector.Vec;
import gml.vector.Vec2f;
import gml.vector.Vec3f;
import gml.vector.Vec4f;

// floating point utils
class FPU {
    public static function roughly( a: Float, b: Float, e: Float = 0.0000000001 ) {
        if ( a == b ) return true;
        else return Math.abs( a - b ) < e;
    }
}

class Check {
    static function main() {
        var r = new haxe.unit.TestRunner();
        r.add( new TestAngle() );
        r.add( new TestVectorInstantiation() );
        r.add( new TestVectorComponentOps() );
        r.add( new TestVectorLengthNormalize() );
        r.add( new TestVectorDot() );
        r.add( new TestMatrix() );
        r.run();
    }
}

class TestAngle extends haxe.unit.TestCase {
    public function testConversion() {
        var d30  : Degree = 30;
        var d45  : Degree = 45;
        var d60  : Degree = 60;
        var d90  : Degree = 90;
        var d180 : Degree = 180;

        var r30  : Radian = Math.PI / 6;
        var r45  : Radian = Math.PI / 4;
        var r60  : Radian = Math.PI / 3;
        var r90  : Radian = Math.PI / 2;
        var r180 : Radian = Math.PI;

        assertTrue( FPU.roughly( d30.toRad(), r30 ) );
        assertTrue( FPU.roughly( r30.toDeg(), d30 ) );
        assertTrue( FPU.roughly( d45.toRad(), r45 ) );
        assertTrue( FPU.roughly( r45.toDeg(), d45 ) );
        assertTrue( FPU.roughly( d60.toRad(), r60 ) );
        assertTrue( FPU.roughly( r60.toDeg(), d60 ) );
        assertTrue( FPU.roughly( d90.toRad(), r90 ) );
        assertTrue( FPU.roughly( r90.toDeg(), d90 ) );
        assertTrue( FPU.roughly( d180.toRad(), r180 ) );
        assertTrue( FPU.roughly( r180.toDeg(), d180 ) );
    }
}

class TestVectorBase extends haxe.unit.TestCase {
    // for testing the dot product implementation
    private function innerprod<N:Nat>( a: Vecf<N>, b: Vecf<N> ) {
        var res = 0.0;
        for ( i in 0...a.length ) res += a[i] * b[i];
        return res;
    }
}

class TestVectorInstantiation extends TestVectorBase {
    public function testVector2() {
        var v = new Vec2f( 0, 0 );
        assertTrue( v != null );
        assertEquals( v.x, 0 );
        assertEquals( v.y, 0 );
        assertEquals( v.x, v[0] );
        assertEquals( v.y, v[1] );
    }

    public function testVector3() {
        var v3 = new Vec3f( 0, 0, 0 );
        assertTrue( v3 != null );
        assertEquals( v3.x, 0 );
        assertEquals( v3.y, 0 );
        assertEquals( v3.z, 0 );
        var v2 = v3.xy;
        assertEquals( v2.x, 0 );
        assertEquals( v2.y, 0 );
    }

    public function testVector4() {
        var v4 = new Vec4f( 0, 0, 0, 0 );
        assertTrue( v4 != null );
        assertEquals( v4.x, 0 );
        assertEquals( v4.y, 0 );
        assertEquals( v4.z, 0 );
        assertEquals( v4.w, 0 );
        var v3 = v4.xyz;
        assertEquals( v3.x, 0 );
        assertEquals( v3.y, 0 );
        assertEquals( v3.z, 0 );
        var v2 = v4.xy;
        assertEquals( v2.x, 0 );
        assertEquals( v2.y, 0 );
    }

    public function testUnsafeInstantiation() {
        var v = new Vecf<Two>( [ 0, 0 ] );
        assertTrue( v != null );
        assertEquals( v[0], 0 );
        assertEquals( v[1], 0 );

        var v2 = new Vecf<Three>( [ 0, 0, 0 ] );
        assertTrue( v != null );
        assertEquals( v2[0], 0 );
        assertEquals( v2[1], 0 );
        assertEquals( v2[2], 0 );

        var v3 = new Vecf<Four>( [ 0, 0, 0, 0 ] );
        assertTrue( v != null );
        assertEquals( v3[0], 0 );
        assertEquals( v3[1], 0 );
        assertEquals( v3[2], 0 );
        assertEquals( v3[3], 0 );

        var v4 = new Vecf<Five>( [ 0, 0, 0, 0, 0 ] );
        assertTrue( v != null );
        assertEquals( v4[0], 0 );
        assertEquals( v4[1], 0 );
        assertEquals( v4[2], 0 );
        assertEquals( v4[3], 0 );
        assertEquals( v4[4], 0 );
    }
}

typedef Hundred = S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<Zero>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
class TestVectorComponentOps extends TestVectorBase {
    public function testVector2() {
        var a = new Vec2f( Math.random(), Math.random() );
        var b = new Vec2f( Math.random(), Math.random() );
        var c = a + b;
        assertEquals( c.x, a.x + b.x );
        assertEquals( c.y, a.y + b.y );
        var d = a - b;
        assertEquals( d.x, a.x - b.x );
        assertEquals( d.y, a.y - b.y );
        var e = a * b;
        assertEquals( e.x, a.x * b.x );
        assertEquals( e.y, a.y * b.y );
        var f = Math.random();
        var g = a * f;
        var h = f * a;
        assertTrue( g == h );
        assertEquals( g.x, f * a.x );
        assertEquals( g.y, f * a.y );
        var i = -a;
        assertEquals( i.x, -a.x );
        assertEquals( i.y, -a.y );
        var j = a / f;
        assertTrue( FPU.roughly( j.x, a.x / f ) );
        assertTrue( FPU.roughly( j.y, a.y / f ) );
        var k = f / a;
        assertTrue( FPU.roughly( k.x, f / a.x ) );
        assertTrue( FPU.roughly( k.y, f / a.y ) );
        var l = a / b;
        assertTrue( FPU.roughly( l.x, a.x / b.x ) );
        assertTrue( FPU.roughly( l.y, a.y / b.y ) );
    }

    public function testVector3() {
        var a = new Vec3f( Math.random(), Math.random(), Math.random() );
        var b = new Vec3f( Math.random(), Math.random(), Math.random() );
        var c = a + b;
        assertEquals( c.x, a.x + b.x );
        assertEquals( c.y, a.y + b.y );
        assertEquals( c.z, a.z + b.z );
        var d = a - b;
        assertEquals( d.x, a.x - b.x );
        assertEquals( d.y, a.y - b.y );
        assertEquals( d.z, a.z - b.z );
        var e = a * b;
        assertEquals( e.x, a.x * b.x );
        assertEquals( e.y, a.y * b.y );
        assertEquals( e.z, a.z * b.z );
        var f = Math.random();
        var g = a * f;
        var h = f * a;
        assertTrue( g == h );
        assertEquals( g.x, f * a.x );
        assertEquals( g.y, f * a.y );
        assertEquals( g.z, f * a.z );
        var i = -a;
        assertEquals( i.x, -a.x );
        assertEquals( i.y, -a.y );
        assertEquals( i.z, -a.z );
        var j = a / f;
        assertTrue( FPU.roughly( j.x, a.x / f ) );
        assertTrue( FPU.roughly( j.y, a.y / f ) );
        assertTrue( FPU.roughly( j.z, a.z / f ) );
        var k = f / a;
        assertTrue( FPU.roughly( k.x, f / a.x ) );
        assertTrue( FPU.roughly( k.y, f / a.y ) );
        assertTrue( FPU.roughly( k.z, f / a.z ) );
        var l = a / b;
        assertTrue( FPU.roughly( l.x, a.x / b.x ) );
        assertTrue( FPU.roughly( l.y, a.y / b.y ) );
        assertTrue( FPU.roughly( l.z, a.z / b.z ) );
    }

    public function testVector4() {
        var a = new Vec4f( Math.random(), Math.random(), Math.random(), Math.random() );
        var b = new Vec4f( Math.random(), Math.random(), Math.random(), Math.random() );
        var c = a + b;
        assertEquals( c.x, a.x + b.x );
        assertEquals( c.y, a.y + b.y );
        assertEquals( c.z, a.z + b.z );
        assertEquals( c.w, a.w + b.w );
        var d = a - b;
        assertEquals( d.x, a.x - b.x );
        assertEquals( d.y, a.y - b.y );
        assertEquals( d.z, a.z - b.z );
        assertEquals( d.w, a.w - b.w );
        var e = a * b;
        assertEquals( e.x, a.x * b.x );
        assertEquals( e.y, a.y * b.y );
        assertEquals( e.z, a.z * b.z );
        assertEquals( e.w, a.w * b.w );
        var f = Math.random();
        var g = a * f;
        var h = f * a;
        assertTrue( g == h );
        assertEquals( g.x, f * a.x );
        assertEquals( g.y, f * a.y );
        assertEquals( g.z, f * a.z );
        assertEquals( g.w, f * a.w );
        var i = -a;
        assertEquals( i.x, -a.x );
        assertEquals( i.y, -a.y );
        assertEquals( i.z, -a.z );
        assertEquals( i.w, -a.w );
        var j = a / f;
        assertTrue( FPU.roughly( j.x, a.x / f ) );
        assertTrue( FPU.roughly( j.y, a.y / f ) );
        assertTrue( FPU.roughly( j.z, a.z / f ) );
        assertTrue( FPU.roughly( j.w, a.w / f ) );
        var k = f / a;
        assertTrue( FPU.roughly( k.x, f / a.x ) );
        assertTrue( FPU.roughly( k.y, f / a.y ) );
        assertTrue( FPU.roughly( k.z, f / a.z ) );
        assertTrue( FPU.roughly( k.w, f / a.w ) );
        var l = a / b;
        assertTrue( FPU.roughly( l.x, a.x / b.x ) );
        assertTrue( FPU.roughly( l.y, a.y / b.y ) );
        assertTrue( FPU.roughly( l.z, a.z / b.z ) );
        assertTrue( FPU.roughly( l.w, a.w / b.w ) );
    }

    public function testUnsafeVectors() {
        var a = new Vecf<Six>( [ Math.random(), Math.random(), Math.random(), Math.random(), Math.random(), Math.random() ] );
        var b = new Vecf<Six>( [ Math.random(), Math.random(), Math.random(), Math.random(), Math.random(), Math.random() ] );
        var c = a + b;
        assertEquals( c[0], a[0] + b[0] );
        assertEquals( c[1], a[1] + b[1] );
        assertEquals( c[2], a[2] + b[2] );
        assertEquals( c[3], a[3] + b[3] );
        assertEquals( c[4], a[4] + b[4] );
        assertEquals( c[5], a[5] + b[5] );
        var d = a - b;
        assertEquals( d[0], a[0] - b[0] );
        assertEquals( d[1], a[1] - b[1] );
        assertEquals( d[2], a[2] - b[2] );
        assertEquals( d[3], a[3] - b[3] );
        assertEquals( d[4], a[4] - b[4] );
        assertEquals( d[5], a[5] - b[5] );
        var e = a * b;
        assertEquals( e[0], a[0] * b[0] );
        assertEquals( e[1], a[1] * b[1] );
        assertEquals( e[2], a[2] * b[2] );
        assertEquals( e[3], a[3] * b[3] );
        assertEquals( e[4], a[4] * b[4] );
        assertEquals( e[5], a[5] * b[5] );
        var f = Math.random();
        var g = a * f;
        var h = f * a;
        assertTrue( g == h );
        assertEquals( g[0], a[0] * f );
        assertEquals( g[1], a[1] * f );
        assertEquals( g[2], a[2] * f );
        assertEquals( g[3], a[3] * f );
        assertEquals( g[4], a[4] * f );
        assertEquals( g[5], a[5] * f );
        var i = -a;
        assertEquals( i[0], -a[0] );
        assertEquals( i[1], -a[1] );
        assertEquals( i[2], -a[2] );
        assertEquals( i[3], -a[3] );
        assertEquals( i[4], -a[4] );
        assertEquals( i[5], -a[5] );
        var j = a / f;
        assertTrue( FPU.roughly( j[0], a[0] / f ) );
        assertTrue( FPU.roughly( j[1], a[1] / f ) );
        assertTrue( FPU.roughly( j[2], a[2] / f ) );
        assertTrue( FPU.roughly( j[3], a[3] / f ) );
        assertTrue( FPU.roughly( j[4], a[4] / f ) );
        assertTrue( FPU.roughly( j[5], a[5] / f ) );
        var k = f / a;
        assertTrue( FPU.roughly( k[0], f / a[0] ) );
        assertTrue( FPU.roughly( k[1], f / a[1] ) );
        assertTrue( FPU.roughly( k[2], f / a[2] ) );
        assertTrue( FPU.roughly( k[3], f / a[3] ) );
        assertTrue( FPU.roughly( k[4], f / a[4] ) );
        assertTrue( FPU.roughly( k[5], f / a[5] ) );
        var l = a / b;
        assertTrue( FPU.roughly( l[0], a[0] / b[0] ) );
        assertTrue( FPU.roughly( l[1], a[1] / b[1] ) );
        assertTrue( FPU.roughly( l[2], a[2] / b[2] ) );
        assertTrue( FPU.roughly( l[3], a[3] / b[3] ) );
        assertTrue( FPU.roughly( l[4], a[4] / b[4] ) );
        assertTrue( FPU.roughly( l[5], a[5] / b[5] ) );
    }

    public function testLargeVector() {
        function genRandomArr( sz : Int ) {
            var res = [];
            for ( i in 0...sz ) res.push( Math.random() );
            return res;
        }

        var a = new Vecf<Hundred>( genRandomArr( 100 ) );
        var b = new Vecf<Hundred>( genRandomArr( 100 ) );
        var c = a + b;

        for ( i in 0 ... 100 ) {
            assertEquals( c[i], a[i] + b[i] );
        }

        var d = a - b;
        for ( i in 0 ... 100 ) {
            assertEquals( d[i], a[i] - b[i] );
        }

        var e = a * b;
        for ( i in 0 ... 100 ) {
            assertEquals( e[i], a[i] * b[i] );
        }

        var f = Math.random();
        var g = a * f;
        var h = f * a;
        assertTrue( g == h );

        for ( i in 0 ... 100 ) {
            assertEquals( g[i], a[i] * f );
        }

        var i = -a;
        for ( j in 0 ... 100 ) {
            assertEquals( i[j], -a[j] );
        }

        var j = a / f;
        for ( i in 0 ... 100 ) {
            assertTrue( FPU.roughly( j[i], a[i] / f ) );
        }

        var k = f / a;
        for ( i in 0 ... 100 ) {
            assertTrue( FPU.roughly( k[i], f / a[i] ) );
        }

        var l = a / b;
        for ( i in 0 ... 100 ) {
            assertTrue( FPU.roughly( l[i], a[i ]/ b[i] ) );
        }
    }
}

class TestVectorLengthNormalize extends TestVectorBase {
    public function testVector2() {
        var a = new Vec2f( Math.random(), Math.random() );
        var n = a.normalize();
        assertTrue( FPU.roughly( n.len(), 1.0 ) );
        assertTrue( FPU.roughly( n.lensq(), 1.0 ) );
    }

    public function testVector3() {
        var a = new Vec3f( Math.random(), Math.random(), Math.random() );
        var n = a.normalize();
        assertTrue( FPU.roughly( n.len(), 1.0 ) );
        assertTrue( FPU.roughly( n.lensq(), 1.0 ) );
    }

    public function testVector4() {
        var a = new Vec4f( Math.random(), Math.random(), Math.random(), Math.random() );
        var n = a.normalize();
        assertTrue( FPU.roughly( n.len(), 1.0 ) );
        assertTrue( FPU.roughly( n.lensq(), 1.0 ) );
    }

    public function testLargeVector() {
        function genRandomArr( sz : Int ) {
            var res = [];
            for ( i in 0...sz ) res.push( Math.random() );
            return res;
        }

        var a = new Vecf<Hundred>( genRandomArr( 100 ) );
        var n = a.normalize();
        assertTrue( FPU.roughly( n.len(), 1.0 ) );
        assertTrue( FPU.roughly( n.lensq(), 1.0 ) );
    }
}

class TestVectorDot extends TestVectorBase {
    public function testVector2() {
        var a = new Vec2f( Math.random(), Math.random() );
        var b = new Vec2f( Math.random(), Math.random() );
        var c = a.dot( b );
        assertTrue( FPU.roughly( c, a.x * b.x + a.y * b.y ) );
        var d = new Vec2f( 0, 1 );
        var e = new Vec2f( 1, 0 );
        assertTrue( FPU.roughly( 0, d.dot( e ) ) );
    }

    public function testVector3() {
        var a = new Vec3f( Math.random(), Math.random(), Math.random() );
        var b = new Vec3f( Math.random(), Math.random(), Math.random() );
        var c = a.dot( b );
        assertTrue( FPU.roughly( c, a.x * b.x + a.y * b.y + a.z * b.z ) );
        var d = new Vec3f( 0, 1, 0 );
        var e = new Vec3f( 1, 0, 0 );
        assertTrue( FPU.roughly( 0, d.dot( e ) ) );
    }

    public function testVector4() {
        var a = new Vec4f( Math.random(), Math.random(), Math.random(), Math.random() );
        var b = new Vec4f( Math.random(), Math.random(), Math.random(), Math.random() );
        var c = a.dot( b );
        assertTrue( FPU.roughly( c, a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w ) );
        var d = new Vec4f( 0, 1, 0, 0 );
        var e = new Vec4f( 1, 0, 1, 0 );
        assertTrue( FPU.roughly( 0, d.dot( e ) ) );
    }

    public function testLargeVector() {
        function genRandomArr( sz : Int ) {
            var res = [];
            for ( i in 0...sz ) res.push( Math.random() );
            return res;
        }

        var a = new Vecf<Hundred>( genRandomArr( 100 ) );
        var b = new Vecf<Hundred>( genRandomArr( 100 ) );
        var c = a.dot( b );

        assertTrue( FPU.roughly( c, innerprod( a, b ) ) );
    }
}

class TestVectorCross extends TestVectorBase {
    public function testVector2() {
        var a = new Vec2f( Math.random(), Math.random() );
        var b = new Vec2f( Math.random(), Math.random() );
        var c = a.cross( b );
        assertTrue( FPU.roughly( c, a.x * b.x + a.y * b.y ) );
        var d = new Vec2f( 0, 1 );
        var e = new Vec2f( 1, 0 );
        assertTrue( FPU.roughly( 0, d.dot( e ) ) );
    }

    public function testVector3() {
        var a = new Vec3f( Math.random(), Math.random(), Math.random() );
        var b = new Vec3f( Math.random(), Math.random(), Math.random() );
        var c = a.dot( b );
        assertTrue( FPU.roughly( c, a.x * b.x + a.y * b.y + a.z * b.z ) );
        var d = new Vec3f( 0, 1, 0 );
        var e = new Vec3f( 1, 0, 0 );
        assertTrue( FPU.roughly( 0, d.dot( e ) ) );
    }

    public function testVector4() {
        var a = new Vec4f( Math.random(), Math.random(), Math.random(), Math.random() );
        var b = new Vec4f( Math.random(), Math.random(), Math.random(), Math.random() );
        var c = a.dot( b );
        assertTrue( FPU.roughly( c, a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w ) );
        var d = new Vec4f( 0, 1, 0, 0 );
        var e = new Vec4f( 1, 0, 1, 0 );
        assertTrue( FPU.roughly( 0, d.dot( e ) ) );
    }

    public function testLargeVector() {
        function genRandomArr( sz : Int ) {
            var res = [];
            for ( i in 0...sz ) res.push( Math.random() );
            return res;
        }

        var a = new Vecf<Hundred>( genRandomArr( 100 ) );
        var b = new Vecf<Hundred>( genRandomArr( 100 ) );
        var c = a.dot( b );

        assertTrue( FPU.roughly( c, innerprod( a, b ) ) );
    }
}

class TestMatrix extends haxe.unit.TestCase {
    public function testAccessors() {
        var id = new Mat4( 1, 0, 0, 0
                         , 0, 1, 0, 0
                         , 0, 0, 1, 0
                         , 0, 0, 0, 1 );

        assertTrue( id != null );

        assertEquals( id[0]  , 1 );
        assertEquals( id[1]  , 0 );
        assertEquals( id[2]  , 0 );
        assertEquals( id[3]  , 0 );
        assertEquals( id[4]  , 0 );
        assertEquals( id[5]  , 1 );
        assertEquals( id[6]  , 0 );
        assertEquals( id[7]  , 0 );
        assertEquals( id[8]  , 0 );
        assertEquals( id[9]  , 0 );
        assertEquals( id[10] , 1 );
        assertEquals( id[11] , 0 );
        assertEquals( id[12] , 0 );
        assertEquals( id[13] , 0 );
        assertEquals( id[14] , 0 );
        assertEquals( id[15] , 1 );

        assertEquals( id[0]  , id.get( 0, 0 ) );
        assertEquals( id[1]  , id.get( 0, 1 ) );
        assertEquals( id[2]  , id.get( 0, 2 ) );
        assertEquals( id[3]  , id.get( 0, 3 ) );
        assertEquals( id[4]  , id.get( 1, 0 ) );
        assertEquals( id[5]  , id.get( 1, 1 ) );
        assertEquals( id[6]  , id.get( 1, 2 ) );
        assertEquals( id[7]  , id.get( 1, 3 ) );
        assertEquals( id[8]  , id.get( 2, 0 ) );
        assertEquals( id[9]  , id.get( 2, 1 ) );
        assertEquals( id[10] , id.get( 2, 2 ) );
        assertEquals( id[11] , id.get( 2, 3 ) );
        assertEquals( id[12] , id.get( 3, 0 ) );
        assertEquals( id[13] , id.get( 3, 1 ) );
        assertEquals( id[14] , id.get( 3, 2 ) );
        assertEquals( id[15] , id.get( 3, 3 ) );

        assertEquals( id[0]  , id.r00 );
        assertEquals( id[1]  , id.r01 );
        assertEquals( id[2]  , id.r02 );
        assertEquals( id[3]  , id.tx );
        assertEquals( id[4]  , id.r10 );
        assertEquals( id[5]  , id.r11 );
        assertEquals( id[6]  , id.r12 );
        assertEquals( id[7]  , id.ty );
        assertEquals( id[8]  , id.r20 );
        assertEquals( id[9]  , id.r21 );
        assertEquals( id[10] , id.r22 );
        assertEquals( id[11] , id.tz );
        assertEquals( id[12] , id.m30 );
        assertEquals( id[13] , id.m31 );
        assertEquals( id[14] , id.m32 );
        assertEquals( id[15] , id.m33 );
    }

    public function testAddition() {
        // Mat4 basic sum test
        {
            var a = new Mat4( 1 , 2 , 3 , 4
                            , 5 , 6 , 7 , 8
                            , 9 , 10, 11, 12
                            , 13, 14, 15, 16 );

            var b = new Mat4( 32, 31, 30, 29
                            , 28, 27, 26, 25
                            , 24, 23, 22, 21
                            , 20, 19, 18, 17 );

            var c = a + b;

            for ( i in 0...16 ) {
                assertEquals( c[i], a[i] + b[i] );
            }
        }

        // Mat3 basic sum test
        {
            var a = new Mat3( 1 , 2 , 3
                            , 4 , 5 , 6
                            , 7 , 8 , 9 );

            var b = new Mat3( 25, 24, 23
                            , 22, 21, 20
                            , 19, 18, 17 );

            var c = a + b;

            for ( i in 0...9 ) {
                assertEquals( c[i], a[i] + b[i] );
            }
        }

        // Mat2 basic sum test
        {
            var a = new Mat2( 1 , 2
                            , 3 , 4 );

            var b = new Mat2( 20, 19
                            , 18, 17 );

            var c = a + b;

            for ( i in 0...4 ) {
                assertEquals( c[i], a[i] + b[i] );
            }
        }
    }

    public function testSubtraction() {
        // Mat4 basic subtract test
        {
            var a = new Mat4( 1 , 2 , 3 , 4
                            , 5 , 6 , 7 , 8
                            , 9 , 10, 11, 12
                            , 13, 14, 15, 16 );

            var b = new Mat4( 32, 31, 30, 29
                            , 28, 27, 26, 25
                            , 24, 23, 22, 21
                            , 20, 19, 18, 17 );

            var c = a - b;

            for ( i in 0...16 ) {
                assertEquals( c[i], a[i] - b[i] );
            }
        }

        // Mat3 basic subtract test
        {
            var a = new Mat3( 1 , 2 , 3
                            , 4 , 5 , 6
                            , 7 , 8 , 9 );

            var b = new Mat3( 25, 24, 23
                            , 22, 21, 20
                            , 19, 18, 17 );

            var c = a - b;

            for ( i in 0...9 ) {
                assertEquals( c[i], a[i] - b[i] );
            }
        }

        // Mat2 basic subtract test
        {
            var a = new Mat2( 1 , 2
                            , 3 , 4 );

            var b = new Mat2( 20, 19
                            , 18, 17 );

            var c = a - b;

            for ( i in 0...4 ) {
                assertEquals( c[i], a[i] - b[i] );
            }
        }

        // Generic matrix basic subtract test
        for ( rows in 5...20 ) {
            for ( cols in 5...20 ) {
                var a_arr = [ for ( i in 0...rows * cols ) Math.random() ];
                var a: Matrix<Float> = new Matrix<Float>( cols, rows, a_arr );

                var b_arr = [ for ( i in 0...rows * cols ) Math.random() ];
                var b: Matrix<Float> = new Matrix<Float>( cols, rows, b_arr );

                var c = a - b;

                for ( i in 0...rows * cols ) {
                    assertTrue( FPU.roughly( c[i], a[i] - b[i] ) );
                }
            }
        }
    }
}
