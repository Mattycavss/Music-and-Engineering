% Provided code to extract C and D coefficients for poly-phase filter bank
% and inverse.
D=NaN(1,512);
D(  0+1)= 0.000000000;D(  1+1)=-0.000015259;D(  2+1)=-0.000015259;D(  3+1)=-0.000015259;
D(  4+1)=-0.000015259;D(  5+1)=-0.000015259;D(  6+1)=-0.000015259;D(  7+1)=-0.000030518;
D(  8+1)=-0.000030518;D(  9+1)=-0.000030518;D( 10+1)=-0.000030518;D( 11+1)=-0.000045776;
D( 12+1)=-0.000045776;D( 13+1)=-0.000061035;D( 14+1)=-0.000061035;D( 15+1)=-0.000076294;
D( 16+1)=-0.000076294;D( 17+1)=-0.000091553;D( 18+1)=-0.000106812;D( 19+1)=-0.000106812;
D( 20+1)=-0.000122070;D( 21+1)=-0.000137329;D( 22+1)=-0.000152588;D( 23+1)=-0.000167847;
D( 24+1)=-0.000198364;D( 25+1)=-0.000213623;D( 26+1)=-0.000244141;D( 27+1)=-0.000259399;
D( 28+1)=-0.000289917;D( 29+1)=-0.000320435;D( 30+1)=-0.000366211;D( 31+1)=-0.000396729;
D( 32+1)=-0.000442505;D( 33+1)=-0.000473022;D( 34+1)=-0.000534058;D( 35+1)=-0.000579834;
D( 36+1)=-0.000625610;D( 37+1)=-0.000686646;D( 38+1)=-0.000747681;D( 39+1)=-0.000808716;
D( 40+1)=-0.000885010;D( 41+1)=-0.000961304;D( 42+1)=-0.001037598;D( 43+1)=-0.001113892;
D( 44+1)=-0.001205444;D( 45+1)=-0.001296997;D( 46+1)=-0.001388550;D( 47+1)=-0.001480103;
D( 48+1)=-0.001586914;D( 49+1)=-0.001693726;D( 50+1)=-0.001785278;D( 51+1)=-0.001907349;
D( 52+1)=-0.002014160;D( 53+1)=-0.002120972;D( 54+1)=-0.002243042;D( 55+1)=-0.002349854;
D( 56+1)=-0.002456665;D( 57+1)=-0.002578735;D( 58+1)=-0.002685547;D( 59+1)=-0.002792358;
D( 60+1)=-0.002899170;D( 61+1)=-0.002990723;D( 62+1)=-0.003082275;D( 63+1)=-0.003173828;
D( 64+1)= 0.003250122;D( 65+1)= 0.003326416;D( 66+1)= 0.003387451;D( 67+1)= 0.003433228;
D( 68+1)= 0.003463745;D( 69+1)= 0.003479004;D( 70+1)= 0.003479004;D( 71+1)= 0.003463745;
D( 72+1)= 0.003417969;D( 73+1)= 0.003372192;D( 74+1)= 0.003280640;D( 75+1)= 0.003173828;
D( 76+1)= 0.003051758;D( 77+1)= 0.002883911;D( 78+1)= 0.002700806;D( 79+1)= 0.002487183;
D( 80+1)= 0.002227783;D( 81+1)= 0.001937866;D( 82+1)= 0.001617432;D( 83+1)= 0.001266479;
D( 84+1)= 0.000869751;D( 85+1)= 0.000442505;D( 86+1)=-0.000030518;D( 87+1)=-0.000549316;
D( 88+1)=-0.001098633;D( 89+1)=-0.001693726;D( 90+1)=-0.002334595;D( 91+1)=-0.003005981;
D( 92+1)=-0.003723145;D( 93+1)=-0.004486084;D( 94+1)=-0.005294800;D( 95+1)=-0.006118774;
D( 96+1)=-0.007003784;D( 97+1)=-0.007919312;D( 98+1)=-0.008865356;D( 99+1)=-0.009841919;
D(100+1)=-0.010848999;D(101+1)=-0.011886597;D(102+1)=-0.012939453;D(103+1)=-0.014022827;
D(104+1)=-0.015121460;D(105+1)=-0.016235352;D(106+1)=-0.017349243;D(107+1)=-0.018463135;
D(108+1)=-0.019577026;D(109+1)=-0.020690918;D(110+1)=-0.021789551;D(111+1)=-0.022857666;
D(112+1)=-0.023910522;D(113+1)=-0.024932861;D(114+1)=-0.025909424;D(115+1)=-0.026840210;
D(116+1)=-0.027725220;D(117+1)=-0.028533936;D(118+1)=-0.029281616;D(119+1)=-0.029937744;
D(120+1)=-0.030532837;D(121+1)=-0.031005859;D(122+1)=-0.031387329;D(123+1)=-0.031661987;
D(124+1)=-0.031814575;D(125+1)=-0.031845093;D(126+1)=-0.031738281;D(127+1)=-0.031478882;
D(128+1)= 0.031082153;D(129+1)= 0.030517578;D(130+1)= 0.029785156;D(131+1)= 0.028884888;
D(132+1)= 0.027801514;D(133+1)= 0.026535034;D(134+1)= 0.025085449;D(135+1)= 0.023422241;
D(136+1)= 0.021575928;D(137+1)= 0.019531250;D(138+1)= 0.017257690;D(139+1)= 0.014801025;
D(140+1)= 0.012115479;D(141+1)= 0.009231567;D(142+1)= 0.006134033;D(143+1)= 0.002822876;
D(144+1)=-0.000686646;D(145+1)=-0.004394531;D(146+1)=-0.008316040;D(147+1)=-0.012420654;
D(148+1)=-0.016708374;D(149+1)=-0.021179199;D(150+1)=-0.025817871;D(151+1)=-0.030609131;
D(152+1)=-0.035552979;D(153+1)=-0.040634155;D(154+1)=-0.045837402;D(155+1)=-0.051132202;
D(156+1)=-0.056533813;D(157+1)=-0.061996460;D(158+1)=-0.067520142;D(159+1)=-0.073059082;
D(160+1)=-0.078628540;D(161+1)=-0.084182739;D(162+1)=-0.089706421;D(163+1)=-0.095169067;
D(164+1)=-0.100540161;D(165+1)=-0.105819702;D(166+1)=-0.110946655;D(167+1)=-0.115921021;
D(168+1)=-0.120697021;D(169+1)=-0.125259399;D(170+1)=-0.129562378;D(171+1)=-0.133590698;
D(172+1)=-0.137298584;D(173+1)=-0.140670776;D(174+1)=-0.143676758;D(175+1)=-0.146255493;
D(176+1)=-0.148422241;D(177+1)=-0.150115967;D(178+1)=-0.151306152;D(179+1)=-0.151962280;
D(180+1)=-0.152069092;D(181+1)=-0.151596069;D(182+1)=-0.150497437;D(183+1)=-0.148773193;
D(184+1)=-0.146362305;D(185+1)=-0.143264771;D(186+1)=-0.139450073;D(187+1)=-0.134887695;
D(188+1)=-0.129577637;D(189+1)=-0.123474121;D(190+1)=-0.116577148;D(191+1)=-0.108856201;
D(192+1)= 0.100311279;D(193+1)= 0.090927124;D(194+1)= 0.080688477;D(195+1)= 0.069595337;
D(196+1)= 0.057617187;D(197+1)= 0.044784546;D(198+1)= 0.031082153;D(199+1)= 0.016510010;
D(200+1)= 0.001068115;D(201+1)=-0.015228271;D(202+1)=-0.032379150;D(203+1)=-0.050354004;
D(204+1)=-0.069168091;D(205+1)=-0.088775635;D(206+1)=-0.109161377;D(207+1)=-0.130310059;
D(208+1)=-0.152206421;D(209+1)=-0.174789429;D(210+1)=-0.198059082;D(211+1)=-0.221984863;
D(212+1)=-0.246505737;D(213+1)=-0.271591187;D(214+1)=-0.297210693;D(215+1)=-0.323318481;
D(216+1)=-0.349868774;D(217+1)=-0.376800537;D(218+1)=-0.404083252;D(219+1)=-0.431655884;
D(220+1)=-0.459472656;D(221+1)=-0.487472534;D(222+1)=-0.515609741;D(223+1)=-0.543823242;
D(224+1)=-0.572036743;D(225+1)=-0.600219727;D(226+1)=-0.628295898;D(227+1)=-0.656219482;
D(228+1)=-0.683914185;D(229+1)=-0.711318970;D(230+1)=-0.738372803;D(231+1)=-0.765029907;
D(232+1)=-0.791213989;D(233+1)=-0.816864014;D(234+1)=-0.841949463;D(235+1)=-0.866363525;
D(236+1)=-0.890090942;D(237+1)=-0.913055420;D(238+1)=-0.935195923;D(239+1)=-0.956481934;
D(240+1)=-0.976852417;D(241+1)=-0.996246338;D(242+1)=-1.014617920;D(243+1)=-1.031936646;
D(244+1)=-1.048156738;D(245+1)=-1.063217163;D(246+1)=-1.077117920;D(247+1)=-1.089782715;
D(248+1)=-1.101211548;D(249+1)=-1.111373901;D(250+1)=-1.120223999;D(251+1)=-1.127746582;
D(252+1)=-1.133926392;D(253+1)=-1.138763428;D(254+1)=-1.142211914;D(255+1)=-1.144287109;
D(256+1)= 1.144989014;D(257+1)= 1.144287109;D(258+1)= 1.142211914;D(259+1)= 1.138763428;
D(260+1)= 1.133926392;D(261+1)= 1.127746582;D(262+1)= 1.120223999;D(263+1)= 1.111373901;
D(264+1)= 1.101211548;D(265+1)= 1.089782715;D(266+1)= 1.077117920;D(267+1)= 1.063217163;
D(268+1)= 1.048156738;D(269+1)= 1.031936646;D(270+1)= 1.014617920;D(271+1)= 0.996246338;
D(272+1)= 0.976852417;D(273+1)= 0.956481934;D(274+1)= 0.935195923;D(275+1)= 0.913055420;
D(276+1)= 0.890090942;D(277+1)= 0.866363525;D(278+1)= 0.841949463;D(279+1)= 0.816864014;
D(280+1)= 0.791213989;D(281+1)= 0.765029907;D(282+1)= 0.738372803;D(283+1)= 0.711318970;
D(284+1)= 0.683914185;D(285+1)= 0.656219482;D(286+1)= 0.628295898;D(287+1)= 0.600219727;
D(288+1)= 0.572036743;D(289+1)= 0.543823242;D(290+1)= 0.515609741;D(291+1)= 0.487472534;
D(292+1)= 0.459472656;D(293+1)= 0.431655884;D(294+1)= 0.404083252;D(295+1)= 0.376800537;
D(296+1)= 0.349868774;D(297+1)= 0.323318481;D(298+1)= 0.297210693;D(299+1)= 0.271591187;
D(300+1)= 0.246505737;D(301+1)= 0.221984863;D(302+1)= 0.198059082;D(303+1)= 0.174789429;
D(304+1)= 0.152206421;D(305+1)= 0.130310059;D(306+1)= 0.109161377;D(307+1)= 0.088775635;
D(308+1)= 0.069168091;D(309+1)= 0.050354004;D(310+1)= 0.032379150;D(311+1)= 0.015228271;
D(312+1)=-0.001068115;D(313+1)=-0.016510010;D(314+1)=-0.031082153;D(315+1)=-0.044784546;
D(316+1)=-0.057617187;D(317+1)=-0.069595337;D(318+1)=-0.080688477;D(319+1)=-0.090927124;
D(320+1)= 0.100311279;D(321+1)= 0.108856201;D(322+1)= 0.116577148;D(323+1)= 0.123474121;
D(324+1)= 0.129577637;D(325+1)= 0.134887695;D(326+1)= 0.139450073;D(327+1)= 0.143264771;
D(328+1)= 0.146362305;D(329+1)= 0.148773193;D(330+1)= 0.150497437;D(331+1)= 0.151596069;
D(332+1)= 0.152069092;D(333+1)= 0.151962280;D(334+1)= 0.151306152;D(335+1)= 0.150115967;
D(336+1)= 0.148422241;D(337+1)= 0.146255493;D(338+1)= 0.143676758;D(339+1)= 0.140670776;
D(340+1)= 0.137298584;D(341+1)= 0.133590698;D(342+1)= 0.129562378;D(343+1)= 0.125259399;
D(344+1)= 0.120697021;D(345+1)= 0.115921021;D(346+1)= 0.110946655;D(347+1)= 0.105819702;
D(348+1)= 0.100540161;D(349+1)= 0.095169067;D(350+1)= 0.089706421;D(351+1)= 0.084182739;
D(352+1)= 0.078628540;D(353+1)= 0.073059082;D(354+1)= 0.067520142;D(355+1)= 0.061996460;
D(356+1)= 0.056533813;D(357+1)= 0.051132202;D(358+1)= 0.045837402;D(359+1)= 0.040634155;
D(360+1)= 0.035552979;D(361+1)= 0.030609131;D(362+1)= 0.025817871;D(363+1)= 0.021179199;
D(364+1)= 0.016708374;D(365+1)= 0.012420654;D(366+1)= 0.008316040;D(367+1)= 0.004394531;
D(368+1)= 0.000686646;D(369+1)=-0.002822876;D(370+1)=-0.006134033;D(371+1)=-0.009231567;
D(372+1)=-0.012115479;D(373+1)=-0.014801025;D(374+1)=-0.017257690;D(375+1)=-0.019531250;
D(376+1)=-0.021575928;D(377+1)=-0.023422241;D(378+1)=-0.025085449;D(379+1)=-0.026535034;
D(380+1)=-0.027801514;D(381+1)=-0.028884888;D(382+1)=-0.029785156;D(383+1)=-0.030517578;
D(384+1)= 0.031082153;D(385+1)= 0.031478882;D(386+1)= 0.031738281;D(387+1)= 0.031845093;
D(388+1)= 0.031814575;D(389+1)= 0.031661987;D(390+1)= 0.031387329;D(391+1)= 0.031005859;
D(392+1)= 0.030532837;D(393+1)= 0.029937744;D(394+1)= 0.029281616;D(395+1)= 0.028533936;
D(396+1)= 0.027725220;D(397+1)= 0.026840210;D(398+1)= 0.025909424;D(399+1)= 0.024932861;
D(400+1)= 0.023910522;D(401+1)= 0.022857666;D(402+1)= 0.021789551;D(403+1)= 0.020690918;
D(404+1)= 0.019577026;D(405+1)= 0.018463135;D(406+1)= 0.017349243;D(407+1)= 0.016235352;
D(408+1)= 0.015121460;D(409+1)= 0.014022827;D(410+1)= 0.012939453;D(411+1)= 0.011886597;
D(412+1)= 0.010848999;D(413+1)= 0.009841919;D(414+1)= 0.008865356;D(415+1)= 0.007919312;
D(416+1)= 0.007003784;D(417+1)= 0.006118774;D(418+1)= 0.005294800;D(419+1)= 0.004486084;
D(420+1)= 0.003723145;D(421+1)= 0.003005981;D(422+1)= 0.002334595;D(423+1)= 0.001693726;
D(424+1)= 0.001098633;D(425+1)= 0.000549316;D(426+1)= 0.000030518;D(427+1)=-0.000442505;
D(428+1)=-0.000869751;D(429+1)=-0.001266479;D(430+1)=-0.001617432;D(431+1)=-0.001937866;
D(432+1)=-0.002227783;D(433+1)=-0.002487183;D(434+1)=-0.002700806;D(435+1)=-0.002883911;
D(436+1)=-0.003051758;D(437+1)=-0.003173828;D(438+1)=-0.003280640;D(439+1)=-0.003372192;
D(440+1)=-0.003417969;D(441+1)=-0.003463745;D(442+1)=-0.003479004;D(443+1)=-0.003479004;
D(444+1)=-0.003463745;D(445+1)=-0.003433228;D(446+1)=-0.003387451;D(447+1)=-0.003326416;
D(448+1)= 0.003250122;D(449+1)= 0.003173828;D(450+1)= 0.003082275;D(451+1)= 0.002990723;
D(452+1)= 0.002899170;D(453+1)= 0.002792358;D(454+1)= 0.002685547;D(455+1)= 0.002578735;
D(456+1)= 0.002456665;D(457+1)= 0.002349854;D(458+1)= 0.002243042;D(459+1)= 0.002120972;
D(460+1)= 0.002014160;D(461+1)= 0.001907349;D(462+1)= 0.001785278;D(463+1)= 0.001693726;
D(464+1)= 0.001586914;D(465+1)= 0.001480103;D(466+1)= 0.001388550;D(467+1)= 0.001296997;
D(468+1)= 0.001205444;D(469+1)= 0.001113892;D(470+1)= 0.001037598;D(471+1)= 0.000961304;
D(472+1)= 0.000885010;D(473+1)= 0.000808716;D(474+1)= 0.000747681;D(475+1)= 0.000686646;
D(476+1)= 0.000625610;D(477+1)= 0.000579834;D(478+1)= 0.000534058;D(479+1)= 0.000473022;
D(480+1)= 0.000442505;D(481+1)= 0.000396729;D(482+1)= 0.000366211;D(483+1)= 0.000320435;
D(484+1)= 0.000289917;D(485+1)= 0.000259399;D(486+1)= 0.000244141;D(487+1)= 0.000213623;
D(488+1)= 0.000198364;D(489+1)= 0.000167847;D(490+1)= 0.000152588;D(491+1)= 0.000137329;
D(492+1)= 0.000122070;D(493+1)= 0.000106812;D(494+1)= 0.000106812;D(495+1)= 0.000091553;
D(496+1)= 0.000076294;D(497+1)= 0.000076294;D(498+1)= 0.000061035;D(499+1)= 0.000061035;
D(500+1)= 0.000045776;D(501+1)= 0.000045776;D(502+1)= 0.000030518;D(503+1)= 0.000030518;
D(504+1)= 0.000030518;D(505+1)= 0.000030518;D(506+1)= 0.000015259;D(507+1)= 0.000015259;
D(508+1)= 0.000015259;D(509+1)= 0.000015259;D(510+1)= 0.000015259;D(511+1)= 0.000015259;

C(  0+1)= 0.000000000;C(  1+1)=-0.000000477;C(  2+1)=-0.000000477;C(  3+1)=-0.000000477;
C(  4+1)=-0.000000477;C(  5+1)=-0.000000477;C(  6+1)=-0.000000477;C(  7+1)=-0.000000954;
C(  8+1)=-0.000000954;C(  9+1)=-0.000000954;C( 10+1)=-0.000000954;C( 11+1)=-0.000001431;
C( 12+1)=-0.000001431;C( 13+1)=-0.000001907;C( 14+1)=-0.000001907;C( 15+1)=-0.000002384;
C( 16+1)=-0.000002384;C( 17+1)=-0.000002861;C( 18+1)=-0.000003338;C( 19+1)=-0.000003338;
C( 20+1)=-0.000003815;C( 21+1)=-0.000004292;C( 22+1)=-0.000004768;C( 23+1)=-0.000005245;
C( 24+1)=-0.000006199;C( 25+1)=-0.000006676;C( 26+1)=-0.000007629;C( 27+1)=-0.000008106;
C( 28+1)=-0.000009060;C( 29+1)=-0.000010014;C( 30+1)=-0.000011444;C( 31+1)=-0.000012398;
C( 32+1)=-0.000013828;C( 33+1)=-0.000014782;C( 34+1)=-0.000016689;C( 35+1)=-0.000018120;
C( 36+1)=-0.000019550;C( 37+1)=-0.000021458;C( 38+1)=-0.000023365;C( 39+1)=-0.000025272;
C( 40+1)=-0.000027657;C( 41+1)=-0.000030041;C( 42+1)=-0.000032425;C( 43+1)=-0.000034809;
C( 44+1)=-0.000037670;C( 45+1)=-0.000040531;C( 46+1)=-0.000043392;C( 47+1)=-0.000046253;
C( 48+1)=-0.000049591;C( 49+1)=-0.000052929;C( 50+1)=-0.000055790;C( 51+1)=-0.000059605;
C( 52+1)=-0.000062943;C( 53+1)=-0.000066280;C( 54+1)=-0.000070095;C( 55+1)=-0.000073433;
C( 56+1)=-0.000076771;C( 57+1)=-0.000080585;C( 58+1)=-0.000083923;C( 59+1)=-0.000087261;
C( 60+1)=-0.000090599;C( 61+1)=-0.000093460;C( 62+1)=-0.000096321;C( 63+1)=-0.000099182;
C( 64+1)= 0.000101566;C( 65+1)= 0.000103951;C( 66+1)= 0.000105858;C( 67+1)= 0.000107288;
C( 68+1)= 0.000108242;C( 69+1)= 0.000108719;C( 70+1)= 0.000108719;C( 71+1)= 0.000108242;
C( 72+1)= 0.000106812;C( 73+1)= 0.000105381;C( 74+1)= 0.000102520;C( 75+1)= 0.000099182;
C( 76+1)= 0.000095367;C( 77+1)= 0.000090122;C( 78+1)= 0.000084400;C( 79+1)= 0.000077724;
C( 80+1)= 0.000069618;C( 81+1)= 0.000060558;C( 82+1)= 0.000050545;C( 83+1)= 0.000039577;
C( 84+1)= 0.000027180;C( 85+1)= 0.000013828;C( 86+1)=-0.000000954;C( 87+1)=-0.000017166;
C( 88+1)=-0.000034332;C( 89+1)=-0.000052929;C( 90+1)=-0.000072956;C( 91+1)=-0.000093937;
C( 92+1)=-0.000116348;C( 93+1)=-0.000140190;C( 94+1)=-0.000165462;C( 95+1)=-0.000191212;
C( 96+1)=-0.000218868;C( 97+1)=-0.000247478;C( 98+1)=-0.000277042;C( 99+1)=-0.000307560;
C(100+1)=-0.000339031;C(101+1)=-0.000371456;C(102+1)=-0.000404358;C(103+1)=-0.000438213;
C(104+1)=-0.000472546;C(105+1)=-0.000507355;C(106+1)=-0.000542164;C(107+1)=-0.000576973;
C(108+1)=-0.000611782;C(109+1)=-0.000646591;C(110+1)=-0.000680923;C(111+1)=-0.000714302;
C(112+1)=-0.000747204;C(113+1)=-0.000779152;C(114+1)=-0.000809669;C(115+1)=-0.000838757;
C(116+1)=-0.000866413;C(117+1)=-0.000891685;C(118+1)=-0.000915051;C(119+1)=-0.000935555;
C(120+1)=-0.000954151;C(121+1)=-0.000968933;C(122+1)=-0.000980854;C(123+1)=-0.000989437;
C(124+1)=-0.000994205;C(125+1)=-0.000995159;C(126+1)=-0.000991821;C(127+1)=-0.000983715;
C(128+1)= 0.000971317;C(129+1)= 0.000953674;C(130+1)= 0.000930786;C(131+1)= 0.000902653;
C(132+1)= 0.000868797;C(133+1)= 0.000829220;C(134+1)= 0.000783920;C(135+1)= 0.000731945;
C(136+1)= 0.000674248;C(137+1)= 0.000610352;C(138+1)= 0.000539303;C(139+1)= 0.000462532;
C(140+1)= 0.000378609;C(141+1)= 0.000288486;C(142+1)= 0.000191689;C(143+1)= 0.000088215;
C(144+1)=-0.000021458;C(145+1)=-0.000137329;C(146+1)=-0.000259876;C(147+1)=-0.000388145;
C(148+1)=-0.000522137;C(149+1)=-0.000661850;C(150+1)=-0.000806808;C(151+1)=-0.000956535;
C(152+1)=-0.001111031;C(153+1)=-0.001269817;C(154+1)=-0.001432419;C(155+1)=-0.001597881;
C(156+1)=-0.001766682;C(157+1)=-0.001937389;C(158+1)=-0.002110004;C(159+1)=-0.002283096;
C(160+1)=-0.002457142;C(161+1)=-0.002630711;C(162+1)=-0.002803326;C(163+1)=-0.002974033;
C(164+1)=-0.003141880;C(165+1)=-0.003306866;C(166+1)=-0.003467083;C(167+1)=-0.003622532;
C(168+1)=-0.003771782;C(169+1)=-0.003914356;C(170+1)=-0.004048824;C(171+1)=-0.004174709;
C(172+1)=-0.004290581;C(173+1)=-0.004395962;C(174+1)=-0.004489899;C(175+1)=-0.004570484;
C(176+1)=-0.004638195;C(177+1)=-0.004691124;C(178+1)=-0.004728317;C(179+1)=-0.004748821;
C(180+1)=-0.004752159;C(181+1)=-0.004737377;C(182+1)=-0.004703045;C(183+1)=-0.004649162;
C(184+1)=-0.004573822;C(185+1)=-0.004477024;C(186+1)=-0.004357815;C(187+1)=-0.004215240;
C(188+1)=-0.004049301;C(189+1)=-0.003858566;C(190+1)=-0.003643036;C(191+1)=-0.003401756;
C(192+1)= 0.003134727;C(193+1)= 0.002841473;C(194+1)= 0.002521515;C(195+1)= 0.002174854;
C(196+1)= 0.001800537;C(197+1)= 0.001399517;C(198+1)= 0.000971317;C(199+1)= 0.000515938;
C(200+1)= 0.000033379;C(201+1)=-0.000475883;C(202+1)=-0.001011848;C(203+1)=-0.001573563;
C(204+1)=-0.002161503;C(205+1)=-0.002774239;C(206+1)=-0.003411293;C(207+1)=-0.004072189;
C(208+1)=-0.004756451;C(209+1)=-0.005462170;C(210+1)=-0.006189346;C(211+1)=-0.006937027;
C(212+1)=-0.007703304;C(213+1)=-0.008487225;C(214+1)=-0.009287834;C(215+1)=-0.010103703;
C(216+1)=-0.010933399;C(217+1)=-0.011775017;C(218+1)=-0.012627602;C(219+1)=-0.013489246;
C(220+1)=-0.014358521;C(221+1)=-0.015233517;C(222+1)=-0.016112804;C(223+1)=-0.016994476;
C(224+1)=-0.017876148;C(225+1)=-0.018756866;C(226+1)=-0.019634247;C(227+1)=-0.020506859;
C(228+1)=-0.021372318;C(229+1)=-0.022228718;C(230+1)=-0.023074150;C(231+1)=-0.023907185;
C(232+1)=-0.024725437;C(233+1)=-0.025527000;C(234+1)=-0.026310921;C(235+1)=-0.027073860;
C(236+1)=-0.027815342;C(237+1)=-0.028532982;C(238+1)=-0.029224873;C(239+1)=-0.029890060;
C(240+1)=-0.030526638;C(241+1)=-0.031132698;C(242+1)=-0.031706810;C(243+1)=-0.032248020;
C(244+1)=-0.032754898;C(245+1)=-0.033225536;C(246+1)=-0.033659935;C(247+1)=-0.034055710;
C(248+1)=-0.034412861;C(249+1)=-0.034730434;C(250+1)=-0.035007000;C(251+1)=-0.035242081;
C(252+1)=-0.035435200;C(253+1)=-0.035586357;C(254+1)=-0.035694122;C(255+1)=-0.035758972;
C(256+1)= 0.035780907;C(257+1)= 0.035758972;C(258+1)= 0.035694122;C(259+1)= 0.035586357;
C(260+1)= 0.035435200;C(261+1)= 0.035242081;C(262+1)= 0.035007000;C(263+1)= 0.034730434;
C(264+1)= 0.034412861;C(265+1)= 0.034055710;C(266+1)= 0.033659935;C(267+1)= 0.033225536;
C(268+1)= 0.032754898;C(269+1)= 0.032248020;C(270+1)= 0.031706810;C(271+1)= 0.031132698;
C(272+1)= 0.030526638;C(273+1)= 0.029890060;C(274+1)= 0.029224873;C(275+1)= 0.028532982;
C(276+1)= 0.027815342;C(277+1)= 0.027073860;C(278+1)= 0.026310921;C(279+1)= 0.025527000;
C(280+1)= 0.024725437;C(281+1)= 0.023907185;C(282+1)= 0.023074150;C(283+1)= 0.022228718;
C(284+1)= 0.021372318;C(285+1)= 0.020506859;C(286+1)= 0.019634247;C(287+1)= 0.018756866;
C(288+1)= 0.017876148;C(289+1)= 0.016994476;C(290+1)= 0.016112804;C(291+1)= 0.015233517;
C(292+1)= 0.014358521;C(293+1)= 0.013489246;C(294+1)= 0.012627602;C(295+1)= 0.011775017;
C(296+1)= 0.010933399;C(297+1)= 0.010103703;C(298+1)= 0.009287834;C(299+1)= 0.008487225;
C(300+1)= 0.007703304;C(301+1)= 0.006937027;C(302+1)= 0.006189346;C(303+1)= 0.005462170;
C(304+1)= 0.004756451;C(305+1)= 0.004072189;C(306+1)= 0.003411293;C(307+1)= 0.002774239;
C(308+1)= 0.002161503;C(309+1)= 0.001573563;C(310+1)= 0.001011848;C(311+1)= 0.000475883;
C(312+1)=-0.000033379;C(313+1)=-0.000515938;C(314+1)=-0.000971317;C(315+1)=-0.001399517;
C(316+1)=-0.001800537;C(317+1)=-0.002174854;C(318+1)=-0.002521515;C(319+1)=-0.002841473;
C(320+1)= 0.003134727;C(321+1)= 0.003401756;C(322+1)= 0.003643036;C(323+1)= 0.003858566;
C(324+1)= 0.004049301;C(325+1)= 0.004215240;C(326+1)= 0.004357815;C(327+1)= 0.004477024;
C(328+1)= 0.004573822;C(329+1)= 0.004649162;C(330+1)= 0.004703045;C(331+1)= 0.004737377;
C(332+1)= 0.004752159;C(333+1)= 0.004748821;C(334+1)= 0.004728317;C(335+1)= 0.004691124;
C(336+1)= 0.004638195;C(337+1)= 0.004570484;C(338+1)= 0.004489899;C(339+1)= 0.004395962;
C(340+1)= 0.004290581;C(341+1)= 0.004174709;C(342+1)= 0.004048824;C(343+1)= 0.003914356;
C(344+1)= 0.003771782;C(345+1)= 0.003622532;C(346+1)= 0.003467083;C(347+1)= 0.003306866;
C(348+1)= 0.003141880;C(349+1)= 0.002974033;C(350+1)= 0.002803326;C(351+1)= 0.002630711;
C(352+1)= 0.002457142;C(353+1)= 0.002283096;C(354+1)= 0.002110004;C(355+1)= 0.001937389;
C(356+1)= 0.001766682;C(357+1)= 0.001597881;C(358+1)= 0.001432419;C(359+1)= 0.001269817;
C(360+1)= 0.001111031;C(361+1)= 0.000956535;C(362+1)= 0.000806808;C(363+1)= 0.000661850;
C(364+1)= 0.000522137;C(365+1)= 0.000388145;C(366+1)= 0.000259876;C(367+1)= 0.000137329;
C(368+1)= 0.000021458;C(369+1)=-0.000088215;C(370+1)=-0.000191689;C(371+1)=-0.000288486;
C(372+1)=-0.000378609;C(373+1)=-0.000462532;C(374+1)=-0.000539303;C(375+1)=-0.000610352;
C(376+1)=-0.000674248;C(377+1)=-0.000731945;C(378+1)=-0.000783920;C(379+1)=-0.000829220;
C(380+1)=-0.000868797;C(381+1)=-0.000902653;C(382+1)=-0.000930786;C(383+1)=-0.000953674;
C(384+1)= 0.000971317;C(385+1)= 0.000983715;C(386+1)= 0.000991821;C(387+1)= 0.000995159;
C(388+1)= 0.000994205;C(389+1)= 0.000989437;C(390+1)= 0.000980854;C(391+1)= 0.000968933;
C(392+1)= 0.000954151;C(393+1)= 0.000935555;C(394+1)= 0.000915051;C(395+1)= 0.000891685;
C(396+1)= 0.000866413;C(397+1)= 0.000838757;C(398+1)= 0.000809669;C(399+1)= 0.000779152;
C(400+1)= 0.000747204;C(401+1)= 0.000714302;C(402+1)= 0.000680923;C(403+1)= 0.000646591;
C(404+1)= 0.000611782;C(405+1)= 0.000576973;C(406+1)= 0.000542164;C(407+1)= 0.000507355;
C(408+1)= 0.000472546;C(409+1)= 0.000438213;C(410+1)= 0.000404358;C(411+1)= 0.000371456;
C(412+1)= 0.000339031;C(413+1)= 0.000307560;C(414+1)= 0.000277042;C(415+1)= 0.000247478;
C(416+1)= 0.000218868;C(417+1)= 0.000191212;C(418+1)= 0.000165462;C(419+1)= 0.000140190;
C(420+1)= 0.000116348;C(421+1)= 0.000093937;C(422+1)= 0.000072956;C(423+1)= 0.000052929;
C(424+1)= 0.000034332;C(425+1)= 0.000017166;C(426+1)= 0.000000954;C(427+1)=-0.000013828;
C(428+1)=-0.000027180;C(429+1)=-0.000039577;C(430+1)=-0.000050545;C(431+1)=-0.000060558;
C(432+1)=-0.000069618;C(433+1)=-0.000077724;C(434+1)=-0.000084400;C(435+1)=-0.000090122;
C(436+1)=-0.000095367;C(437+1)=-0.000099182;C(438+1)=-0.000102520;C(439+1)=-0.000105381;
C(440+1)=-0.000106812;C(441+1)=-0.000108242;C(442+1)=-0.000108719;C(443+1)=-0.000108719;
C(444+1)=-0.000108242;C(445+1)=-0.000107288;C(446+1)=-0.000105858;C(447+1)=-0.000103951;
C(448+1)= 0.000101566;C(449+1)= 0.000099182;C(450+1)= 0.000096321;C(451+1)= 0.000093460;
C(452+1)= 0.000090599;C(453+1)= 0.000087261;C(454+1)= 0.000083923;C(455+1)= 0.000080585;
C(456+1)= 0.000076771;C(457+1)= 0.000073433;C(458+1)= 0.000070095;C(459+1)= 0.000066280;
C(460+1)= 0.000062943;C(461+1)= 0.000059605;C(462+1)= 0.000055790;C(463+1)= 0.000052929;
C(464+1)= 0.000049591;C(465+1)= 0.000046253;C(466+1)= 0.000043392;C(467+1)= 0.000040531;
C(468+1)= 0.000037670;C(469+1)= 0.000034809;C(470+1)= 0.000032425;C(471+1)= 0.000030041;
C(472+1)= 0.000027657;C(473+1)= 0.000025272;C(474+1)= 0.000023365;C(475+1)= 0.000021458;
C(476+1)= 0.000019550;C(477+1)= 0.000018120;C(478+1)= 0.000016689;C(479+1)= 0.000014782;
C(480+1)= 0.000013828;C(481+1)= 0.000012398;C(482+1)= 0.000011444;C(483+1)= 0.000010014;
C(484+1)= 0.000009060;C(485+1)= 0.000008106;C(486+1)= 0.000007629;C(487+1)= 0.000006676;
C(488+1)= 0.000006199;C(489+1)= 0.000005245;C(490+1)= 0.000004768;C(491+1)= 0.000004292;
C(492+1)= 0.000003815;C(493+1)= 0.000003338;C(494+1)= 0.000003338;C(495+1)= 0.000002861;
C(496+1)= 0.000002384;C(497+1)= 0.000002384;C(498+1)= 0.000001907;C(499+1)= 0.000001907;
C(500+1)= 0.000001431;C(501+1)= 0.000001431;C(502+1)= 0.000000954;C(503+1)= 0.000000954;
C(504+1)= 0.000000954;C(505+1)= 0.000000954;C(506+1)= 0.000000477;C(507+1)= 0.000000477;
C(508+1)= 0.000000477;C(509+1)= 0.000000477;C(510+1)= 0.000000477;C(511+1)= 0.000000477;

C = C';
D = D';
