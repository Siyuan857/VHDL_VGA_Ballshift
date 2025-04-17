----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2024 04:45:54 PM
-- Design Name: 
-- Module Name: TopModule - Behavioral
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
use work.pack_DrawSign.all;
use work.pkg_PrASIC.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopModule is
    Port (
        clk     : in std_logic;
        btnC    : in std_logic;
        sw      : in std_logic_vector(15 downto 0);
        Hsync   : out std_logic;
        Vsync   : out std_logic;
        vgaRed  : out std_logic_vector(3 downto 0);
        vgaGreen: out std_logic_vector(3 downto 0);
        vgaBlue : out std_logic_vector(3 downto 0)
     );
end TopModule;

architecture Behavioral of TopModule is

    component clk_wiz_0
    
        Port (
            clk_out1:  out std_logic;
            reset   :  in  std_logic;
            clk_in1 :  in  std_logic
              );
    end component;
    
    component VGA_design
        Port (
            clk25   :  in  std_logic;
            AR      :  in  boolean;
            VGAin   :  in  vga12;
            Freeze  :  in  boolean;      
            RimDraw :  in boolean;
            HPix:     out integer range 1 to HMax;
            VPix:     out integer range 1 to VMax;
            FrNr:     out integer range 0 to FMax;
            FrEnd:    out boolean;
            Hsync:    out std_logic;
            Vsync:    out std_logic;
            VGAout:   out vga12
            );
    end component VGA_design;
        
    component Ball_shift is
    generic(
            HPosM      : integer range 1 to HRes;
            VPosM      : integer range 1 to VRes;
            Radius     : integer;
            ColorIn    : VGA12;
            HVel       : integer;
            VVel       : integer

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
            Collision  : in  boolean;     
            ColorOut   : out VGA12;
            CircleExist: out boolean                                              
            );
    end component Ball_shift;
        
--    component Frame_shift is
--    Port (   
--            clk25  : in STD_LOGIC;
--            AR     : in  boolean;
--            Freeze : in  boolean;
--            HPosMP  : out integer range 1 to HRes;
--            VPosMP  : out integer range 1 to VRes;
--            Up     : in  STD_LOGIC;
--            Down   : in  STD_LOGIC;
--            Left   : in  STD_LOGIC;
--            Right  : in  STD_LOGIC          
--            );
--    end component Frame_shift;
    
    signal T_VGAin :   VGA12;
    signal T_VGAout:   VGA12;   
    signal clk25   :   std_logic; 
    signal T_reset :   std_logic;
    signal T_FrEnd, T_AR, T_Freeze:  boolean;
--    signal T_U, T_D, T_L, T_R     :  STD_LOGIC; --up,down,left,right
    
    signal T_HPix     : integer range 1 to HMax;  --H_counter für VGA
    signal T_VPix     : integer range 1 to VMax;  --V_counter für VGA
    signal T_FrNr     : integer range 0 to FMax;  --VGA Frame Counter 
        
    signal T_HPosMP     : integer range 1 to HRes;  --H_counter für PicFrame     
    signal T_VPosMP     : integer range 1 to VRes;  --V_counter für PicFrame
        
    signal Collision  : Coll_Array;
    signal T_ColorOut : VGA12_Array;
    signal T_CircleExist  : Exist_Array;
    
    signal Coll_HMax, Coll_HMin, Coll_H: Coll_H_Array; 
    signal Coll_VMax, Coll_VMin, Coll_V: Coll_V_Array; 
--    signal Coll_H : integer range 1 to HMax; 
--    signal Coll_V : integer range 1 to VMax; 
begin

    Clk_IP : clk_wiz_0
        port map (
                clk_in1  => clk,
                reset    => T_reset,
                clk_out1 => clk25
                );
                
    Instantiation_VGA : VGA_design
        port map (
                clk25   => clk25,
                AR      => T_AR,
                VGAin   => T_VGAin,
                Freeze  => T_Freeze,
                RimDraw => true,
                HPix    => T_HPix,
                VPix    => T_VPix,
                FrNr    => T_FrNr,
                FrEnd   => T_FrEnd,
                Hsync   => HSync,
                Vsync   => VSync,
                VGAout  => T_VGAout 
                );
                
    Gen_ball: for i in 1 to AnzBall generate               
        Instantiation_ball : Ball_shift
            generic map(
                    HPosM      => (i*1497)mod HRes + 1,
                    VPosM      => (i*4497)mod VRes + 1,
                    Radius     => (i*i*97) mod 20 + 10,
                    ColorIn    => std_logic_vector(to_unsigned ((14337 *i*i)mod 4096,12)),
                    HVel       => (i*6 +1)mod 15 ,
                    VVel       => (i*12-1)mod 15
                    )
            port map(
                    clk25       => clk25,
                    AR          => T_AR,
                    Freeze      => T_Freeze,
                    HPix        => T_HPix,
                    VPix        => T_VPix,
                    HPixM       => Coll_H(i),
                    VPixM       => Coll_V(i),
                    FrEnd       => T_FrEnd,
                    Collision   => Collision(i),
                    ColorOut    => T_ColorOut(i),
                    CircleExist => T_CircleExist(i)
                    );

        DrawingBall: process (T_ColorOut,T_CircleExist)
        
        begin
        T_VGAin <= grey;
        
            for i in 1 to AnzBall loop
                if    T_CircleExist(i) then T_VGAin <= T_ColorOut(i); end if;
            end loop;
  
        end process DrawingBall; 
        
    end generate Gen_ball;


--    Instantiation_frame: Frame_shift
--        port map (
--                clk25  => clk25,
--                AR     => T_AR,
--                Freeze => T_Freeze,
--                HPosMP => T_HPosMP,
--                VPosMP => T_VPosMP,
--                Up     => T_U,
--                Down   => T_D,
--                Left   => T_L,
--                Right  => T_R
--                );

    
-------------------------------------------------
    T_reset  <= btnC;        -- high active reset for clock IP           
    T_AR     <= (btnC='1');  -- async. reset (converting to boolean)
    T_Freeze <= (sw(15)='1');-- freeze (converting to boolean)

--    T_U      <= btnU;
--    T_D      <= btnD;
--    T_L      <= btnL;
--    T_R      <= btnR;

    vgaRed   <=  T_VGAout (11 downto 8);
    vgaGreen <=  T_VGAout (7 downto 4);
    vgaBlue  <=  T_VGAout (3 downto 0);

    --------------------------------------------------

-- collision

process (clk25, T_AR, T_FrEnd)

begin

    if T_AR then
        for i in 1 to AnzBall loop
            Collision(i) <= false;
            Coll_HMax(i) <= 1;
            Coll_HMin(i) <= HMax;
            Coll_VMax(i) <= 1;
            Coll_VMin(i) <= VMax;
        end loop;
        
    elsif rising_edge(clk25) then
        for j in 1 to (AnzBall-1) loop
            for k in j+1 to AnzBall loop
                if T_CircleExist(j) and T_CircleExist(k) then
                    Collision(j) <= true;
                    Collision(k) <= true;
                    if T_HPix > Coll_HMax(j) then Coll_HMax(j) <= T_HPix; end if;
                    if T_HPix > Coll_HMax(k) then Coll_HMax(k) <= T_HPix; end if;
                    if T_HPix < Coll_HMin(j) then Coll_HMin(j) <= T_HPix; end if;
                    if T_HPix < Coll_HMin(k) then Coll_HMin(k) <= T_HPix; end if;
                    
                    if T_VPix > Coll_VMax(j) then Coll_VMax(j) <= T_VPix; end if;
                    if T_VPix > Coll_VMax(k) then Coll_VMax(k) <= T_VPix; end if;
                    if T_VPix < Coll_VMin(j) then Coll_VMin(j) <= T_VPix; end if; 
                    if T_VPix < Coll_VMin(k) then Coll_VMin(k) <= T_VPix; end if; 
                end if;
           end loop;
        end loop;
           
        if T_FrEnd then
            for i in 1 to AnzBall loop
                Collision(i) <= false;
                Coll_HMax(i) <= 1;
                Coll_HMin(i) <= HMax;
                Coll_VMax(i) <= 1;
                Coll_VMin(i) <= VMax;
            end loop;
        end if;
        
        for i in 1 to AnzBall loop
            Coll_H(i) <= (Coll_HMin(i) + Coll_HMax(i))/2;
            Coll_V(i) <= (Coll_VMin(i) + Coll_VMax(i))/2;
            
        end loop;   
    end if;
             
end process;

end architecture Behavioral;
