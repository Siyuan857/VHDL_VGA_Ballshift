----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2024 12:09:19 PM
-- Design Name: 
-- Module Name:  - 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package pkg_PrASIC is

----------------  640 x 480 60Hz 25,197MHz ------------  
  constant HRes:    integer := 640;   -- visible area horizontal: H_VISIBLE_AREA
  constant HS1:     integer := 657;   -- first pixel of Hor. Sync: H_VISIBLE_AREA + H_FOUNT_PORCH
  constant HS2:     integer := 752;   -- last pixel of Hor. Sync: H_VISIBLE_AREA + H_FOUNT_PORCH + H_SYNC_PLUSE
  constant HMax:    integer := 800;   -- visible area plus blanking zone horizontal: H_TOTAL

  constant VRes:    integer := 480;   -- visible area vertical
  constant VS1:     integer := 491;   -- first line of Vert. Sync
  constant VS2:     integer := 492;   -- last line of Vert. Sync
  constant VMax:    integer := 525;   -- visible area plus blanking zone vertical
  
------------------  800 x 600 60Hz 40MHz ------------ 
--  constant HRes:    integer := 800;    -- 40/128/88
--  constant HS1:     integer := 840;
--  constant HS2:     integer := 968;
--  constant HMax:    integer := 1056;

--  constant VRes:    integer := 600;    --  1/4/23
--  constant VS1:     integer := 601;
--  constant VS2:     integer := 605;
--  constant VMax:    integer := 628;

----------------  1024 x 768 60Hz 65MHz ------------ 
--  constant HRes:    integer := 1024;    -- 24/136/160
--  constant HS1:     integer := 1048;
--  constant HS2:     integer := 1184;
--  constant HMax:    integer := 1344;

--  constant VRes:    integer := 768;     -- 3/6/29
--  constant VS1:     integer := 771;
--  constant VS2:     integer := 777;
--  constant VMax:    integer := 806;
----------------------------------------------- 
 
  constant FMax:    integer := 2**10-1;  -- for VGA Frame Counter (can be modified)
  
-----------------------------------------------
  subtype VGA12 is std_logic_vector (11 downto 0);
-----------------------------------------------

  constant blank:   VGA12 := x"000";   -- for Blanking
  
  constant black:   VGA12 := x"000";
  constant white:   VGA12 := x"FFF";
  constant red:     VGA12 := x"F00";
  constant green:   VGA12 := x"0F0";    
  constant blue:    VGA12 := x"00F";
  constant purple:  VGA12 := x"F0F";
  constant cyan:    VGA12 := x"0FF";
  constant yellow:  VGA12 := x"FF0";
  constant grey:    VGA12 := x"AAA";
  
--  constant radius      : integer := 20;
  constant AnzBall : integer := 22;


---------------------------------------------------  
    type Coll_Array is array (1 to AnzBall) of boolean;
    type VGA12_Array is array (1 to AnzBall) of VGA12;    
    type Exist_Array is array (1 to AnzBall) of boolean;
    type Coll_H_Array is array (1 to AnzBall) of integer range 1 to HMax;
    type Coll_V_Array is array (1 to AnzBall) of integer range 1 to VMax;


--    type BallParamType is record
--        HPosM      : integer range 1 to HRes;
--        VPosM      : integer range 1 to VRes;
--        Radius     : integer;
--        ColorIn    : VGA12;
--        HVel       : integer;
--        VVel       : integer;
--    end record;
    
--    type BallParamArray is array (1 to AnzBall) of BallParamType;
    
--    constant BallParams: BallParamArray := (
--    1 => (HPosM => 113, VPosM => 233, Radius => 20, ColorIn => blue, HVel => 13, VVel => 7),
--    2 => (HPosM =>  53, VPosM => 178, Radius => 40, ColorIn => red , HVel =>  4, VVel => 9),
--    3 => (HPosM =>  78, VPosM =>  63, Radius => 80, ColorIn =>purple,HVel =>  6, VVel => 8),
--    4 => (HPosM => 217, VPosM => 438, Radius =>100, ColorIn =>yellow,HVel =>  3, VVel => 4),
--    5 => (HPosM => 550, VPosM => 333, Radius => 30, ColorIn => cyan, HVel =>  2, VVel => 10)
    
--    );
          
end package pkg_PrASIC;



    
     
    
    





