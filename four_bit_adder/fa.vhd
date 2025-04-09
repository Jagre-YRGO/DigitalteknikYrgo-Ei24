library ieee;
use ieee.std_logic_1164.all;

entity fa is
    port (a,b,cin : in std_logic;
     s, cout : out std_logic);
end;

architecture rtl of fa is
    signal ab_and : std_logic;
    signal ab_xor_and_cin : std_logic;
    signal ab_xor : std_logic;
begin
    ab_xor <= a xor b;
    ab_xor_and_cin <= ab_xor and cin;
    ab_and <= a and b;
    
    s <= ab_xor xor cin;
    cout <= ab_xor_and_cin or ab_and;
end;