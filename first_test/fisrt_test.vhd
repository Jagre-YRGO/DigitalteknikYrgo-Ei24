--Library inclusion
library ieee;
use ieee.std_logic_1164.all;

--Entity declaration
entity first_test is
    port(
        in_a : in   std_logic;
        in_b : in   std_logic;
        out_0: out  std_logic
    );
end entity;

--Architecture
architecture rtl of first_test is
begin
    out_0 <= in_a and in_b;
end architecture;