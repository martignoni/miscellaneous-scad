n=100;
minD=0.344434383;
points = [[0.869795315,-0.132932374,-0.475168491],[-0.875839671,0.466488339,-0.123666891],[-0.874225657,-0.147105645,0.462697991],[-0.009397261,-0.837711606,0.546032010],[-0.389275855,0.855748176,-0.340821608],[-0.735531710,-0.529460243,-0.422687775],[0.868562022,0.099742552,0.485439427],[-0.089576026,-0.583282827,-0.807314857],[-0.842887324,0.209335650,0.495701065],[-0.638807058,-0.305011451,-0.706323975],[-0.092959527,-0.590735645,0.801492310],[0.602546329,-0.340048128,-0.722014676],[-0.026033593,0.808071446,-0.588508955],[0.535180518,-0.809458604,-0.241575209],[0.286316480,-0.460747201,-0.840080288],[0.791440904,-0.604605621,-0.089851762],[-0.317474595,-0.319844713,-0.892697732],[-0.797684544,0.558969846,0.226389220],[-0.436216619,-0.614266937,-0.657564591],[-0.302142933,-0.890825535,0.339322139],[0.953386155,-0.274557330,-0.125192300],[-0.168946950,-0.842030364,-0.512290732],[-0.037633017,0.529720809,-0.847336781],[-0.174653823,0.906743175,0.383813569],[-0.056340231,0.963263334,-0.262582419],[0.610070850,0.761177230,-0.220051773],[0.607598111,-0.777554666,0.161966902],[-0.736107805,-0.673504249,-0.067359679],[-0.958038078,0.237112049,0.161061845],[0.955991591,0.274204242,0.104365276],[0.773293579,-0.476775370,-0.417974027],[-0.000864041,0.127017033,0.991900160],[0.056734602,0.991793327,0.114573912],[0.231284074,0.877115243,0.420923423],[-0.347362647,0.674391583,0.651563646],[0.296892929,0.591406251,-0.749728774],[0.211852904,-0.419163900,0.882847650],[-0.355529708,0.667598847,-0.654148612],[0.360188521,0.265795638,0.894213010],[-0.880444402,-0.161924761,-0.445643385],[0.628154721,0.570036854,-0.529603278],[-0.407049070,-0.367630145,0.836157360],[0.466844937,0.874233570,0.133309676],[-0.516387559,0.797717051,0.311434414],[0.284725741,0.944967542,-0.161144646],[0.310239680,-0.677721139,0.666667382],[-0.594557841,0.247888655,0.764887043],[-0.981861262,0.066255946,-0.177647435],[0.662949644,0.001624506,-0.748662227],[0.168223843,-0.754661828,-0.634181570],[0.325274507,0.814268173,-0.480795006],[-0.649133511,0.526529836,0.548991818],[0.310466806,-0.085647771,0.946717921],[0.859039654,0.461802198,-0.220883687],[0.182727091,-0.926871434,-0.327902661],[-0.394513269,-0.679459106,0.618623152],[-0.637137657,0.769064981,-0.050937809],[-0.000158051,0.746147738,0.665780390],[0.862356835,-0.452552348,0.227017755],[-0.139580246,-0.976181466,-0.166093650],[-0.082808809,-0.233112603,0.968917548],[0.978029246,-0.089410226,0.188320489],[-0.923499989,-0.356036492,-0.142778805],[0.812238176,-0.256243868,0.524030748],[0.634878611,0.364699310,0.681119346],[-0.671101952,0.625455900,-0.398029002],[0.318247936,-0.874153552,0.366843044],[0.763790287,0.639347908,0.088649030],[0.547125427,-0.360180064,0.755595189],[0.304829000,-0.952389456,0.005796958],[0.030304409,-0.243511009,-0.969424588],[0.636605316,0.001225122,0.771188804],[0.054382073,0.469920028,0.881032212],[-0.658235618,-0.108776520,0.744911766],[0.495704490,-0.662604871,-0.561455113],[-0.325436447,0.343512040,-0.880960043],[-0.625974308,-0.718796808,0.302468701],[-0.984210617,-0.120026033,0.130089253],[0.569236007,0.697319363,0.435564087],[0.628388789,-0.608379337,0.484770164],[0.813571909,0.438176817,0.382232685],[-0.443521465,0.005940034,-0.896244066],[-0.683466240,-0.452383887,0.572907250],[0.207115691,0.258520927,-0.943541213],[0.354875193,-0.076590282,-0.931771177],[-0.441758420,-0.897055506,0.011870910],[-0.354840563,0.013362662,0.934831329],[0.530353909,0.317306541,-0.786156022],[-0.860736628,-0.456106804,0.226050970],[-0.857513583,0.277069936,-0.433477457],[-0.312547140,0.949606830,0.023688688],[0.976267318,0.088704058,-0.197569516],[0.351860921,0.613766879,0.706741898],[-0.723223328,0.055625586,-0.688370403],[-0.288713607,0.391743945,0.873602389],[-0.007149818,-0.985211034,0.171196082],[0.820742563,0.247443855,-0.514930271],[-0.489522236,-0.804779288,-0.335705641],[-0.091314319,0.083081710,-0.992350303],[-0.610945758,0.400928531,-0.682643094]];
echo(len(points));
render(convexity=3)
difference() {sphere(r=1,$fn=50);
for(i=[0:len(points)-1]) translate(points[i]) sphere(d=minD,$fn=12);}

