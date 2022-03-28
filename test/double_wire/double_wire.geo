

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


x0_square2 = x0_square + square_side + 2*barrier;
Point(7) = {x0_square2, y0_square, 0, 0.5};
Point(8) = {x0_square2, y0_square + square_side, 0, 0.5};
Point(9) = {x0_square2 + square_side, y0_square + square_side, 0, 0.5};
Point(10) = {x0_square2 + square_side, y0_square, 0, 0.5};
Point(11) = {x0_square2 + square_side + barrier, y0_square + square_side + barrier, 0, 4};
Point(12) = {x0_square2 + square_side + barrier, y0_square - barrier, 0, 4};


Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

Line(5) = {5, 6};
Line(6) = {6, 11};
Line(7) = {11, 12};
Line(8) = {12, 5};

Line(9) = {7, 8};
Line(10) = {8, 9};
Line(11) = {9, 10};
Line(12) = {10, 7};



Line Loop(13) = {1, 2, 3, 4};
Plane Surface(14) = {13};
Line Loop(15) = {9, 10, 11, 12};
Plane Surface(16) = {15};

Line Loop(17) = {5, 6, 7, 8};
Plane Surface(18) = {13, 15, 17};


Physical Surface("wire1") = {14};
Physical Surface("wire2") = {16};
Physical Surface("barrier") = {18};
