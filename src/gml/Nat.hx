package gml;

interface Nat {}

class Zero implements Nat {}

// successor operator
class S<T:Nat> implements Nat {}

// readability & convenience
typedef One   = S<Zero>;
typedef Two   = S<One>;
typedef Three = S<Two>;
typedef Four  = S<Three>;
typedef Five  = S<Four>;
typedef Six   = S<Five>;
typedef Seven = S<Six>;
typedef Eight = S<Seven>;
typedef Nine  = S<Eight>;
typedef Ten   = S<Nine>;
