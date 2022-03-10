

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

barrier_7 = barrier_6 + barrier_width - 2*overlap;

well_4 = barrier_7 + well_width;

barrier_8 = well_4 + barrier_width;

barrier_9 = barrier_8 + barrier_width - 2*overlap;

well_5 = barrier_9 + well_width;

barrier_10 = well_5 + barrier_width;

barrier_11 = barrier_10 + barrier_width - 2*overlap;

well_6 = barrier_11 + well_width;

barrier_12 = well_6 + barrier_width;

barrier_13 = barrier_12 + barrier_width - 2*overlap;

well_7 = barrier_13 + well_width;

barrier_14 = well_7 + barrier_width;

barrier_15 = barrier_14 + barrier_width - 2*overlap;

well_8 = barrier_15 + well_width;

barrier_16 = well_8 + barrier_width;

barrier_17 = barrier_16 + barrier_width - 2*overlap;

well_9 = barrier_17 + well_width;

barrier_18 = well_9 + barrier_width;

barrier_19 = barrier_18 + barrier_width - 2*overlap;

well_10 = barrier_19 + well_width;

barrier_20 = well_10 + barrier_width;





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

Point(11) = {barrier_7, 0, 0, lc_QW};

Point(12) = {well_4, 0, 0, lc_QW};

Point(13) = {barrier_8, 0, 0, lc};

Point(14) = {barrier_9, 0, 0, lc_QW};

Point(15) = {well_5, 0, 0, lc_QW};

Point(16) = {barrier_10, 0, 0, lc};

Point(17) = {barrier_11, 0, 0, lc_QW};

Point(18) = {well_6, 0, 0, lc_QW};

Point(19) = {barrier_12, 0, 0, lc};

Point(20) = {barrier_13, 0, 0, lc_QW};

Point(21) = {well_7, 0, 0, lc_QW};

Point(22) = {barrier_14, 0, 0, lc};

Point(23) = {barrier_15, 0, 0, lc_QW};

Point(24) = {well_8, 0, 0, lc_QW};

Point(25) = {barrier_16, 0, 0, lc};

Point(26) = {barrier_17, 0, 0, lc_QW};

Point(27) = {well_9, 0, 0, lc_QW};

Point(28) = {barrier_18, 0, 0, lc};

Point(29) = {barrier_19, 0, 0, lc_QW};

Point(30) = {well_10, 0, 0, lc_QW};

Point(31) = {barrier_20, 0, 0, lc};





Line (1) = {1, 2};

Line (2) = {2, 3};

Line (3) = {3, 4};

Line (4) = {4, 5};

Line (5) = {5, 6};

Line (6) = {6, 7};

Line (7) = {7, 8};

Line (8) = {8, 9};

Line (9) = {9, 10};

Line (10) = {10, 11};

Line (11) = {11, 12};

Line (12) = {12, 13};

Line (13) = {13, 14};

Line (14) = {14, 15};

Line (15) = {15, 16};

Line (16) = {16, 17};

Line (17) = {17, 18};

Line (18) = {18, 19};

Line (19) = {19, 20};

Line (20) = {20, 21};

Line (21) = {21, 22};

Line (22) = {22, 23};

Line (23) = {23, 24};

Line (24) = {24, 25};

Line (25) = {25, 26};

Line (26) = {26, 27};

Line (27) = {27, 28};

Line (28) = {28, 29};

Line (29) = {29, 30};

Line (30) = {30, 31};





Physical Line ("barrier1") = {1};

Physical Line ("well1") = {2};

Physical Line ("barrier2") = {3};

Physical Line ("barrier3") = {4};

Physical Line ("well2") = {5};

Physical Line ("barrier4") = {6};

Physical Line ("barrier5") = {7};

Physical Line ("well3") = {8};

Physical Line ("barrier6") = {9};

Physical Line ("barrier7") = {10};

Physical Line ("well4") = {11};

Physical Line ("barrier8") = {12};

Physical Line ("barrier9") = {13};

Physical Line ("well5") = {14};

Physical Line ("barrier10") = {15};

Physical Line ("barrier11") = {16};

Physical Line ("well6") = {17};

Physical Line ("barrier12") = {18};

Physical Line ("barrier13") = {19};

Physical Line ("well7") = {20};

Physical Line ("barrier14") = {21};

Physical Line ("barrier15") = {22};

Physical Line ("well8") = {23};

Physical Line ("barrier16") = {24};

Physical Line ("barrier17") = {25};

Physical Line ("well9") = {26};

Physical Line ("barrier18") = {27};

Physical Line ("barrier19") = {28};

Physical Line ("well10") = {29};

Physical Line ("barrier20") = {30};


