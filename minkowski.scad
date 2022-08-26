use <lsystem.scad>;

//<params>
wallFlareWidth = 3;
wallFlareThickness = 1.5;
wallHeight = 12;
wallWidth = 1;

lineSegment = 15;
iterations = 1;

angle = 90;
axiom = "F+F+F+F";
rules = [["F", "F-F+F+FF-F-F+F"]];
//</params>

module dummy();

forward = lineSegment;

baseState  = [ [], identityMatrix() ];
functions = 
    [ 
      ["F", ["m", forwardMatrix(forward)]],
      ["-", ["m", yawMatrix(angle)]],
      ["+", ["m", yawMatrix(-angle)]],
      ["^", ["m", pitchMatrix(angle)]],
      ["&", ["m", pitchMatrix(-angle)]],
      [">", ["m", rollMatrix(angle)]],
      ["<", ["m", rollMatrix(-angle)]],
      ["[", ["push"]],
      ["]", ["pop"]]
      ];

out = lsystem(rules,axiom,iterations);
states = evolveState(out,functions, baseState);
linear_extrude(height=wallFlareThickness) traceStates(states) circle(d=wallFlareWidth,$fn=10);
linear_extrude(height=wallHeight) traceStates(states) circle(d=wallWidth,$fn=10);
