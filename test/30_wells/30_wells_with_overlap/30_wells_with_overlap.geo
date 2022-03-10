

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

barrier_21 = barrier_20 + barrier_width - 2*overlap;

well_11 = barrier_21 + well_width;

barrier_22 = well_11 + barrier_width;

barrier_23 = barrier_22 + barrier_width - 2*overlap;

well_12 = barrier_23 + well_width;

barrier_24 = well_12 + barrier_width;

barrier_25 = barrier_24 + barrier_width - 2*overlap;

well_13 = barrier_25 + well_width;

barrier_26 = well_13 + barrier_width;

barrier_27 = barrier_26 + barrier_width - 2*overlap;

well_14 = barrier_27 + well_width;

barrier_28 = well_14 + barrier_width;

barrier_29 = barrier_28 + barrier_width - 2*overlap;

well_15 = barrier_29 + well_width;

barrier_30 = well_15 + barrier_width;

barrier_31 = barrier_30 + barrier_width - 2*overlap;

well_16 = barrier_31 + well_width;

barrier_32 = well_16 + barrier_width;

barrier_33 = barrier_32 + barrier_width - 2*overlap;

well_17 = barrier_33 + well_width;

barrier_34 = well_17 + barrier_width;

barrier_35 = barrier_34 + barrier_width - 2*overlap;

well_18 = barrier_35 + well_width;

barrier_36 = well_18 + barrier_width;

barrier_37 = barrier_36 + barrier_width - 2*overlap;

well_19 = barrier_37 + well_width;

barrier_38 = well_19 + barrier_width;

barrier_39 = barrier_38 + barrier_width - 2*overlap;

well_20 = barrier_39 + well_width;

barrier_40 = well_20 + barrier_width;

barrier_41 = barrier_40 + barrier_width - 2*overlap;

well_21 = barrier_41 + well_width;

barrier_42 = well_21 + barrier_width;

barrier_43 = barrier_42 + barrier_width - 2*overlap;

well_22 = barrier_43 + well_width;

barrier_44 = well_22 + barrier_width;

barrier_45 = barrier_44 + barrier_width - 2*overlap;

well_23 = barrier_45 + well_width;

barrier_46 = well_23 + barrier_width;

barrier_47 = barrier_46 + barrier_width - 2*overlap;

well_24 = barrier_47 + well_width;

barrier_48 = well_24 + barrier_width;

barrier_49 = barrier_48 + barrier_width - 2*overlap;

well_25 = barrier_49 + well_width;

barrier_50 = well_25 + barrier_width;

barrier_51 = barrier_50 + barrier_width - 2*overlap;

well_26 = barrier_51 + well_width;

barrier_52 = well_26 + barrier_width;

barrier_53 = barrier_52 + barrier_width - 2*overlap;

well_27 = barrier_53 + well_width;

barrier_54 = well_27 + barrier_width;

barrier_55 = barrier_54 + barrier_width - 2*overlap;

well_28 = barrier_55 + well_width;

barrier_56 = well_28 + barrier_width;

barrier_57 = barrier_56 + barrier_width - 2*overlap;

well_29 = barrier_57 + well_width;

barrier_58 = well_29 + barrier_width;

barrier_59 = barrier_58 + barrier_width - 2*overlap;

well_30 = barrier_59 + well_width;

barrier_60 = well_30 + barrier_width;





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

Point(32) = {barrier_21, 0, 0, lc_QW};

Point(33) = {well_11, 0, 0, lc_QW};

Point(34) = {barrier_22, 0, 0, lc};

Point(35) = {barrier_23, 0, 0, lc_QW};

Point(36) = {well_12, 0, 0, lc_QW};

Point(37) = {barrier_24, 0, 0, lc};

Point(38) = {barrier_25, 0, 0, lc_QW};

Point(39) = {well_13, 0, 0, lc_QW};

Point(40) = {barrier_26, 0, 0, lc};

Point(41) = {barrier_27, 0, 0, lc_QW};

Point(42) = {well_14, 0, 0, lc_QW};

Point(43) = {barrier_28, 0, 0, lc};

Point(44) = {barrier_29, 0, 0, lc_QW};

Point(45) = {well_15, 0, 0, lc_QW};

Point(46) = {barrier_30, 0, 0, lc};

Point(47) = {barrier_31, 0, 0, lc_QW};

Point(48) = {well_16, 0, 0, lc_QW};

Point(49) = {barrier_32, 0, 0, lc};

Point(50) = {barrier_33, 0, 0, lc_QW};

Point(51) = {well_17, 0, 0, lc_QW};

Point(52) = {barrier_34, 0, 0, lc};

Point(53) = {barrier_35, 0, 0, lc_QW};

Point(54) = {well_18, 0, 0, lc_QW};

Point(55) = {barrier_36, 0, 0, lc};

Point(56) = {barrier_37, 0, 0, lc_QW};

Point(57) = {well_19, 0, 0, lc_QW};

Point(58) = {barrier_38, 0, 0, lc};

Point(59) = {barrier_39, 0, 0, lc_QW};

Point(60) = {well_20, 0, 0, lc_QW};

Point(61) = {barrier_40, 0, 0, lc};

Point(62) = {barrier_41, 0, 0, lc_QW};

Point(63) = {well_21, 0, 0, lc_QW};

Point(64) = {barrier_42, 0, 0, lc};

Point(65) = {barrier_43, 0, 0, lc_QW};

Point(66) = {well_22, 0, 0, lc_QW};

Point(67) = {barrier_44, 0, 0, lc};

Point(68) = {barrier_45, 0, 0, lc_QW};

Point(69) = {well_23, 0, 0, lc_QW};

Point(70) = {barrier_46, 0, 0, lc};

Point(71) = {barrier_47, 0, 0, lc_QW};

Point(72) = {well_24, 0, 0, lc_QW};

Point(73) = {barrier_48, 0, 0, lc};

Point(74) = {barrier_49, 0, 0, lc_QW};

Point(75) = {well_25, 0, 0, lc_QW};

Point(76) = {barrier_50, 0, 0, lc};

Point(77) = {barrier_51, 0, 0, lc_QW};

Point(78) = {well_26, 0, 0, lc_QW};

Point(79) = {barrier_52, 0, 0, lc};

Point(80) = {barrier_53, 0, 0, lc_QW};

Point(81) = {well_27, 0, 0, lc_QW};

Point(82) = {barrier_54, 0, 0, lc};

Point(83) = {barrier_55, 0, 0, lc_QW};

Point(84) = {well_28, 0, 0, lc_QW};

Point(85) = {barrier_56, 0, 0, lc};

Point(86) = {barrier_57, 0, 0, lc_QW};

Point(87) = {well_29, 0, 0, lc_QW};

Point(88) = {barrier_58, 0, 0, lc};

Point(89) = {barrier_59, 0, 0, lc_QW};

Point(90) = {well_30, 0, 0, lc_QW};

Point(91) = {barrier_60, 0, 0, lc};





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

Line (31) = {31, 32};

Line (32) = {32, 33};

Line (33) = {33, 34};

Line (34) = {34, 35};

Line (35) = {35, 36};

Line (36) = {36, 37};

Line (37) = {37, 38};

Line (38) = {38, 39};

Line (39) = {39, 40};

Line (40) = {40, 41};

Line (41) = {41, 42};

Line (42) = {42, 43};

Line (43) = {43, 44};

Line (44) = {44, 45};

Line (45) = {45, 46};

Line (46) = {46, 47};

Line (47) = {47, 48};

Line (48) = {48, 49};

Line (49) = {49, 50};

Line (50) = {50, 51};

Line (51) = {51, 52};

Line (52) = {52, 53};

Line (53) = {53, 54};

Line (54) = {54, 55};

Line (55) = {55, 56};

Line (56) = {56, 57};

Line (57) = {57, 58};

Line (58) = {58, 59};

Line (59) = {59, 60};

Line (60) = {60, 61};

Line (61) = {61, 62};

Line (62) = {62, 63};

Line (63) = {63, 64};

Line (64) = {64, 65};

Line (65) = {65, 66};

Line (66) = {66, 67};

Line (67) = {67, 68};

Line (68) = {68, 69};

Line (69) = {69, 70};

Line (70) = {70, 71};

Line (71) = {71, 72};

Line (72) = {72, 73};

Line (73) = {73, 74};

Line (74) = {74, 75};

Line (75) = {75, 76};

Line (76) = {76, 77};

Line (77) = {77, 78};

Line (78) = {78, 79};

Line (79) = {79, 80};

Line (80) = {80, 81};

Line (81) = {81, 82};

Line (82) = {82, 83};

Line (83) = {83, 84};

Line (84) = {84, 85};

Line (85) = {85, 86};

Line (86) = {86, 87};

Line (87) = {87, 88};

Line (88) = {88, 89};

Line (89) = {89, 90};

Line (90) = {90, 91};





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

Physical Line ("barrier21") = {31};

Physical Line ("well11") = {32};

Physical Line ("barrier22") = {33};

Physical Line ("barrier23") = {34};

Physical Line ("well12") = {35};

Physical Line ("barrier24") = {36};

Physical Line ("barrier25") = {37};

Physical Line ("well13") = {38};

Physical Line ("barrier26") = {39};

Physical Line ("barrier27") = {40};

Physical Line ("well14") = {41};

Physical Line ("barrier28") = {42};

Physical Line ("barrier29") = {43};

Physical Line ("well15") = {44};

Physical Line ("barrier30") = {45};

Physical Line ("barrier31") = {46};

Physical Line ("well16") = {47};

Physical Line ("barrier32") = {48};

Physical Line ("barrier33") = {49};

Physical Line ("well17") = {50};

Physical Line ("barrier34") = {51};

Physical Line ("barrier35") = {52};

Physical Line ("well18") = {53};

Physical Line ("barrier36") = {54};

Physical Line ("barrier37") = {55};

Physical Line ("well19") = {56};

Physical Line ("barrier38") = {57};

Physical Line ("barrier39") = {58};

Physical Line ("well20") = {59};

Physical Line ("barrier40") = {60};

Physical Line ("barrier41") = {61};

Physical Line ("well21") = {62};

Physical Line ("barrier42") = {63};

Physical Line ("barrier43") = {64};

Physical Line ("well22") = {65};

Physical Line ("barrier44") = {66};

Physical Line ("barrier45") = {67};

Physical Line ("well23") = {68};

Physical Line ("barrier46") = {69};

Physical Line ("barrier47") = {70};

Physical Line ("well24") = {71};

Physical Line ("barrier48") = {72};

Physical Line ("barrier49") = {73};

Physical Line ("well25") = {74};

Physical Line ("barrier50") = {75};

Physical Line ("barrier51") = {76};

Physical Line ("well26") = {77};

Physical Line ("barrier52") = {78};

Physical Line ("barrier53") = {79};

Physical Line ("well27") = {80};

Physical Line ("barrier54") = {81};

Physical Line ("barrier55") = {82};

Physical Line ("well28") = {83};

Physical Line ("barrier56") = {84};

Physical Line ("barrier57") = {85};

Physical Line ("well29") = {86};

Physical Line ("barrier58") = {87};

Physical Line ("barrier59") = {88};

Physical Line ("well30") = {89};

Physical Line ("barrier60") = {90};

