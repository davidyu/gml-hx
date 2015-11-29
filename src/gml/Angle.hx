package gml;

abstract Degree( Float ) from Float to Float {
    public function new( x: Float ) { this = x; }

    public function toRad(): Radian {
        return this * Math.PI / 180;
    }
}

abstract Radian( Float ) from Float to Float {
    public function new( x: Float ) { this = x; }

    public function toDeg(): Degree {
        return this * 180 / Math.PI;
    }
}
