// params = [sections,sectionCounts]

// written for tail-recursion
// _subtotals[i] = list[0] + ... + list[i-1]
function _subtotals(list,soFar=[]) =
        len(soFar) >= 1+len(list) ? soFar :
        _subtotals(list,
            let(n1=len(soFar))
            concat(soFar, n1>0 ? soFar[n1-1]+list[n1-1] : 0));

function _flatten(list) = [for (a=list) for(b=a) b];
            
function _reverseTriangle(t) = [t[2], t[1], t[0]];

// smallest angle in triangle
function _minAngle(p1,p2,p3) =
    let(v1 = cross(p2-p1,p3-p1),
        v2 = cross(p3-p2,p1-p2))
       v1 == [0,0,0] || v2 == [0,0,0] ? 0 :
        let( a1 = asin(norm(v1) / (norm(p2-p1)*norm(p3-p1))),
             a2 = asin(norm(v2) / (norm(p3-p2)*norm(p1-p2))) )
        min(a1,a2,180-(a1+a2));

// triangulate square to maximize smallest angle
function _doSquare(points,i11,i21,i22,i12,optimize=true) =
    points[i11]==points[i12] ? [i11,i21,i22] :
    points[i21]==points[i22] ? [i22,i12,i11] :
    !optimize ? [[i11,i21,i22], [i22,i12,i11]] :
    let (m1 = min(_minAngle(points[i11],points[i21],points[i22]), _minAngle(points[i22],points[i12],points[i11])),
        m2 = min(_minAngle(points[i11],points[i21],points[i12]),
                _minAngle(points[i21],points[i12],points[i22])) )
        m2 < m1 ? [[i11,i21,i22], [i22,i12,i11]] :
                  [[i11,i21,i12], [i21,i22,i12]];
         

// n1 and n2 should be fairly small, so this doesn't need
// tail-recursion
// this assumes n1<=n2
function _tubeSegmentTriangles(points,index1,n1,index2,n2,i=0,soFar=[],optimize=true)
    = i>=n2 ? soFar :
            let(i21=i,
                i22=(i+1)%n2,
                i11=floor((i21)*n1/n2+0.5)%n1,
                i12=floor((i22)*n1/n2+0.5)%n1,
                add = i11==i12 ? [[index1+i11,index2+i21,index2+i22]] :
                    _doSquare(points,index1+i11,index2+i21,index2+i22,index1+i12,optimize=optimize))
                _tubeSegmentTriangles(points,index1,n1,index2,n2,i=i+1,soFar=concat(soFar,add),optimize=optimize);         

function _tubeSegmentFaces(points,index,n1,n2,optimize=true)
    = n1<n2 ? _tubeSegmentTriangles(points,index,n1,index+n1,n2,optimize=optimize) :
        [for (f=_tubeSegmentTriangles(points,index+n1,n2,index,n1,optimize=optimize))
           _reverseTriangle(f)];
            
function _tubeMiddleFaces(points,counts,subtotals,optimize=true) = 
       [ for (i=[1:len(counts)-1])
           for (face=_tubeSegmentFaces(points,subtotals[i-1],counts[i-1],counts[i],optimize=optimize)) face ]; 
               
function _endCaps(counts,subtotals,startCap=true,endCap=true) =
    let( n = len(counts),
         cap1 = counts[0]<=2 || !startCap ? undef : [for(i=[0:counts[0]-1]) i],
         cap2 = counts[n-1]<=2 || !endCap ? undef : [for(i=[counts[n-1]-1:-1:0]) subtotals[n-1]+i] )
       [for (c=[cap1,cap2]) if (c!=undef) c];
           
function _tubeFaces(sections,startCap=true,endCap=true,optimize=true) =
                let(
        counts = [for (s=sections) len(s)],
        points = _flatten(sections),
        subtotals = _subtotals(counts)) 
            concat(_tubeMiddleFaces(points,counts,subtotals,optimize=optimize),_endCaps(counts,subtotals,startCap=true,endCap=true));

function _removeDuplicates1(points,soFar=[[],[]]) =
        len(soFar[0]) >= len(points) ? soFar :
            _removeDuplicates1(points,
               let( 
                mapSoFar=soFar[0],
                pointsSoFar=soFar[1],
                j=len(mapSoFar),
                k=search([points[j]], pointsSoFar)[0])
                k == []? [concat(mapSoFar,[len(pointsSoFar)]),
                            concat(pointsSoFar,[points[j]])] :
                           [concat(mapSoFar,[k]),pointsSoFar]);
        
function _removeDuplicates(points, faces) =
    let(fix=_removeDuplicates1(points),
        map=fix[0],
        newPoints=fix[1],
        newFaces=[for(f=faces) [for(v=f) map[v]]])
            [newPoints, newFaces];

function pointsAndFaces(sections,startCap=true,endCap=true,optimize=true) =
        let(
            points0=_flatten(sections),
            faces0=_tubeFaces(sections,startCap=startCap,endCap=endCap,optimize=optimize))
        _removeDuplicates(points0,faces0);

        
z=[[1,2],[3,4],[1,2],[1,2],[4,5]];
//echo(_removeDuplicates1(z));
        
// increase number of points from len(section) to n
function _interpolateSection(section,n) =
        let(m=len(section))
        n == m ? section :
        n < m ? undef :
            [for(i=[0:m-1]) 
                let(cur=floor(i*n/m),
                    k=floor((i+1)*n/m)-cur,
                    i2=(i+1)%m)
                    for(j=[0:k-1]) 
                        let(t=j/k)
                            section[i]*(1-t)+section[i2]*t];

function ngonPoints(n=4,r=10,d=undef,rotate=0) =
            let(r=d==undef?r:d/2)
            r*[for(i=[0:n-1]) let(angle=i*360/n+rotate) [cos(angle),sin(angle)]];
function starPoints(n=10,r1=5,r2=10,rotate=0) =
            [for(i=[0:2*n-1]) let(angle=i*180/n+rotate) (i%2?r1:r2) * [cos(angle),sin(angle)]];

// warning: no guarantee of perfect convexity
module mySphere(r=10,d=undef) {
    radius = d==undef ? r : d/2;
    pointsAround = 
        $fn ? $fn :
        max(3, 360/$fa, 2*radius*PI/$fs);
    numSlices0 = (pointsAround + pointsAround % 2)/2;
    numSlices = numSlices0 + (numSlices0%2);
    sections = radius*[for(i=[0:numSlices]) 
                    i == 0 ? [[0,0,-1]] :
                    i == numSlices ? [[0,0,1]] :
                    let(
                        lat = (i-numSlices/2)/(numSlices/2)*90,
                        z1 = sin(lat),
                        r1 = cos(lat),
                        count = max(3,floor(0.5 + pointsAround * abs(r1))) )
                    [for(j=[0:count-1]) 
                        let(long = j*360/count)
                        [r1*cos(long),r1*sin(long),z1]]];
    data = pointsAndFaces(sections,optimize=true);
    polyhedron(points=data[0], faces=data[1]);
}

module morphExtrude(section1,section2,height=undef,numSlices=10,startCap=true,endCap=true,optimize=false) {
    n = max(len(section1),len(section2));
    section1interp = _interpolateSection(section1,n);
    section2interp = _interpolateSection(section2,n);
    sections = height == undef ?
                      [for(i=[0:numSlices]) 
                        let(t=i/numSlices)
                        (1-t)*section1interp+t*section1interp] :
                      [ [for(i=[0:n-1])
                        [section1interp[i][0],section1interp[i][1],0]], [for(i=[0:n-1])
                        [section2interp[i][0],section2interp[i][1],height]] ];
    data = pointsAndFaces(sections,startCap=startCap,endCap=endCap,optimize=false);   
    polyhedron(points=data[0], faces=data[1]);
}

module cone(r=10,d=undef,height=10) {
    radius = d==undef ? r : d/2;
    pointsAround = 
        $fn ? $fn :
        max(3, 360/$fa, 2*radius*PI/$fs);
    morphExtrude(ngonPoints(n=pointsAround,r=radius), [[0,0]], height=height,optimize=false);
}

translate([15,0,0]) morphExtrude(ngonPoints(30,r=3), ngonPoints(2,r=2), height=10);
// for some reason this gives a CGAL error if we put in r1=0 and endCap=false
translate([24,0,0]) morphExtrude(ngonPoints(30,r=3), starPoints(4,r1=0.001,r2=4), height=10);
mySphere($fn=4);
translate([36,0,0]) morphExtrude(ngonPoints(4,r=4),ngonPoints(4,r=4,rotate=45),height=10);
