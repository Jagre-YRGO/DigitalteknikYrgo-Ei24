library ieee;
use ieee.std_logic_1164.all;

entity praktiskt_prov is
	port(
		clk : in std_logic;
		rst : in std_logic;
		dummy : out std_logic
	);
end entity;

architecture rtl of praktiskt_prov is
begin
	dummy <= rst;
end;