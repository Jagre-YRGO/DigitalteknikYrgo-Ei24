--library inclusion
library ieee;
use ieee.std_logic_1164.all;



--entity declaration
entity four_bit_adder is
    port(
        --inputs
        a_top : in std_logic_vector(3 downto 0);
        b_top : in std_logic_vector(3 downto 0);
        --outputs
        cout_top : out std_logic;
        sum_top : out std_logic_vector(3 downto 0)
    );
end;


--architecture
architecture struct of four_bit_adder is

signal carry_over : std_logic_vector(3 downto 0);

begin

    fa0 : entity work.fa
    port map(
        a => a_top(0),
        b => b_top(0),
        cin => '0',
        s => sum_top(0),
        cout => carry_over(0)
    );
    
    fa1 : entity work.fa
    port map(
        a => a_top(1),
        b => b_top(1),
        cin => carry_over(0),
        s => sum_top(1),
        cout => carry_over(1)
    );

    fa2 : entity work.fa
    port map(
        a => a_top(2),
        b => b_top(2),
        cin => carry_over(1),
        s => sum_top(2),
        cout => carry_over(2)
    );
    
    fa3 : entity work.fa
    port map(
        a => a_top(3),
        b => b_top(3),
        cin => carry_over(2),
        s => sum_top(3),
        cout => carry_over(3)
    );

    cout_top <= carry_over(3);
    
end;


