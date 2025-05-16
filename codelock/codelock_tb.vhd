--library inclusion
library ieee;
use ieee.std_logic_1164.all;

--Entity declaration (empty)
entity codelock_tb is
end entity;

--Architecture declaration
architecture tb of codelock_tb is

signal clk_s                    : std_logic := '0';
signal rst_s                    : std_logic;
signal c1_s,c2_s,c3_s,c4_s      : std_logic;             --keypad input numbers
signal lock_s                   : std_logic;                --door knob motor
signal ledr_s                   : std_logic_vector(3 downto 0); --debug outputs

begin

    dut : entity work.codelock
        port map (
            clk => clk_s,
            rst => rst_s,
            c1 => c1_s,
            c2 => c2_s,
            c3 => c3_s,
            c4 => c4_s,
            lock => lock_s,
            ledr => ledr_s
        );

    --process for generating 50MHz clock
    clk_proc : process
    begin
        clk_s <= not clk_s;
        wait for 10 ns;
    end process;
    
    --process for input stimuli to DUT
    process
    begin
        c1_s <= '1';c2_s <= '1';c3_s <= '1';c4_s <= '1';
    
        --reset pulse generation
        rst_s <= '1';
        wait for 200 ns;
        rst_s <= '0';
        wait for 5 ns;
        rst_s <= '1';
        wait for 200 ns;
        
        
        --dial code 2-2-4-1
        --press key for 3 clk-cycles (60 ns)
        --release and wait for 100 ns before next key
        
        --dial 2 and pause
        c1_s <= '1';c2_s <= '0';c3_s <= '1';c4_s <= '1';
        wait for 60 ns;
        c1_s <= '1';c2_s <= '1';c3_s <= '1';c4_s <= '1';
        wait for 100 ns;

        --dial 2 and pause
        c1_s <= '1';c2_s <= '0';c3_s <= '1';c4_s <= '1';
        wait for 60 ns;
        c1_s <= '1';c2_s <= '1';c3_s <= '1';c4_s <= '1';
        wait for 100 ns;

        --dial 4 and pause
        c1_s <= '1';c2_s <= '1';c3_s <= '1';c4_s <= '0';
        wait for 60 ns;
        c1_s <= '1';c2_s <= '1';c3_s <= '1';c4_s <= '1';
        wait for 100 ns;

        --dial 1 and pause
        c1_s <= '0';c2_s <= '1';c3_s <= '1';c4_s <= '1';
        wait for 60 ns;
        c1_s <= '1';c2_s <= '1';c3_s <= '1';c4_s <= '1';
        wait for 100 ns;
        
        report "should be unlocked";
        
        --dial any to lock
        c1_s <= '0';c2_s <= '1';c3_s <= '1';c4_s <= '1';
        wait for 60 ns;
        c1_s <= '1';c2_s <= '1';c3_s <= '1';c4_s <= '1';
        wait for 100 ns;
        
        
        for i in 0 to 4 loop
            --dial any to lock
            c1_s <= '0';c2_s <= '0';c3_s <= '0';c4_s <= '0';
            wait for 60 ns;
            c1_s <= '1';c2_s <= '1';c3_s <= '1';c4_s <= '1';
            wait for 100 ns;
        end loop;
        
        wait;
    
    
    end process;
        
end architecture;




















