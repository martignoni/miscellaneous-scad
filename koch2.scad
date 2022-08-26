width_koch = 1.000000000;

center_koch_1 = [0.000001867,-0.000002940];
size_koch_1 = [88.634095448,88.634095644];
stroke_width_koch_1 = 0.143234892;
color_koch_1 = [1.00000,0.00000,0.00000];
// paths for koch_1
points_koch_1_1 = [ [22.158524456,-44.317047822],[22.158524456,-34.468813448],[29.544698313,-29.544698221],[22.158524456,-24.620581034],[22.158524456,-14.772348621],[29.544698313,-9.848231434],[36.930873019,-14.772348621],[36.930873019,-4.924116207],[44.317047724,0.000000980],[36.930873019,4.924116207],[36.930873019,14.772350581],[29.544698313,9.848233394],[22.158524456,14.772350581],[22.158524456,24.620582994],[29.544698313,29.544698221],[22.158524456,34.468815408],[22.158524456,44.317047822],[14.772349581,39.392932595],[7.386174706,44.317047822],[7.386174706,34.468815408],[-0.000000170,29.544698221],[-7.386175045,34.468815408],[-7.386175045,44.317047822],[-14.772349920,39.392932595],[-22.158524796,44.317047822],[-22.158524796,34.468815408],[-29.544697974,29.544698221],[-22.158524796,24.620582994],[-22.158524796,14.772350581],[-29.544697974,9.848233394],[-36.930872849,14.772350581],[-36.930872849,4.924116207],[-44.317047724,0.000000980],[-36.930872849,-4.924116207],[-36.930872849,-14.772348621],[-29.544697974,-9.848231434],[-22.158524796,-14.772348621],[-22.158524796,-24.620581034],[-29.544697974,-29.544698221],[-22.158524796,-34.468813448],[-22.158524796,-44.317047822],[-14.772349920,-39.392930635],[-7.386175045,-44.317047822],[-7.386175045,-34.468813448],[-0.000000170,-29.544698221],[7.386174706,-34.468813448],[7.386174706,-44.317047822],[14.772349581,-39.392930635],[22.158524456,-44.317047822] ];

module ribbon(points, thickness=1) {
    p = points;
    
    union() {
        for (i=[1:len(p)-1]) {
            hull() {
                translate(p[i-1]) circle(d=thickness, $fn=8);
                translate(p[i]) circle(d=thickness, $fn=8);
            }
        }
    }
}

module ribbon_koch_1() {
 color(color_koch_1) {
  ribbon(points_koch_1_1, thickness=width_koch);
 }
}

translate(center_koch_1) ribbon_koch_1();

