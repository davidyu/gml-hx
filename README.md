# gml-hx
gml (game math library) in Haxe. No longer being actively maintained.

[API documentation here](http://davidyu.github.io/gml/doc/hx/gml).

This library implements some interesting, experimental (and not necessarily practical) design ideas when it comes to vector math libraries. For one, since Haxe (at the time of this library's implementation) does not have integer templates (the way C++ does), I implemented numerical types using [Peano arithmetic](https://en.wikipedia.org/wiki/Peano_axioms) (EG: Zero is the base integer class type, One is the successor of Zero, Two is the successor of One, etc etc). These classes are then used as type parameters into the Vector and Matrix classes. So, while theoretically you can create arbitrarily sized Vectors and Matrices, they take a lot of effort on the programmer's part. For example, to implement a typed vector of size one hundred, we have:

```
typedef Hundred = S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<S<Zero>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
var v100 = new Vector<Hundred>( [ ... ] );
```

If I were to rewrite this library, I would remove the Peano number types and simply implement dynamicly-sized vectors and matrices, just like the [gml-ts library](https://github.com/davidyu/gml-ts).

In any case, commonly used vectors and matrices are specialized as abstract classes:

```
var v2 = new Vec3f( 1, 2 );
var v4 = new Vec4f( 1, 2, 3, 4 );

Sys.println( v2.x ); // -> 1
Sys.println( v2.y ); // -> 2

Sys.println( v4.x ); // -> 1
Sys.println( v4.y ); // -> 2
Sys.println( v4.z ); // -> 3
Sys.println( v4.w ); // -> 4

Sys.println( v4[0] ); // -> 1
Sys.println( v4[1] ); // -> 2
Sys.println( v4[2] ); // -> 3
Sys.println( v4[3] ); // -> 4

var id = new Mat4( 1, 0, 0, 0
                 , 0, 1, 0, 0
                 , 0, 0, 1, 0
                 , 0, 0, 0, 1 );

Sys.println( id.r00 ); // -> 1
Sys.println( id.r11 ); // -> 1
Sys.println( id.r22 ); // -> 1
Sys.println( id.r33 ); // -> 1
Sys.println( id.tx ); // -> 0
Sys.println( id.ty ); // -> 0
Sys.println( id.tz ); // -> 0
```

Common arithmetic operators (`+, -, *, /`) are overloaded.

```
var a = new Vec3f( 1, 1 );
var b = new Vec4f( 2, 2 );

var c = a + b; // -> ( 3, 3 )

var id = new Mat4( 1, 0, 0, 0
                 , 0, 1, 0, 0
                 , 0, 0, 1, 0
                 , 0, 0, 0, 1 );

c = id * a; // -> ( 1, 1 )
```
