scale=3;

caseWidth=		10*scale;
caseHeight=	7*scale;
caseThickness=	2*scale;

channelWidth=	0.5*scale;
channelHeight=	5*scale;
channelDepth=	0.25*scale;
knobWidth=		1.5*scale;
knobHeight=	1*scale;
knobThickness=	0.5*scale;

numberChannels=	5;

function EQ(c) = 0.5* channelHeight * cos(7*c*caseWidth/(numberChannels+2));

union()
{
	difference()
	{
		translate([0,0,caseThickness/2])
		cube([caseWidth,caseHeight,caseThickness],true);
	
		translate([0,0,caseThickness])
		for (i=[1:numberChannels])
		{
			translate([(caseWidth)*(i/(numberChannels+1))-caseWidth/2,0,0])
			cube([channelWidth,channelHeight,2*channelDepth],true);
		}
	}
	
	translate([0,0,caseThickness])
	for (i=[1:numberChannels])
	{
		translate([(caseWidth)*(i/(numberChannels+1))-caseWidth/2,EQ(i),0])
		cube([knobWidth,knobHeight,2*knobThickness],true);
	}
}

translate([-20*scale/3,20*scale/3,0])
rotate(180,[1,0,0])
scale(scale/3)
import_stl("KitchenAidmixerattachmentcap_fixed.stl");