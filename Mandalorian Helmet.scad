// OpenSCAD file automatically generated by svg2cookiercutter.py
// parameters tunable by user
wallHeight = 12;
minWallThickness = 1;
maxWallThickness = 3;
minInsideWallThickness = 1;
maxInsideWallThickness = 3;

wallFlareWidth = 5;
wallFlareThickness = 2;
insideWallFlareWidth = 5;
insideWallFlareThickness = 3;

featureHeight = 8;
minFeatureThickness = 1;
maxFeatureThickness = 3;

connectorThickness = 1.25;
cuttingTaperHeight = 2.5;
cuttingEdgeThickness = 0.5;
// set to non-zero value to generate a demoulding plate
demouldingPlateHeight = 0;
demouldingPlateSlack = 1.5;

// sizing
function clamp(t,minimum,maximum) = min(maximum,max(t,minimum));
function featureThickness(t)      = clamp(t,minFeatureThickness,maxFeatureThickness);
function wallThickness(t)         = clamp(t,minWallThickness,maxWallThickness);
function insideWallThickness(t)   = clamp(t,minInsideWallThickness,maxInsideWallThickness);

size = 200;
scale = size/125.207;

// helper modules: subshapes
module ribbon(points, thickness=1) {
    union() {
        for (i=[1:len(points)-1]) {
            hull() {
                translate(points[i-1]) circle(d=thickness, $fn=8);
                translate(points[i]) circle(d=thickness, $fn=8);
            }
        }
    }
}


module wall(points,height,thickness) {
    module profile() {
        if (height>=cuttingTaperHeight && cuttingTaperHeight>0 && cuttingEdgeThickness<thickness) {
            cylinder(h=height-cuttingTaperHeight+0.001,d=thickness,$fn=8);
            translate([0,0,height-cuttingTaperHeight]) cylinder(h=cuttingTaperHeight,d1=thickness,d2=cuttingEdgeThickness);
        }
        else {
            cylinder(h=height,d=thickness,$fn=8);
        }
    }
    for (i=[1:len(points)-1]) {
        hull() {
            translate(points[i-1]) profile();
            translate(points[i])   profile();
        }
    }
}


module outerFlare(path) {
  difference() {
    render(convexity=10) linear_extrude(height=wallFlareThickness) ribbon(path,thickness=wallFlareWidth);
    translate([0,0,-0.01]) linear_extrude(height=wallFlareThickness+0.02) polygon(points=path);
  }
}

module innerFlare(path) {
  intersection() {
    render(convexity=10) linear_extrude(height=insideWallFlareThickness) ribbon(path,thickness=insideWallFlareWidth);
    translate([0,0,-0.01]) linear_extrude(height=insideWallFlareThickness+0.02) polygon(points=path);
  }
}

module fill(path,height) {
  render(convexity=10) linear_extrude(height=height) polygon(points=path);
}


// data from svg file
connector_0 = scale * [[-49.003,73.582],[-55.836,70.045],[-92.128,58.235],[-106.330,58.207],[-113.506,60.510],[-142.532,70.021],[-149.066,73.184],[-149.592,73.943],[-149.776,82.569],[-106.613,68.803],[-91.807,68.803],[-48.663,83.114],[-49.003,73.582]];

connector_1 = scale * [[-47.828,125.118],[-47.868,129.571],[-51.409,136.948],[-53.398,146.657],[-145.028,146.523],[-147.055,136.843],[-150.675,129.279],[-150.537,121.125],[-47.839,124.557]];

outerWall_2 = scale * [[-99.219,183.383],[-101.978,183.303],[-104.720,183.121],[-107.442,182.834],[-110.146,182.440],[-112.830,181.936],[-115.493,181.318],[-118.135,180.584],[-120.756,179.731],[-123.736,178.482],[-126.540,176.940],[-129.191,175.140],[-131.710,173.117],[-133.825,171.206],[-135.817,169.181],[-137.640,167.007],[-139.250,164.650],[-140.888,161.727],[-142.290,158.704],[-143.429,155.572],[-144.277,152.321],[-144.675,150.029],[-144.935,147.723],[-145.177,143.087],[-145.177,140.996],[-145.061,140.527],[-144.875,140.423],[-144.568,140.414],[-138.748,140.705],[-121.444,141.420],[-114.670,141.526],[-100.317,141.661],[-85.963,141.579],[-77.602,141.446],[-64.056,140.917],[-53.816,140.414],[-53.423,140.494],[-53.287,140.891],[-53.278,144.467],[-53.519,147.969],[-54.022,151.395],[-54.802,154.738],[-55.872,157.996],[-57.246,161.165],[-58.937,164.240],[-60.960,167.217],[-62.700,169.307],[-64.601,171.238],[-66.627,173.051],[-68.739,174.784],[-70.312,175.948],[-71.936,177.003],[-73.608,177.952],[-75.327,178.802],[-77.090,179.556],[-80.743,180.797],[-82.629,181.292],[-87.296,182.291],[-92.022,183.012],[-95.601,183.307],[-99.219,183.383],[-99.219,183.383]];

outerWall_3 = scale * [[-92.260,58.420],[-90.355,99.536],[-89.747,111.972],[-89.270,122.132],[-89.303,123.001],[-89.256,123.400],[-89.059,123.693],[-88.709,123.849],[-88.285,123.914],[-82.365,124.344],[-77.338,124.830],[-71.619,125.611],[-68.784,126.148],[-65.961,126.788],[-61.337,127.992],[-56.753,129.275],[-56.244,129.537],[-56.121,129.763],[-56.092,130.096],[-56.132,132.928],[-56.211,133.135],[-56.780,133.244],[-60.616,133.376],[-81.571,133.853],[-95.144,134.038],[-100.105,134.099],[-105.066,134.048],[-124.777,133.694],[-134.567,133.429],[-141.987,133.219],[-142.184,133.138],[-142.266,132.556],[-142.266,130.043],[-142.147,129.566],[-141.711,129.328],[-132.633,126.850],[-128.015,125.856],[-123.353,125.089],[-118.639,124.566],[-109.802,123.878],[-109.490,123.830],[-109.293,123.716],[-109.184,123.517],[-109.141,123.216],[-108.982,119.380],[-107.103,79.825],[-106.521,66.622],[-106.153,58.422],[-106.227,58.241],[-106.759,58.288],[-109.987,59.293],[-110.407,59.531],[-110.569,60.007],[-111.204,69.982],[-111.562,74.368],[-112.157,78.714],[-113.629,86.307],[-115.438,93.821],[-116.946,99.120],[-117.826,101.731],[-118.851,104.299],[-119.864,106.408],[-121.060,108.390],[-122.475,110.218],[-124.142,111.866],[-126.141,113.478],[-128.244,114.942],[-130.445,116.256],[-132.741,117.422],[-135.453,118.587],[-138.222,119.598],[-141.035,120.481],[-143.880,121.259],[-144.578,121.533],[-144.673,121.768],[-144.701,122.185],[-144.992,137.848],[-144.989,138.338],[-144.892,138.595],[-144.627,138.704],[-144.119,138.748],[-126.894,139.435],[-116.205,139.753],[-95.753,139.885],[-83.886,139.773],[-72.020,139.462],[-65.246,139.144],[-54.028,138.721],[-53.584,138.679],[-53.357,138.582],[-53.273,138.356],[-53.366,132.371],[-53.552,122.370],[-53.580,121.861],[-53.677,121.576],[-53.924,121.410],[-54.398,121.259],[-58.235,120.174],[-61.743,118.993],[-65.147,117.594],[-68.422,115.917],[-71.543,113.903],[-73.279,112.572],[-74.894,111.132],[-76.354,109.542],[-77.629,107.765],[-78.575,106.105],[-79.401,104.385],[-80.129,102.615],[-80.777,100.806],[-82.007,96.882],[-83.096,92.928],[-84.070,88.945],[-84.958,84.931],[-86.248,78.052],[-86.721,74.588],[-87.021,71.094],[-87.736,60.060],[-87.878,59.544],[-88.318,59.267],[-91.625,58.235],[-91.867,58.175],[-92.128,58.235],[-92.260,58.420]];

outerWall_4 = scale * [[-84.958,60.934],[-84.114,71.365],[-83.740,74.793],[-83.264,78.211],[-82.259,83.939],[-81.627,86.776],[-80.857,89.588],[-79.623,93.153],[-78.844,94.871],[-77.893,96.520],[-77.003,97.761],[-75.992,98.888],[-74.846,99.876],[-73.554,100.700],[-72.166,101.257],[-70.779,101.445],[-70.088,101.393],[-68.710,100.984],[-68.024,100.621],[-66.956,99.874],[-65.987,99.007],[-65.011,97.912],[-64.168,96.738],[-63.435,95.495],[-62.786,94.192],[-61.168,90.302],[-59.769,86.334],[-58.610,82.469],[-57.636,78.551],[-55.723,70.326],[-55.758,70.121],[-56.330,69.850],[-63.817,67.363],[-83.926,60.722],[-84.405,60.537],[-84.905,60.510],[-84.981,60.722],[-84.958,60.934]];

outerWall_5 = scale * [[-114.512,60.722],[-142.028,69.824],[-142.469,69.989],[-142.677,70.154],[-142.706,70.419],[-139.885,82.292],[-138.994,85.420],[-137.954,88.503],[-136.449,92.386],[-135.606,94.293],[-134.646,96.150],[-133.791,97.466],[-132.804,98.666],[-131.674,99.733],[-130.387,100.647],[-129.033,101.251],[-128.353,101.400],[-126.989,101.406],[-126.305,101.269],[-124.936,100.727],[-123.944,100.137],[-123.031,99.444],[-122.198,98.651],[-121.444,97.764],[-120.464,96.375],[-119.621,94.913],[-118.903,93.381],[-118.295,91.784],[-117.330,88.689],[-116.526,85.556],[-115.866,82.389],[-114.756,75.231],[-114.300,71.252],[-113.639,62.944],[-113.506,60.510],[-114.029,60.547],[-114.512,60.722],[-114.512,60.722]];

outerWall_6 = scale * [[-50.879,136.128],[-48.048,130.069],[-47.823,129.375],[-47.757,128.640],[-48.075,112.739],[-48.842,74.242],[-48.887,73.856],[-49.021,73.554],[-49.556,73.104],[-52.910,71.355],[-53.366,71.305],[-51.409,136.948],[-51.065,136.518],[-50.879,136.128]];

outerWall_7 = scale * [[-149.066,73.184],[-149.480,73.531],[-149.595,74.057],[-150.707,128.667],[-150.670,129.312],[-150.495,129.937],[-147.426,136.472],[-147.236,136.829],[-147.055,136.843],[-145.097,71.094],[-149.066,73.184]];

connector_8 = scale * [[-67.701,100.416],[-68.473,115.888],[-75.612,110.394],[-73.526,100.715],[-67.701,100.416]];

connector_9 = scale * [[-123.347,99.702],[-121.026,108.340],[-126.254,113.563],[-129.364,101.142],[-123.347,99.702]];

connector_10 = scale * [[-95.416,146.595],[-95.583,183.306],[-102.119,183.296],[-101.935,146.586]];

// main modules
module cookieCutter() {
    fill(connector_0,connectorThickness);
    fill(connector_1,connectorThickness);
  wall(outerWall_2,wallHeight,wallThickness(0.002));
  outerFlare(outerWall_2);
  wall(outerWall_3,wallHeight,wallThickness(0.002));
  outerFlare(outerWall_3);
  wall(outerWall_4,wallHeight,wallThickness(0.002));
  outerFlare(outerWall_4);
  wall(outerWall_5,wallHeight,wallThickness(0.002));
  outerFlare(outerWall_5);
  wall(outerWall_6,wallHeight,wallThickness(0.002));
  outerFlare(outerWall_6);
  wall(outerWall_7,wallHeight,wallThickness(0.002));
  outerFlare(outerWall_7);
    fill(connector_8,connectorThickness);
    fill(connector_9,connectorThickness);
    fill(connector_10,connectorThickness);
}

module demouldingPlate(){
  // a plate to help push on the cookie to turn it out
  render(convexity=10) difference() {
    linear_extrude(height=demouldingPlateHeight) union() {
      polygon(points=outerWall_2);
      polygon(points=outerWall_3);
      polygon(points=outerWall_4);
      polygon(points=outerWall_5);
      polygon(points=outerWall_6);
      polygon(points=outerWall_7);
    }
    translate([0,0,-0.01]) linear_extrude(height=demouldingPlateHeight+0.02) union() {
      ribbon(connector_0,thickness=demouldingPlateSlack);
      ribbon(connector_1,thickness=demouldingPlateSlack);
      ribbon(outerWall_2,thickness=demouldingPlateSlack+wallThickness(0.002));
      ribbon(outerWall_3,thickness=demouldingPlateSlack+wallThickness(0.002));
      ribbon(outerWall_4,thickness=demouldingPlateSlack+wallThickness(0.002));
      ribbon(outerWall_5,thickness=demouldingPlateSlack+wallThickness(0.002));
      ribbon(outerWall_6,thickness=demouldingPlateSlack+wallThickness(0.002));
      ribbon(outerWall_7,thickness=demouldingPlateSlack+wallThickness(0.002));
      ribbon(connector_8,thickness=demouldingPlateSlack);
      ribbon(connector_9,thickness=demouldingPlateSlack);
      ribbon(connector_10,thickness=demouldingPlateSlack);
      polygon(points=connector_0);
      polygon(points=connector_1);
      polygon(points=connector_8);
      polygon(points=connector_9);
      polygon(points=connector_10);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
// final call, use main modules
translate([150.707*scale + wallFlareWidth/2,  -58.175*scale + wallFlareWidth/2,0])
  cookieCutter();

// translate([-40,15,0]) cylinder(h=wallHeight+10,d=5,$fn=20); // handle
if (demouldingPlateHeight>0)
  mirror([1,0,0])
    translate([150.707*scale + wallFlareWidth/2,  -58.175*scale + wallFlareWidth/2,0])
      demouldingPlate();
