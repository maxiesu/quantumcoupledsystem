

// Double well AlGaAs/GaAs/AlGaAs/GaAs/AlGaAs



lc_QW = 0.20;
lc = 1.5;

barrier_width = 50.0;
well_width = 10.0;  
overlap = barrier_width / 4.0;



barrier_1 = barrier_width;

well_1 = barrier_1 + well_width;

barrier_2 = well_1 + barrier_width;

barrier_3 = barrier_2 + barrier_width - 2*overlap;

well_2 = barrier_3 + well_width;

barrier_4 = well_2 + barrier_width;

barrier_5 = barrier_4 + barrier_width - 2*overlap;

well_3 = barrier_5 + well_width;

barrier_6 = well_3 + barrier_width;





Point(1) = {0, 0, 0, lc};

Point(2) = {barrier_1, 0, 0, lc_QW};

Point(3) = {well_1, 0, 0, lc_QW};

Point(4) = {barrier_2, 0, 0, lc};

Point(5) = {barrier_3, 0, 0, lc_QW};

Point(6) = {well_2, 0, 0, lc_QW};

Point(7) = {barrier_4, 0, 0, lc};

Point(8) = {barrier_5, 0, 0, lc_QW};

Point(9) = {well_3, 0, 0, lc_QW};

Point(10) = {barrier_6, 0, 0, lc};





Line (1) = {1, 2};

Line (2) = {2, 3};

Line (3) = {3, 4};

Line (4) = {4, 5};

Line (5) = {5, 6};

Line (6) = {6, 7};

Line (7) = {7, 8};

Line (8) = {8, 9};

Line (9) = {9, 10};





Physical Line ("barrier1") = {1};

Physical Line ("well1") = {2};

Physical Line ("barrier2") = {3};

Physical Line ("barrier3") = {4};

Physical Line ("well2") = {5};

Physical Line ("barrier4") = {6};

Physical Line ("barrier5") = {7};

Physical Line ("well3") = {8};

Physical Line ("barrier6") = {9};

