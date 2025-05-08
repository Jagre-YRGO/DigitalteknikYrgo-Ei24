--library inclusion
library ieee;
use ieee.std_logic_1164.all;

--Entity declaration
entity codelock is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        c1,c2,c3,c4 : in std_logic;             --keypad input numbers
        lock    : out std_logic;                --door knob motor
        ledr : out std_logic_vector(3 downto 0) --debug outputs
    );
end entity;

architecture rtl of codelock is

type my_state_type is (IDLE, S0, S1, S2, UNLOCK);

signal current_state : my_state_type;
signal c1_s, c2_s, c3_s, c4_s : std_logic;
signal c1_old, c2_old, c3_old, c4_old : std_logic;

begin
    --sync process with assync reset
    process (clk, rst) is
    begin
        if rst = '0' then
            --reset statements
            current_state <= IDLE;
            lock <= '0';
        elsif rising_edge(clk) then
            c1_old <= c1;
            c2_old <= c2;
            c3_old <= c3;
            c4_old <= c4;
            
            c1_s <= not (not c1 and c1_old);
            c2_s <= not (not c2 and c2_old);
            c3_s <= not (not c3 and c3_old);
            c4_s <= not (not c4 and c4_old);
        
        
            -- statemachine and all the rest
            case current_state is
                when IDLE =>
                    --beskriv hur vi tar oss till nästa tillstånd
                    --om C2 -> gå till S0
                    if c2_s = '0' then
                        current_state <= S0;
                    end if;
                    lock <= '0';
                    
                when S0 =>
                    if c2_s = '0' then
                        current_state <= S1;
                    elsif (c1_s = '0') or (c3_s = '0') or (c4_s = '0') then
                        current_state <= IDLE;
                    end if;
                    lock <= '0';
                    
                
                when S1 =>
                    if c4_s = '0' then
                        current_state <= S2;
                    elsif (c1_s = '0') or (c3_s = '0') or (c2_s = '0') then
                        current_state <= IDLE;
                    end if;
                    lock <= '0';
                
              
                when S2 =>
                    if c1_s = '0' then
                        current_state <= UNLOCK;
                    elsif (c2_s = '0') or (c3_s = '0') or (c4_s = '0') then
                        current_state <= IDLE;
                    end if;
                    lock <= '0';

    
                when UNLOCK =>
                    if (c1_s = '0') or (c2_s = '0') or (c3_s = '0') or (c4_s = '0') then
                        current_state <= IDLE;
                    end if;
                    lock <= '1';
                                    
            end case;
            
        end if;
    end process;
    
    ledr <= c1 & c2 & c3 & c4;
    
end architecture;