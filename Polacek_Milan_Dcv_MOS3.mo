package MOS3
  model bouncingball
    parameter Real g = 10;
    parameter Real c = 0.9;
    parameter Real h_init = 1;
    Boolean doskakali_jsme;
    Boolean x;
    Real h, v;
  initial equation
    h = h_init;
    //doskakali_jsme = false;
  equation
    doskakali_jsme = not x;
    when h < 0 then
      reinit(v, -v * c);
    end when;
    when h < (-1e-6) then
      reinit(v, 0);
      reinit(h, 0);
      x = true;
    end when;
    if doskakali_jsme then
      der(v) = 0;
    else
      der(v) = -g;
    end if;
    der(h) = if doskakali_jsme then 0 else v;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end bouncingball;

  connector pq
    Real p;
    flow Real q;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-1, 2}, fillPattern = FillPattern.Solid, extent = {{-95, 94}, {95, -94}})}));
  end pq;

  model tlak
    pq pq1 annotation(Placement(visible = true, transformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real p;
  equation
    pq1.p = p;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end tlak;

  model komora
    pq pq1 annotation(Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput c "compliance" annotation(Placement(visible = true, transformation(origin = {-86, 86}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Real v "v jako vobjem";
    parameter Real v0 = 0 "initial vobjem";
  initial equation
    v = v0;
  equation
    pq1.p = c * v;
    der(v) = pq1.q;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {3, 5}, extent = {{-49, 83}, {49, -83}}, endAngle = 360)}));
  end komora;

  model odpor
    parameter Real r = 1;
    pq pq1 annotation(Placement(visible = true, transformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pq2 annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    pq1.p - pq2.p = r * pq1.q;
    pq1.q + pq2.q = 0;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-4, -5}, extent = {{-64, 31}, {64, -31}})}));
  end odpor;

  model chlopen
    pq pq1 annotation(Placement(visible = true, transformation(origin = {-84, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-84, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pq2 annotation(Placement(visible = true, transformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Real q;
    Real dp;
    Real s;
    Boolean on;
  equation
    pq1.q + pq2.q = 0;
    pq1.p - pq2.p = dp;
    pq1.q = q;
    on = s > 0;
    if on then
      dp = 0;
      q = s;
    else
      dp = s;
      q = 0;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {-4, 0.0192121}, points = {{-56, 79.9808}, {-56, -80.0192}, {44, -2.01921}, {44, -46.0192}, {56, -46.0192}, {56, 47.9808}, {42, 49.9808}, {44, 11.9808}, {-56, 79.9808}})}));
  end chlopen;

  model beatingHeart
    tlak tlak1(p = 1) annotation(Placement(visible = true, transformation(origin = {-86, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    odpor odpor1 annotation(Placement(visible = true, transformation(origin = {-60, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    chlopen chlopen1 annotation(Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    chlopen chlopen2 annotation(Placement(visible = true, transformation(origin = {30, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tlak tlak2(p = 2) annotation(Placement(visible = true, transformation(origin = {80, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    odpor odpor2 annotation(Placement(visible = true, transformation(origin = {68, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Heart_Elasticity heart_Elasticity1 annotation(Placement(visible = true, transformation(origin = {-32, 44}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    komora komora1 annotation(Placement(visible = true, transformation(origin = {16, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(komora1.c, heart_Elasticity1.Et) annotation(Line(points = {{8, 48}, {-18, 48}, {-18, 44}, {-18, 44}}, color = {0, 0, 127}));
    connect(komora1.pq1, chlopen1.pq2) annotation(Line(points = {{16, 31}, {22, 31}, {22, 0}, {-14, 0}}));
    connect(odpor1.pq1, tlak1.pq1) annotation(Line(points = {{-69, 4}, {-68, 4}, {-68, -6}, {-76, -6}, {-76, -6}}));
    connect(odpor1.pq2, chlopen1.pq1) annotation(Line(points = {{-52, 4}, {-30, 4}, {-30, 0}, {-30, 0}}));
    connect(chlopen2.pq1, chlopen1.pq2) annotation(Line(points = {{22, 2}, {-14, 2}, {-14, 0}, {-14, 0}}));
    connect(odpor2.pq1, chlopen2.pq2) annotation(Line(points = {{59, 6}, {38, 6}, {38, 2}, {38, 2}}));
    connect(tlak2.pq1, odpor2.pq2) annotation(Line(points = {{89, 17}, {96, 17}, {96, 6}, {76, 6}, {76, 6}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end beatingHeart;

  model Heart_Elasticity
    Modelica.Blocks.Interfaces.RealInput Tsyst annotation(Placement(visible = true, transformation(origin = {-98, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput T0 annotation(Placement(visible = true, transformation(origin = {-100, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Et annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real Edias = 1 / 10;
    parameter Real Esys = 1 / 0.4;
  equation
    if time - T0 >= 0 and time - T0 <= Tsyst then
      Et = Edias + (Esys - Edias) / 2 * (1 - cos(Modelica.Constants.pi * (time - T0) / Tsyst));
    elseif time - T0 < 3 / 2 * Tsyst then
      Et = Edias + (Esys - Edias) / 2 * (1 + cos(2 * Modelica.Constants.pi * (time - T0 - Tsyst) / Tsyst));
    else
      Et = Edias;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0, -8}, extent = {{-60, 46}, {60, -46}}), Text(origin = {16, 10}, extent = {{-50, -28}, {20, 8}}, textString = "HeartE"), Text(origin = {-64, 91}, extent = {{18, -15}, {0, 1}}, textString = "Tsys"), Text(origin = {-57, -91}, extent = {{-5, 7}, {5, -7}}, textString = "T0")}));
  end Heart_Elasticity;

  model Heart_Intervals
    discrete Modelica.Blocks.Interfaces.RealOutput T0 annotation(Placement(visible = true, transformation(origin = {97, -85}, extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {92, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete Modelica.Blocks.Interfaces.RealOutput Tsyst annotation(Placement(visible = true, transformation(origin = {98, 88}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {94, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    discrete Modelica.Blocks.Interfaces.RealInput HR annotation(Placement(visible = true, transformation(origin = {-100, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    discrete Real TPulsePrev;
    Boolean b;
    discrete Real TPulse;
  initial equation
    TPulse = 60 / HR;
    TPulsePrev = TPulse;
    Tsyst = 0.3 * TPulse ^ 0.5;
  equation
    b = time - pre(T0) > pre(TPulse);
    when edge(b) then
      T0 = time;
      TPulse = 60 / HR;
      TPulsePrev = pre(TPulse);
      Tsyst = 0.3 * pre(TPulse) ^ 0.5;
    end when annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Line(origin = {-34, -7}, points = {{0, 27}, {0, -27}, {0, -27}}), Rectangle(origin = {5, -8}, extent = {{-55, 42}, {55, -42}}), Text(origin = {-18, 8}, extent = {{-12, 6}, {74, -42}}, textString = "HeartI"), Text(origin = {77, 86}, extent = {{5, -4}, {-5, 4}}, textString = "Tsyst"), Text(origin = {71, -87}, extent = {{-5, 3}, {5, -3}}, textString = "T0"), Text(origin = {-77, 23}, extent = {{-7, 9}, {7, -9}}, textString = "HR")}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {5, -4}, extent = {{-57, 48}, {57, -48}}), Text(origin = {73, 88}, extent = {{-15, -10}, {1, 0}}, textString = "Tsyst"), Text(origin = {65, -86}, extent = {{5, -4}, {-5, 4}}, textString = "T0"), Text(origin = {8, -1}, extent = {{-52, 29}, {52, -29}}, textString = "HeartI"), Text(origin = {-83, 28}, extent = {{-9, 8}, {9, -8}}, textString = "HR")}));
  end Heart_Intervals;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), uses(Modelica(version = "2.2.2")));
end MOS3;