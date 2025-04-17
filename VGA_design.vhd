----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2024 04:46:58 PM
-- Design Name: 
-- Module Name: VGA_design - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_design is
    Port ( 
            clk25  :  in  std_logic;
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
end VGA_design;

architecture Behavioral of VGA_design is

signal HCnt : integer range 1 to HMax;
signal VCnt : integer range 1 to VMax;
signal FCnt : integer range 0 to FMax;

begin

HPix <= HCnt;
VPix <= VCnt;
FrNr <= FCnt;

counting: process (clk25,AR)
begin
    if AR then
        HCnt <= 1;
        VCnt <= 1;
        FCnt <= 0;
        
    elsif rising_edge(clk25) then
        if HCnt < HMax then
            HCnt <= HCnt +1;
        else
            HCnt <= 1;
            if VCnt < VMax then
                VCnt <= VCnt +1;
            else
                VCnt <= 1;
                if not Freeze then
                    if FCnt < FMax then
                        FCnt <= FCnt +1;
                    else
                        FCnt <= 0;
                    end if;
                end if;
            end if;
        end if;
    end if;
end process counting;
               
syncing: process (HCnt, VCnt, VGAin, Freeze, RimDraw)
begin    
    if VCnt < VS1 or VCnt > VS2 then
        Vsync <= '1';
    else 
        Vsync <= '0';
    end if;

    if HCnt < HS1 or HCnt > HS2 then
        Hsync <= '1';
    else 
        Hsync <= '0';
    end if;
    
    if HCnt = HMax-1 and VCnt = Vmax and (not Freeze) then
        FrEnd <= true;
    else
        FrEnd <= false;
    end if;
        
    if HCnt > Hres or VCnt > Vres then
        VGAout <= blank;
    else
        VGAout <= VGAin;
    end if;
       
    -- One pixel rim in red (when RimDraw = true)
    if RimDraw and (HCnt = 1 or HCnt = Hres or VCnt = 1 or VCnt = VRes) then
        VGAout <= red;
    end if;
--    --in counter area
--    if ((HCnt = 568 and VCnt <=30) or (VCnt = 30 and HCnt >= 568)) then
--        VGAout <= red;   --there is shadow when VCnt is 30;
--    end if;
end process syncing;

end Behavioral;
