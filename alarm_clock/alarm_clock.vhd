-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alarm_clock is

    port(
        clk      : in   std_logic;
        rst      : in   std_logic;
        cancel   : in   std_logic;
        snooze   : in   std_logic;
        buzzer   : out  std_logic
    );

end entity;

architecture rtl of alarm_clock is

    -- Build an enumerated type for the state machine
    type state_type is (IDLE, BUZZER_STATE, MIN5);

    -- Register to hold the current state
    signal state   : state_type;
    signal snooze_s, cancel_s : std_logic;
    signal clock_rtc : unsigned(30 downto 0) := (others => '0'); --counts up to 24 * 50e6

    constant SEC_SCALE : integer := 50;
    
begin
    snooze_s <= not snooze;
    cancel_s <= not cancel;

    -- Logic to advance to the next state
    process (clk, rst)
    begin
        if rst = '1' then
            state <= IDLE;
        elsif (rising_edge(clk)) then
        
        
            if clock_rtc = 24*SEC_SCALE-1 then
                clock_rtc <= (others => '0');
            else
                clock_rtc <= clock_rtc + 1;
            end if;
            
            
            case state is
                when IDLE=>
                --Wait for alarm time to occur
                    if clock_rtc = 5*SEC_SCALE then
                        state <= BUZZER_STATE;
                    end if;
                
                    buzzer <= '0';
                
                when BUZZER_STATE=>
                --sound alarm, wait for snooze/cancel
                    if snooze_s = '1' then
                        state <= MIN5;
                    elsif cancel_s = '1' then
                        state <= IDLE;
                    end if;
                    buzzer <= '1';
                
                when MIN5 =>
                --alarm silent, wait for 1 sec timer
                    buzzer <= '0';
                
                
            end case;
        end if;
    end process;

end rtl;
