----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2024 12:16:07 PM
-- Design Name: 
-- Module Name: Ball_shift - Behavioral
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
use work.pkg_PrASIC.all;
use work.pack_DrawSign.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ball_shift is
    generic(
        HPosM      : in integer := 100;
        VPosM      : in integer := 100;
        Radius     : in integer := 20;
        ColorIn    : in VGA12   := red;
        HVel       : in integer := 1;
        VVel       : in integer := 1

    );

    Port ( 
            clk25      : in  STD_LOGIC;
            AR         : in  boolean;
            Freeze     : in  boolean;
            HPix       : in  integer range 1 to HMax;
            VPix       : in  integer range 1 to VMax;
            HPixM      : in  integer range 1 to HMax;
            VPixM      : in  integer range 1 to VMax;
            FrEnd      : in  boolean;
            Collision  : in boolean;    
            ColorOut   : out VGA12;
            CircleExist: out boolean

            );
end Ball_shift;

architecture Behavioral of Ball_shift is

constant H_LEFT_EDGE   : integer := Radius; 
constant H_RIGHT_EDGE  : integer := HRes - Radius;
constant V_TOP_EDGE    : integer := Radius;
constant V_BOTTOM_EDGE : integer := VRes - Radius;

signal HPos : integer := HPosM;  --Ball position H
signal VPos : integer := VPosM;  --Ball position V
signal hyp  : integer;

begin


Moveball: process(clk25, AR)--, HPosM, VPosM

variable HP : integer;
variable VP : integer;
variable Hdir : std_logic;--integer := 1;
variable Vdir : std_logic;--integer := 1;

begin

    if AR then
        HPos <= HPosM;
        VPos <= VPosM;
    elsif rising_edge(clk25) then
        if FREnd then
            HP := HPos;
            VP := VPos;
            
            if VP >= V_BOTTOM_EDGE then
                Vdir := '0';
            elsif VP + VVel > V_BOTTOM_EDGE then
                VP   := V_BOTTOM_EDGE - VVel;
            end if;
            
            if VP <= V_TOP_EDGE then
                Vdir :=  '1';
            elsif VP - VVel < V_TOP_EDGE then
                VP   := V_TOP_EDGE + VVel;
            end if;
            
                
            if HP >= H_RIGHT_EDGE then
                Hdir := '0';
            elsif HP + HVel > H_RIGHT_EDGE then
                HP   := H_RIGHT_EDGE - HVel;
            end if;
            
            if HP <= H_LEFT_EDGE then
                Hdir :=  '1';
            elsif HP - HVel < H_LEFT_EDGE then
                HP   := H_LEFT_EDGE + HVel;
            end if;
            
            if Collision then
                if HP < HPixM and VP < VPixM then Hdir := '0'; Vdir := '0'; end if;
                if HP > HPixM and VP < VPixM then Hdir :=  '1'; Vdir := '0'; end if;
                if HP < HPixM and VP > VPixM then Hdir := '0'; Vdir :=  '1'; end if;
                if HP > HPixM and VP > VPixM then Hdir :=  '1'; Vdir :=  '1'; end if;
            end if;
                    
            if not Freeze then
--                HP := HP;
--                VP := VP;
--            else
                if Hdir = '1' then
                    HP := HP + HVel;
                else
                    HP := HP - HVel;
                end if;
                if Vdir = '1' then    
                    VP := VP + VVel;
                else
                    VP := VP - VVel;
                end if;
            end if;
    
            HPos <= HP;
            VPos <= VP;
           
        end if;
    end if;

end process;

Circle(HPix,VPix,HPos,VPos,Radius,ColorIn,ColorOut,CircleExist);--

end Behavioral;
