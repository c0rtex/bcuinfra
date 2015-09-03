// This file must be used in conjunction with ziplist.js.

var stateArr = new Array();
var stateName = new Array();
stateArr[0] = 'AK';
stateName[0] = 'Alaska';
stateArr[1] = 'AL';
stateName[1] = 'Alabama';
stateArr[2] = 'AR';
stateName[2] = 'Arkansas';
stateArr[3] = 'AZ';
stateName[3] = 'Arizona';
stateArr[4] = 'CA';
stateName[4] = 'California';
stateArr[5] = 'CO';
stateName[5] = 'Colorado';
stateArr[6] = 'CT';
stateName[6] = 'Connecticut';
stateArr[7] = 'DE';
stateName[7] = 'Delaware';
stateArr[8] = 'DC';
stateName[8] = 'the District of Columbia';
stateArr[9] = 'FL';
stateName[9] = 'Florida';
stateArr[10] = 'GA';
stateName[10] = 'Georgia';
stateArr[11] = 'HI';
stateName[11] = 'Hawaii';
stateArr[12] = 'IA';
stateName[12] = 'Iowa';
stateArr[13] = 'ID';
stateName[13] = 'Idaho';
stateArr[14] = 'IL';
stateName[14] = 'Illinois';
stateArr[15] = 'IN';
stateName[15] = 'Indiana';
stateArr[16] = 'KS';
stateName[16] = 'Kansas';
stateArr[17] = 'KY';
stateName[17] = 'Kentucky';
stateArr[18] = 'LA';
stateName[18] = 'Louisiana';
stateArr[19] = 'MA';
stateName[19] = 'Massachusetts';
stateArr[20] = 'MD';
stateName[20] = 'Maryland';
stateArr[21] = 'ME';
stateName[21] = 'Maine';
stateArr[22] = 'MI';
stateName[22] = 'Michigan';
stateArr[23] = 'MN';
stateName[23] = 'Minnesota';
stateArr[24] = 'MO';
stateName[24] = 'Missouri';
stateArr[25] = 'MS';
stateName[25] = 'Mississippi';
stateArr[26] = 'MT';
stateName[26] = 'Montana';
stateArr[27] = 'NC';
stateName[27] = 'North Carolina';
stateArr[28] = 'ND';
stateName[28] = 'North Dakota';
stateArr[29] = 'NE';
stateName[29] = 'Nebraska';
stateArr[30] = 'NH';
stateName[30] = 'New Hampshire';
stateArr[31] = 'NJ';
stateName[31] = 'New Jersey';
stateArr[32] = 'NM';
stateName[32] = 'New Mexico';
stateArr[33] = 'NV';
stateName[33] = 'Nevada';
stateArr[34] = 'NY';
stateName[34] = 'New York';
stateArr[35] = 'OH';
stateName[35] = 'Ohio';
stateArr[36] = 'OK';
stateName[36] = 'Oklahoma';
stateArr[37] = 'OR';
stateName[37] = 'Oregon';
stateArr[38] = 'PA';
stateName[38] = 'Pennsylvania';
stateArr[39] = 'RI';
stateName[39] = 'Rhode Island';
stateArr[40] = 'SC';
stateName[40] = 'South Carolina';
stateArr[41] = 'SD';
stateName[41] = 'South Dakota';
stateArr[42] = 'TN';
stateName[42] = 'Tennessee';
stateArr[43] = 'TX';
stateName[43] = 'Texas';
stateArr[44] = 'UT';
stateName[44] = 'Utah';
stateArr[45] = 'VA';
stateName[45] = 'Virginia';
stateArr[46] = 'VT';
stateName[46] = 'Vermont';
stateArr[47] = 'WA';
stateName[47] = 'Washington';
stateArr[48] = 'WI';
stateName[48] = 'Wisconsin';
stateArr[49] = 'WV';
stateName[49] = 'West Virginia';
stateArr[50] = 'WY';
stateName[50] = 'Wyoming';

function isZipValid(zip) {
	x = 0;
	y = isZipInState(zip, stateArr[x]);
	x++;
	while (y < 0 && x < 51) {
		y = isZipInState(zip, stateArr[x]);
		x++;
	}
	return y;
}

function getStateFromZip(zip) {
	x = 0;
	y = isZipInState(zip, stateArr[x]);
	while (y < 0 && x < 50) {
		x++;
		y = isZipInState(zip, stateArr[x]);
	}
	if (y < 0)
		return '';
	else
		return stateArr[x];
}

function getStateNameFromState(state) {
	x = 0;
	y = 0;
	if (state == stateArr[x])
		y = 1;
	while (y == 0 && x < 50) {
		x++;
		if (state == stateArr[x])
			y = 1;
	}
	if (y == 0)
		return '';
	else
		return stateName[x];
}
