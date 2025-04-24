--inclusion
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


--entity
entity my_counter is
    port(
        clock_50: in std_logic;
        sw      : in std_logic_vector(9 downto 0);
        ledr    : out unsigned(9 downto 0)
    );
end;


--architecture
architecture rtl of my_counter is   
--en signal av type unsigned som är 25 bitar bred och heter cnt
signal cnt : unsigned(24 downto 0) := (others => '0');
begin
    process (clock_50) is
    begin
        if rising_edge(clock_50) then
            --inkrementera cnt när sw0 är hög
            if sw(0) = '1' then
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    ledr(9 downto 6) <= cnt(24 downto 21);
end;