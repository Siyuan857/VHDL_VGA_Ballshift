library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_PrASIC.all;

package pack_DrawSign is 

type seg16code is (BL,A1,A2,BB,CC,D1,D2,EE,FF,G1,G2,HH,JJ,KK,LL,MM,NN,P1,P2,P3,P4,P5,P6,P7,P8);

constant arrayh: integer := 24;
constant arrayv: integer := 20;
type pixel16Seg is array (1 to arrayh*arrayv) of seg16code;
constant col_16Seg : pixel16Seg :=(
BL,BL,BL,BL,BL,BL,A1,A1,A1,A1,A1,BL,BL,A2,A2,A2,A2,A2,BL,BL,BL,BL,BL,BL,
BL,BL,BL,BL,BL,A1,A1,A1,A1,A1,A1,A1,A2,A2,A2,A2,A2,A2,A2,BL,BL,BL,BL,BL,
BL,BL,BL,BL,FF,HH,BL,BL,BL,BL,BL,JJ,JJ,BL,BL,BL,BL,BL,KK,BB,BL,BL,BL,BL,
BL,BL,BL,FF,FF,HH,HH,BL,BL,BL,BL,JJ,JJ,BL,BL,BL,BL,KK,KK,BB,BB,BL,BL,BL,
BL,BL,BL,FF,FF,BL,HH,HH,BL,BL,BL,JJ,JJ,BL,BL,BL,KK,KK,BL,BB,BB,BL,BL,BL,
BL,BL,BL,FF,FF,BL,BL,HH,HH,BL,BL,JJ,JJ,BL,BL,KK,KK,BL,BL,BB,BB,BL,BL,BL,
BL,BL,BL,FF,FF,BL,BL,BL,HH,HH,BL,JJ,JJ,BL,KK,KK,BL,BL,BL,BB,BB,BL,BL,BL,
BL,BL,BL,FF,FF,BL,BL,BL,BL,HH,HH,JJ,JJ,KK,KK,BL,BL,BL,BL,BB,BB,BL,BL,BL,
BL,BL,BL,FF,FF,BL,BL,BL,BL,BL,HH,JJ,JJ,KK,BL,BL,BL,BL,BL,BB,BB,BL,BL,BL,
BL,BL,BL,BL,FF,G1,G1,G1,G1,G1,G1,G1,G2,G2,G2,G2,G2,G2,G2,BB,BL,BL,BL,BL,
BL,BL,BL,BL,EE,G1,G1,G1,G1,G1,G1,G1,G2,G2,G2,G2,G2,G2,G2,CC,BL,BL,BL,BL,
BL,BL,BL,EE,EE,BL,BL,BL,BL,BL,NN,MM,MM,LL,BL,BL,BL,BL,BL,CC,CC,BL,BL,BL,
BL,BL,BL,EE,EE,BL,BL,BL,BL,NN,NN,MM,MM,LL,LL,BL,BL,BL,BL,CC,CC,BL,BL,BL,
BL,BL,BL,EE,EE,BL,BL,BL,NN,NN,BL,MM,MM,BL,LL,LL,BL,BL,BL,CC,CC,BL,BL,BL,
BL,BL,BL,EE,EE,BL,BL,NN,NN,BL,BL,MM,MM,BL,BL,LL,LL,BL,BL,CC,CC,BL,BL,BL,
BL,BL,BL,EE,EE,BL,NN,NN,BL,BL,BL,MM,MM,BL,BL,BL,LL,LL,BL,CC,CC,BL,BL,BL,
P2,P4,BL,EE,EE,NN,NN,BL,BL,BL,BL,MM,MM,BL,BL,BL,BL,LL,LL,CC,CC,BL,P6,P7,
P2,P4,BL,BL,EE,NN,BL,BL,BL,BL,BL,MM,MM,BL,BL,BL,BL,BL,LL,CC,BL,BL,P6,P7,
P1,P3,BL,BL,BL,D1,D1,D1,D1,D1,D1,D1,D2,D2,D2,D2,D2,D2,D2,BL,BL,BL,P5,P8,
P1,P3,BL,BL,BL,BL,D1,D1,D1,D1,D1,BL,BL,D2,D2,D2,D2,D2,BL,BL,BL,BL,P5,P8
);


type OneSign is 
(
-- SPace, EXclamation. QUotation, Secting Sign, DOllar, PErcent, AMpersand, APostrophe, Bracket Left, Bracket Right, ASterisk, PLus, CoMma, MInus, STop, SLash,
SP,EX,QU,SS,DO,PE,AM,AP,BL,BR,AS,PL,CM,MI,ST,SL,
--Number0, Number1, Number2, Number3, Number4, Number5, Number6, Number7, Number8, Number9, COlon, SEmicolon, Angle brackets Left, EQuels,  Angle brackets Right, Question Mark,
N0,N1,N2,N3,N4,N5,N6,N7,N8,N9,CO,SE,AL,EQ,AR,QM,
--AT, Huge A, Huge B, Huge C, Huge D, Huge E, Huge F, Huge G, Huge H, Huge I, Huge J, Huge K, Huge L, Huge M, Huge N, Huge O, 
AT,HA,HB,HC,HD,HE,HF,HG,HH,HI,HJ,HK,HL,HM,HN,HO,
--Huge P, Huge Q, Super huge R, Huge S, Huge T, Huge U, Huge V, Huge W, Huge X, Huge Y, Huge Z, Open Square, BackSlash, Close Square, CAret, UNderscore,
HP,HQ,SR,HS,HT,HU,HV,HW,HX,HY,HZ,OS,BS,CS,CA,UN,     --SR:SUPER HUGE R(CONFLICTING)
--Grave Accent, Little A,  Little B, Little C, Little D, Little E, Little F, Little G, Little H, Little I, Little J, Little K, Little L, Little M, Little N, Little O,
GA,LA,LB,LC,LD,LE,LF,LG,LH,LI,LJ,LK,LL,LM,LN,LO,
--Little P, Little Q, Little R, Little S, Little T, Little U, Little V, Little W, Little X, Little Y, Little Z, Curly brackets Left, PIpe, Curly brackets Right, Ambiguous Notation,
LP,LQ,LR,LS,LT,LU,LV,LW,LX,LY,LZ,CL,PI,CR,AN,
--Point1, Point2, Point3, Point4, Point5, Point6, Point7, Point8, Point9,
P0,P1,P2,P3,P4,P5,P6,P7,P8,P9
);

type Signs26 is array (0 to HRes/arrayh) of OneSign;
type Signs52 is array (0 to 2*(HRes/arrayh)) of OneSign;

--------------------------------
function DrawSign (HPix: Integer; VPix: Integer; HPos: Integer; VPos: Integer; Sign: OneSign) return boolean ;
function ManySigns (HPix: Integer; VPix: Integer; HPos: Integer; VPos: Integer; Longtext: Signs26) return boolean;
function IntSigns (HPix: Integer; VPix: Integer; HPos: Integer; VPos: Integer; IntNu: Integer; DigiNu: Integer) return boolean;
function TwoVSigns(HPix:Integer; VPix:Integer; HPos:Integer; VPos: Integer; Llongtext: Signs52) return boolean;
procedure Circle(signal HPix:in integer; signal VPix: in integer; signal HPosM: in integer; signal VPosM: in integer; constant Radius: in integer; constant ColorIn: in VGA12; signal ColorOut: out VGA12; signal CircleExist: out boolean);--
procedure PicFrame(signal HPix:in integer; signal VPix: in integer; signal HPosM: in integer; signal VPosM: in integer; constant V1: in integer; constant V2: in integer;  constant H1: in integer; constant H2: in integer;constant ColorIn1: in VGA12;constant ColorIn2: in VGA12; signal ColorOut: out VGA12; signal FrameExist: out boolean ); 
procedure Cross(signal HPix:in integer; signal VPix: in integer; constant HPosM: in integer; constant VPosM: in integer; constant V1: in integer; constant V2: in integer;  constant H1: in integer; constant H2: in integer;constant ColorIn: in VGA12; signal ColorOut: out VGA12; signal CrossExist: out boolean );

end package pack_DrawSign; 
 
package body pack_DrawSign is
 
 
function DrawSign (HPix: Integer; VPix: Integer; HPos: Integer; VPos: Integer; Sign: OneSign) return boolean is
   variable SC : seg16code;--(BL,A1,A2,BB,CC,D1,D2,EE,FF,G1,G2,HH,JJ,KK,LL,MM,NN);
begin

    SC := col_16seg((HPix-HPos)+((VPix-VPos)*arrayh));
          
    if (HPix-HPos > 0 and HPix-HPos <= arrayh) and VPix-VPos >= 0 and VPix-VPos < arrayv then

        case Sign is
            when SP =>                                                                                                                                                    return false; 
            when EX => if (SC=BB) or (SC=CC) or (SC=P5) or (SC=P8)                                                                                                        then return true; else return false; end if;
            when QU => if (SC=JJ) or (SC=BB)                                                                                                                              then return true; else return false; end if;
            when SS => if (SC=JJ) or (SC=BB) or (SC=G1) or (SC=G2) or (SC=MM) or (SC=D1) or (SC=D2) or (SC=CC)                                                            then return true; else return false; end if;
            when DO => if (SC=A1) or (SC=JJ) or (SC=FF) or (SC=G1) or (SC=G2) or (SC=MM) or (SC=D1) or (SC=D2) or (SC=CC)                                                 then return true; else return false; end if;
            when PE => if (SC=A1) or (SC=JJ) or (SC=FF) or (SC=G1) or (SC=G2) or (SC=MM) or (SC=D2) or (SC=CC) or (SC=NN) or (SC=KK)                                      then return true; else return false; end if;
            when AM => if (SC=A1) or (SC=JJ) or (SC=HH) or (SC=G1) or (SC=LL) or (SC=MM) or (SC=D2) or (SC=D1) or (SC=EE)                                                 then return true; else return false; end if;
            when AP => if (SC=JJ)                                                                                                                                         then return true; else return false; end if;
            when BL => if (SC=LL) or (SC=KK)                                                                                                                              then return true; else return false; end if;
            when BR => if (SC=NN) or (SC=HH)                                                                                                                              then return true; else return false; end if;
            when AS => if (SC=MM) or (SC=JJ) or (SC=KK) or (SC=G1) or (SC=G2) or (SC=MM) or (SC=NN) or (SC=LL)                                                            then return true; else return false; end if;
            when PL => if (SC=MM) or (SC=JJ) or (SC=G1) or (SC=G2)                                                                                                        then return true; else return false; end if;
            when CM => if (SC=NN)                                                                                                                                         then return true; else return false; end if;
            when MI => if (SC=G1) or (SC=G2)                                                                                                                              then return true; else return false; end if;
            when ST => if (SC=P5) or (SC=P8)                                                                                                                              then return true; else return false; end if;
            when SL => if (SC=KK) or (SC=NN)                                                                                                                              then return true; else return false; end if;
            when N0 => if (SC=FF) or (SC=EE) or (SC=A1) or (SC=A2) or (SC=BB) or (SC=CC) or (SC=D2) or (SC=D1) or (SC=NN) or (SC=KK)                                      then return true; else return false; end if;
            when N1 => if (SC=KK) or (SC=BB) or (SC=CC)                                                                                                                   then return true; else return false; end if;
            when N2 => if (SC=A1) or (SC=A2) or (SC=BB) or (SC=G1) or (SC=G2) or (SC=EE) or (SC=D2) or (SC=D1)                                                            then return true; else return false; end if;
            when N3 => if (SC=A1) or (SC=A2) or (SC=BB) or (SC=G2) or (SC=CC) or (SC=D2) or (SC=D1)                                                                       then return true; else return false; end if;
            when N4 => if (SC=FF) or (SC=G1) or (SC=G2) or (SC=BB) or (SC=CC)                                                                                             then return true; else return false; end if;
            when N5 => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=G1) or (SC=LL)                                                                       then return true; else return false; end if;
            when N6 => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=G1) or (SC=G2) or (SC=EE) or (SC=CC)                                                 then return true; else return false; end if;
            when N7 => if (SC=A1) or (SC=A2) or (SC=BB) or (SC=CC)                                                                                                        then return true; else return false; end if;
            when N8 => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=BB) or (SC=EE) or (SC=CC) or (SC=G1) or (SC=G2)                                      then return true; else return false; end if;
            when N9 => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=BB) or (SC=CC) or (SC=FF) or (SC=G1) or (SC=G2)                                                 then return true; else return false; end if;
            when CO|PI => if (SC=JJ) or (SC=MM)                                                                                                                           then return true; else return false; end if;
            when SE => if (SC=JJ) or (SC=NN)                                                                                                                              then return true; else return false; end if;
            when AL => if (SC=G1) or (SC=KK) or (SC=LL)                                                                                                                   then return true; else return false; end if;
            when EQ => if (SC=G1) or (SC=G2) or (SC=D1) or (SC=D2)                                                                                                        then return true; else return false; end if;
            when AR => if (SC=HH) or (SC=NN) or (SC=G2)                                                                                                                   then return true; else return false; end if;
            when QM => if (SC=A1) or (SC=A2) or (SC=BB) or (SC=G2) or (SC=MM) or (SC=P5) or (SC=P8)                                                                       then return true; else return false; end if;
            when AT => if (SC=A1) or (SC=A2) or (SC=G2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=EE) or (SC=JJ) or (SC=BB)                                                 then return true; else return false; end if;
            when HA => if (SC=A1) or (SC=A2) or (SC=G1) or (SC=G2) or (SC=FF) or (SC=EE) or (SC=BB) or (SC=CC)                                                            then return true; else return false; end if;
            when HB => if (SC=A1) or (SC=A2) or (SC=G2) or (SC=D1) or (SC=D2) or (SC=MM) or (SC=JJ) or (SC=CC) or (SC=BB)                                                 then return true; else return false; end if;
            when HC => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=EE)                                                                                  then return true; else return false; end if;
            when HD => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=JJ) or (SC=MM) or (SC=BB) or (SC=CC)                                                            then return true; else return false; end if;
            when HE => if (SC=A1) or (SC=A2) or (SC=G1) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=EE)                                                                       then return true; else return false; end if;
            when HF => if (SC=A1) or (SC=A2) or (SC=G1) or (SC=FF) or (SC=EE)                                                                                             then return true; else return false; end if;
            when HG => if (SC=A1) or (SC=A2) or (SC=G2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=EE) or (SC=CC)                                                            then return true; else return false; end if;
            when HH => if (SC=G1) or (SC=G2) or (SC=FF) or (SC=EE) or (SC=BB) or (SC=CC)                                                                                  then return true; else return false; end if;
            when HI => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=JJ) or (SC=MM)                                                                                  then return true; else return false; end if;
            when HJ => if (SC=D1) or (SC=D2) or (SC=EE) or (SC=BB) or (SC=CC)                                                                                             then return true; else return false; end if;
            when HK => if (SC=G1) or (SC=FF) or (SC=EE) or (SC=KK) or (SC=LL)                                                                                             then return true; else return false; end if;
            when HL => if (SC=D1) or (SC=D2) or (SC=FF) or (SC=EE)                                                                                                        then return true; else return false; end if;
            when HM => if (SC=FF) or (SC=EE) or (SC=BB) or (SC=CC) or (SC=HH) or (SC=KK)                                                                                  then return true; else return false; end if;
            when HN => if (SC=FF) or (SC=EE) or (SC=BB) or (SC=CC) or (SC=LL) or (SC=HH)                                                                                  then return true; else return false; end if;
            when HO => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=EE) or (SC=BB) or (SC=CC)                                                            then return true; else return false; end if;
            when HP => if (SC=A1) or (SC=A2) or (SC=G1) or (SC=G2) or (SC=FF) or (SC=EE) or (SC=BB)                                                                       then return true; else return false; end if;
            when HQ => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=EE) or (SC=BB) or (SC=CC) or (SC=LL)                                                 then return true; else return false; end if;
            when SR => if (SC=A1) or (SC=A2) or (SC=G1) or (SC=G2) or (SC=FF) or (SC=EE) or (SC=BB) or (SC=LL)                                                            then return true; else return false; end if;
            when HS => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=G1) or (SC=G2) or (SC=CC)                                                            then return true; else return false; end if;
            when HT => if (SC=A1) or (SC=A2) or (SC=JJ) or (SC=MM)                                                                                                        then return true; else return false; end if;
            when HU => if (SC=D1) or (SC=D2) or (SC=FF) or (SC=EE) or (SC=BB) or (SC=CC)                                                                                  then return true; else return false; end if;
            when HV => if (SC=FF) or (SC=EE) or (SC=NN) or (SC=KK)                                                                                                        then return true; else return false; end if;
            when HW => if (SC=FF) or (SC=EE) or (SC=BB) or (SC=CC) or (SC=LL) or (SC=NN)                                                                                  then return true; else return false; end if;
            when HX|LX=> if (SC=HH) or (SC=KK) or (SC=NN) or (SC=LL)                                                                                                      then return true; else return false; end if;
            when HY => if (SC=G1) or (SC=G2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=BB) or (SC=CC)                                                                       then return true; else return false; end if;
            when HZ => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=KK) or (SC=NN)                                                                                  then return true; else return false; end if;
            when OS => if (SC=A2) or (SC=D2) or (SC=JJ) or (SC=MM)                                                                                                        then return true; else return false; end if;
            when BS => if (SC=HH) or (SC=LL)                                                                                                                              then return true; else return false; end if;
            when CS => if (SC=A1) or (SC=JJ) or (SC=HH) or (SC=G1) or (SC=LL) or (SC=MM) or (SC=D2) or (SC=D1) or (SC=EE)                                                 then return true; else return false; end if;
            when CA => if (SC=NN) or (SC=LL)                                                                                                                              then return true; else return false; end if;
            when UN => if (SC=D1) or (SC=D2)                                                                                                                              then return true; else return false; end if;
            when GA => if (SC=FF)                                                                                                                                         then return true; else return false; end if;
            when LA => if (SC=G1) or (SC=D1) or (SC=D2) or (SC=EE) or (SC=MM)                                                                                             then return true; else return false; end if;
            when LB => if (SC=G1) or (SC=D1) or (SC=FF) or (SC=EE) or (SC=MM)                                                                                             then return true; else return false; end if;
            when LC => if (SC=G1) or (SC=D1) or (SC=EE)                                                                                                                   then return true; else return false; end if;
            when LD => if (SC=G2) or (SC=D2) or (SC=MM) or (SC=BB) or (SC=CC)                                                                                             then return true; else return false; end if;
            when LE => if (SC=G1) or (SC=D1) or (SC=EE) or (SC=NN)                                                                                                        then return true; else return false; end if;
            when LF => if (SC=A2) or (SC=G1) or (SC=G2) or (SC=JJ) or (SC=MM)                                                                                             then return true; else return false; end if;
            when LG => if (SC=A1) or (SC=G1) or (SC=D1) or (SC=FF) or (SC=JJ) or (SC=MM)                                                                                  then return true; else return false; end if;
            when LH => if (SC=G1) or (SC=FF) or (SC=EE) or (SC=MM)                                                                                                        then return true; else return false; end if;
            when LI => if (SC=MM)                                                                                                                                         then return true; else return false; end if;
            when LJ => if (SC=D1) or (SC=EE) or (SC=JJ) or (SC=MM)                                                                                                        then return true; else return false; end if;
            when LK => if (SC=JJ) or (SC=MM) or (SC=KK) or (SC=LL)                                                                                                        then return true; else return false; end if;
            when LL => if (SC=FF) or (SC=EE)                                                                                                                              then return true; else return false; end if;
            when LM => if (SC=G1) or (SC=G2) or (SC=EE) or (SC=MM) or (SC=CC)                                                                                             then return true; else return false; end if;
            when LN => if (SC=G1) or (SC=EE) or (SC=MM)                                                                                                                   then return true; else return false; end if;
            when LO => if (SC=G1) or (SC=D1) or (SC=EE) or (SC=MM)                                                                                                        then return true; else return false; end if;
            when LP => if (SC=A1) or (SC=G1) or (SC=FF) or (SC=EE) or (SC=JJ)                                                                                             then return true; else return false; end if;
            when LQ => if (SC=A1) or (SC=G1) or (SC=FF) or (SC=JJ) or (SC=MM)                                                                                             then return true; else return false; end if;
            when LR => if (SC=G1) or (SC=EE)                                                                                                                              then return true; else return false; end if;
            when LS => if (SC=A1) or (SC=G1) or (SC=D1) or (SC=FF) or (SC=MM)                                                                                             then return true; else return false; end if;
            when LT => if (SC=G1) or (SC=D1) or (SC=FF) or (SC=EE)                                                                                                        then return true; else return false; end if;
            when LU => if (SC=D1) or (SC=EE) or (SC=MM)                                                                                                                   then return true; else return false; end if;
            when LV => if (SC=EE) or (SC=NN)                                                                                                                              then return true; else return false; end if;
            when LW => if (SC=EE) or (SC=CC) or (SC=NN) or (SC=LL)                                                                                                        then return true; else return false; end if;
            when LY => if (SC=G2) or (SC=D2) or (SC=JJ) or (SC=BB) or (SC=CC)                                                                                             then return true; else return false; end if;
            when LZ => if (SC=G1) or (SC=D1) or (SC=NN)                                                                                                                   then return true; else return false; end if;
            when CL => if (SC=A2) or (SC=G1) or (SC=D2) or (SC=JJ) or (SC=MM)                                                                                             then return true; else return false; end if;
            when CR => if (SC=A1) or (SC=G2) or (SC=D1) or (SC=JJ) or (SC=MM)                                                                                             then return true; else return false; end if;
            when AN => if (SC=G1) or (SC=G2) or (SC=NN) or (SC=KK)                                                                                                        then return true; else return false; end if; 
            when P0 => if (SC=FF) or (SC=EE) or (SC=A1) or (SC=A2) or (SC=BB) or (SC=CC) or (SC=D2) or (SC=D1) or (SC=NN) or (SC=KK) or (SC=P5) or (SC=P8)                then return true; else return false; end if;
            when P1 => if (SC=KK) or (SC=BB) or (SC=CC) or (SC=P5) or (SC=P8)                                                                                             then return true; else return false; end if;
            when P2 => if (SC=A1) or (SC=A2) or (SC=BB) or (SC=G1) or (SC=G2) or (SC=EE) or (SC=D2) or (SC=D1) or (SC=P5) or (SC=P8)                                      then return true; else return false; end if;
            when P3 => if (SC=A1) or (SC=A2) or (SC=BB) or (SC=G2) or (SC=CC) or (SC=D2) or (SC=D1) or (SC=P5) or (SC=P8)                                                 then return true; else return false; end if;
            when P4 => if (SC=FF) or (SC=G1) or (SC=G2) or (SC=BB) or (SC=CC) or (SC=P5) or (SC=P8)                                                                       then return true; else return false; end if;
            when P5 => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=G1) or (SC=LL) or (SC=P5) or (SC=P8)                                                 then return true; else return false; end if;
            when P6 => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=G1) or (SC=G2) or (SC=EE) or (SC=CC) or (SC=P5) or (SC=P8)                           then return true; else return false; end if;
            when P7 => if (SC=A1) or (SC=A2) or (SC=BB) or (SC=CC) or (SC=P5) or (SC=P8)                                                                                  then return true; else return false; end if;
            when P8 => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=FF) or (SC=BB) or (SC=EE) or (SC=CC) or (SC=G1) or (SC=G2) or (SC=P5) or (SC=P8)                then return true; else return false; end if;
            when P9 => if (SC=A1) or (SC=A2) or (SC=D1) or (SC=D2) or (SC=BB) or (SC=CC) or (SC=FF) or (SC=G1) or (SC=G2) or (SC=P5) or (SC=P8)                           then return true; else return false; end if;
            when others =>
                return false;
        end case;
    else 
       return false;
    end if;

end function DrawSign;


function ManySigns (HPix: Integer; VPix: Integer; HPos: Integer; VPos: Integer; Longtext: Signs26) return boolean is
variable HSign : integer range 0 to HMax;

begin

 for I in Longtext'range loop
        HSign := HPos + I*arrayh;
     if HSign <= HRes - arrayh and HPix >= HSign and HPix <= HSign + arrayh then
        return DrawSign(HPix,VPix,HSign,VPos,Longtext(I));
     end if;       
 end loop;
end function;

function IntSigns (HPix: Integer; VPix: Integer; HPos: Integer; VPos: Integer; IntNu: Integer; DigiNu: Integer) return boolean is
variable HSign : integer range 0 to HMax;
variable TmpNu: integer;
variable OneNu: integer range 0 to 9;
type NumConvert is array (0 to 9) of OneSign;
constant NumList : NumConvert := (N0,N1,N2,N3,N4,N5,N6,N7,N8,N9);
begin
TmpNu := IntNu;
for I in (DigiNu - 1) downto 0 loop
     HSign := HPos + I*arrayh;
     OneNu := TmpNu mod 10;
     TmpNu := TmpNu / 10;   
  if HSign <= HRes - arrayh and HPix >= HSign and HPix <= HSign + arrayh then
            return DrawSign(HPix,VPix,HSign,VPos,NumList(OneNu));
  end if;
end loop;
end function;



function TwoVSigns(HPix:Integer; VPix:Integer; HPos:Integer; VPos: Integer; Llongtext: Signs52) return boolean is
variable HSign : integer range 0 to HMax;
variable VSign: integer range 0 to VMax;
constant OneLineSigns : integer := HRes/arrayh;

begin

    for I in Llongtext'range loop
        HSign := HPos + (I mod OneLineSigns) * arrayh; 
        VSign := VPos + (I / OneLineSigns) * arrayv;  
        if (HPix >= HSign and HPix <= HSign + arrayh) then
            if (VPix >= VSign and VPix <= VSign + arrayv) then
                return DrawSign(HPix, VPix, HSign, VSign , Llongtext(I)); 
            end if;
        end if;
    end loop;

    return false; 
end function;



procedure Circle(
                signal   HPix       : in integer; 
                signal   VPix       : in integer; 
                signal   HPosM      : in integer; 
                signal   VPosM      : in integer; 
                constant Radius     : in integer; 
                constant ColorIn    : in VGA12; 
                signal   ColorOut   : out VGA12; 
                signal   CircleExist: out boolean
                ) is
 
begin
if(HPix-HPosM)*(HPix-HPosM) + (VPix- VPosM)*(VPix- VPosM) <= Radius*Radius then
                CircleExist <= true;
                ColorOut <= ColorIn;
else
                CircleExist <= false;
                ColorOut <= grey;
end if;

end procedure;

procedure PicFrame(signal HPix:in integer; signal VPix: in integer; signal HPosM: in integer; signal VPosM: in integer; constant V1: in integer; constant V2: in integer;  constant H1: in integer; constant H2: in integer;constant ColorIn1: in VGA12;constant ColorIn2: in VGA12; signal ColorOut: out VGA12; signal FrameExist: out boolean ) is

begin
if V2 > V1 and H2 > H1 then
    FrameExist <= true;
       if ((HPix-HPosM<= H2 and HPix-HPosM >= 0) or (HPosM-HPix <= H2 and HPosM-HPix >= 0)) and ((VPix-VPosM<= V2 and VPix-VPosM >= 0) or (VPosM-VPix <= V2 and VPosM-VPix >= 0)) then   --(HPix-HPosM)*(HPix-HPosM) <= H2*H2 and (VPix- VPosM)*(VPix- VPosM) <=V2*V2 
                 ColorOut <= ColorIn2;
                if ((HPix-HPosM<= H1 and HPix-HPosM >= 0) or (HPosM-HPix <= H1 and HPosM-HPix >= 0)) and ((VPix-VPosM<= V1 and VPix-VPosM >= 0) or (VPosM-VPix <= V1 and VPosM-VPix >= 0)) then  --(HPix-HPosM)*(HPix-HPosM) <= H1*H1 and (VPix- VPosM)*(VPix- VPosM) <=V1*V1
                    ColorOut <= ColorIn1;
                end if;             
       else
          Frameexist <= false; 
           ColorOut <= grey; 
               
       end if;    
else  
   FrameExist <= false; 
end if;

end procedure;

procedure Cross(signal HPix:in integer; signal VPix: in integer; constant HPosM: in integer; constant VPosM: in integer; constant V1: in integer; constant V2: in integer;  constant H1: in integer; constant H2: in integer;constant ColorIn: in VGA12; signal ColorOut: out VGA12; signal CrossExist: out boolean ) is

begin
if V2 < V1 and H2 > H1 then
    CrossExist <= true;
    ColorOut <= grey; 
       if (((HPix-HPosM<= H2 and HPix-HPosM >= 0) or (HPosM-HPix <= H2 and HPosM-HPix >= 0)) and ((VPix-VPosM<= V2 and VPix-VPosM >= 0) or (VPosM-VPix <= V2 and VPosM-VPix >= 0))) or 
       (((HPix-HPosM<= H1 and HPix-HPosM >= 0) or (HPosM-HPix <= H1 and HPosM-HPix >= 0)) and ((VPix-VPosM<= V1 and VPix-VPosM >= 0) or (VPosM-VPix <= V1 and VPosM-VPix >= 0))) then 
       --((HPix-HPosM)*(HPix-HPosM) <= H2*H2 and (VPix- VPosM)*(VPix- VPosM) <=V2*V2) or ((HPix-HPosM)*(HPix-HPosM) <= H1*H1 and (VPix- VPosM)*(VPix- VPosM) <=V1*V1)
             ColorOut <= ColorIn;            
       else
             CrossExist <= false;              
       end if;    
else  
   CrossExist <= false;  
end if;

end procedure;
end package body pack_DrawSign;
