

x0_square = 0;  
y0_square = 0; 
square_side = 3;
barrier = 10;

//Defining square

Point(1) = {x0_square, y0_square, 0, 0.5};
Point(2) = {x0_square, y0_square + square_side, 0, 0.5};
Point(3) = {x0_square + square_side, y0_square + square_side, 0, 0.5};
Point(4) = {x0_square + square_side, y0_square, 0, 0.5};


x0_outer = x0_square - barrier;
y0_outer = y0_square - barrier;
rect_side = square_side + 2 * barrier;

Point(5) = {x0_outer, y0_outer, 0, 4};
Point(6) = {x0_outer, y0_outer + rect_side, 0, 4};
Point(7) = {x0_outer + rect_side, y0_outer + rect_side, 0, 4};
Point(8) = {x0_outer + rect_side, y0_outer, 0, 4};



Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 5};


Line Loop(9) = {1, 2, 3, 4};
Plane Surface(10) = {9};
Line Loop(11) = {5, 6, 7, 8};
Plane Surface(12) = {9, 11};




Physical Surface("wire") = {10};
Physical Surface("barrier") = {12};
