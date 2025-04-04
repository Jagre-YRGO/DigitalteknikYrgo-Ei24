--include statements
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Entity declaration
entity calculator is
    port
    (
        -- Input ports
        a  : in  unsigned(3 downto 0);
        b  : in  unsigned(3 downto 0);
        sel: in  std_logic_vector(1 downto 0);

        -- Output ports
        led  : out unsigned(3 downto 0)
    );
end;



--Architecture declaration

architecture rtl of calculator is
begin
    --min mux 4:1
    with sel select
        led <= a+b     when "00",
               a-b     when "01",
               a and b when "10",
               a or  b when others;


end;
