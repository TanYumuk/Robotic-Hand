----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2024 18:35:21
-- Design Name: 
-- Module Name: servo - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity servo is
    generic (
    g_CLOCKS_PER_BIT : integer := 10416    
    );
    Port (clk: In std_logic;
          reset: in std_logic;
          i_RX_Serial : in  std_logic;
          trivial: out std_logic;
          pwm: out std_logic_vector(7 downto 3);
          o_RX_Byte   : out std_logic_vector(7 downto 0);
          repulser : OUT std_logic;
          P, Q     :   IN STD_LOGIC;
          c1, c2, c3, c4 : OUT std_logic;
          lon, loff: out std_logic;
          del: out std_logic_vector(3 downto 0));
end servo;

 architecture Behavioral of servo is

signal counter1 : natural range 0 to 2000000:= 0;
signal counter2 : natural range 0 to 2000000:= 0;
signal counter3 : natural range 0 to 2000000:= 0;
signal counter4 : natural range 0 to 2000000:= 0;
signal counter5 : natural range 0 to 2000000:= 0;
signal counterr : natural range 0 to 300000000:= 0;
signal counterr2 : natural range 0 to 300000000:= 0;

signal fingers: std_logic_vector (7 downto 0);
type t_Main_State is (Idle, RX_Start_Bit, RX_Data_Bits,
                     RX_Stop_Bit, Cleanup);
  signal r_Main_State : t_Main_State := Idle;

  signal r_Data_R : std_logic := '0';
  signal r_Data   : std_logic := '0';
   
  signal r_Clock_Count : integer range 0 to g_CLOCKS_PER_BIT-1 := 0;
  signal r_Bit_Index : integer range 0 to 7 := 0;  
  signal r_Received_Byte   : std_logic_vector(7 downto 0) := (others => '0');
  signal r_Received_Valid     : std_logic := '0';
 
 TYPE State_type IS (A, B, C, D, E, F);  
    signal State : State_Type;    
    
    signal button1: std_ulogic; 
    signal button2: std_ulogic;
    signal unlock: std_logic;
    signal s1 : std_logic;
    
    
 TYPE State_type2 IS (Roff, Ron);  
    signal State2 : State_Type2;
    signal close: std_logic ;
    signal spider: std_logic;
    signal impulse1 : std_logic;
    signal impulse2 : std_logic;
    
begin

  p_Sample : process (clk)            
  begin
    if rising_edge(clk) then          
      r_Data_R <= i_RX_Serial;
      r_Data   <= r_Data_R; 
    end if; 
  end process p_Sample;

  
  p_UART_RX : process (clk)           
  begin
    if rising_edge(clk) then         
      case r_Main_State is
        when Idle =>
          r_Received_Valid     <= '0';
          r_Clock_Count <= 0;
          r_Bit_Index <= 0;

          if r_Data = '0' then      
            r_Main_State <= RX_Start_Bit;
          else
            r_Main_State <= Idle;
          end if;

          
        when RX_Start_Bit =>
          if r_Clock_Count = (g_CLOCKS_PER_BIT-1)/2 then
            if r_Data = '0' then
              r_Clock_Count <= 0;  
              r_Main_State   <= RX_Data_Bits;
            else
              r_Main_State   <= Idle;
            end if;
          else
            r_Clock_Count <= r_Clock_Count + 1;
            r_Main_State   <= RX_Start_Bit;
          end if;
         
        
        when RX_Data_Bits =>
          if r_Clock_Count < g_CLOCKS_PER_BIT-1 then
            r_Clock_Count <= r_Clock_Count + 1;
            r_Main_State   <= RX_Data_Bits;
          else
            r_Clock_Count            <= 0;
            r_Received_Byte(r_Bit_Index) <= r_Data;
             
            
            if r_Bit_Index < 7 then
              r_Bit_Index <= r_Bit_Index + 1;
              r_Main_State   <= RX_Data_Bits;
            else
              r_Bit_Index <= 0;
              r_Main_State   <= RX_Stop_Bit;
            end if;
          end if;
           
        
        when RX_Stop_Bit =>
          
          if r_Clock_Count < g_CLOCKS_PER_BIT-1 then
            r_Clock_Count <= r_Clock_Count + 1;
            r_Main_State   <= RX_Stop_Bit;
          else
            r_Received_Valid     <= '1';
            r_Clock_Count <= 0;
            r_Main_State   <= Cleanup;
          end if;
            
        
        when Cleanup =>
          r_Main_State <= Idle;
          r_Received_Valid   <= '0'; 
        when others =>
          r_Main_State <= Idle;

      end case;
    end if;
  end process p_UART_RX;

  trivial  <= r_Received_Valid;
  fingers <= r_Received_Byte;
  close <= fingers(3)OR fingers(4)OR fingers(5)OR fingers(6)OR fingers(7);
  
process(clk)
 begin
 if rising_edge (clk) then
   if fingers(3) = '1' and fingers(4)= '0' and fingers(5) = '0' and fingers(6) = '1' and  fingers(7) = '1' then
    spider <= '0';
   else 
   spider <= '1';
   end if;
end if;

end process;

    
button1 <= fingers(3)or fingers(4) or fingers(5) or fingers(6);
button2 <= fingers(3)and fingers(4) and fingers(5) and fingers(6);


s1 <= not(fingers(7));

PROCESS (s1, reset) 
  BEGIN
    IF reset = '1' THEN            
        State <= A;
 
    ELSIF rising_edge(s1) THEN   
                         
        CASE State IS
            WHEN A => 
                IF button1='0' THEN 
                    State <= B;
                END IF; 
            WHEN B => 
                IF button1='0' THEN 
                    State <= B;
                elsif button2 = '1' then
                    State <= C;
                END IF;
            WHEN C => 
                IF button1='0' THEN
                    State <= D;
                elsif button2 = '1' then
                    State <= A;
                END IF; 
            WHEN D => 
                IF button1='0' THEN 
                    State <= E;
                elsif button2 = '1' then
                    State <= C;
                end if;
            WHEN E => 
                IF button1='0' THEN 
                    State <= B;
                elsif button2 = '1' then
                    State <= F;
                end if;
            WHEN F=> 
                IF reset='1' THEN 
                    State <= A; 
                END IF; 
        END CASE; 
    END IF; 
  END PROCESS;
del(0) <= '1' when state = A else '0';
del(1) <= '1' when state = B else '0';
del(2) <= '1' when state = C else '0';
del(3) <= '1' when state = D else '0';

c3 <= button1;
c4 <= button2;
unlock <= '1' WHEN State=F ELSE '0';
lon <= '1' WHEN State=F ELSE '0';
loff <= '0' WHEN State=F ELSE '1';

process (clk)
    begin
        if rising_edge (clk) then
          if unlock = '1' then
            if close = '0' then
                if counterr < 300000000 then
                    counterr <= counterr + 1;
                    if counterr = 299999999 then
                        counterr <= 0;
                        impulse1 <= '1';
                    end if;
                end if;
            else 
                counterr <= 0;
            end if;
            
             if spider = '0' then
                if counterr2 < 300000000 then
                    counterr2 <= counterr2 + 1;
                    if counterr2 = 299999999 then
                        counterr2 <= 0;
                        impulse2 <= '1';
                    end if;
                end if;
            else 
                counterr2 <= 0;
            end if;
       
       
            Case State2 is
                when Roff =>
                    if impulse1 = '1' then 
                        State2 <= Ron;
                        impulse1 <= '0';
                    end if;
                when Ron =>
                    if impulse2 = '1' then
                        State2 <= Roff;
                        impulse2 <= '0';
                    end if;
             END CASE;
           end if;
        end if;
END PROCESS;

repulser <= '1' WHEN State2 = Ron ELSE '0';
c1 <= '1' WHEN State2 = Ron ELSE '0';
c2 <= '1' WHEN State2 = Roff ELSE '0';

process (clk)
begin
if rising_edge (clk) then
  
   if unlock = '1' then
    if fingers(7) = '1' then
    
           if counter1 < 250000 then
           pwm(7) <= '1';
           counter1 <= counter1 + 1;
           elsif counter1 < 2000000 then 
           pwm(7) <= '0';
           counter1 <= counter1 + 1;
                if counter1 = 1999999 then
                counter1 <= 0;
                end if;
           else
                counter1 <= 0;
           end if;
       
     elsif fingers(7) = '0' then
        
           if counter1 < 50000 then
           pwm(7) <= '1';
           counter1 <= counter1 + 1;
           elsif counter1 < 2000000 then 
           pwm(7) <= '0';
           counter1 <= counter1 + 1;
                if counter1 = 1999999 then
                counter1 <= 0;
                end if;
           else
                counter1 <= 0;
           end if;
     end if;   
       
     if fingers(6) = '1' then
        
           if counter2 < 250000 then
           pwm(6) <= '1';
           counter2 <= counter2 + 1;
           elsif counter2 < 2000000 then 
           pwm(6) <= '0';
           counter2 <= counter2 + 1;
                if counter2 = 1999999 then
                counter2 <= 0;
                end if;
           else
                counter2 <= 0;
           end if;
           
      elsif fingers(6) = '0' then
        
           if counter2 < 50000 then
           pwm(6) <= '1';
           counter2 <= counter2 + 1;
           elsif counter2 < 2000000 then 
           pwm(6) <= '0';
           counter2 <= counter2 + 1;
                if counter2 = 1999999 then
                counter2 <= 0;
                end if;
           else
                counter2 <= 0;
           end if;
     end if; 
              
     if fingers(5) = '1' then
        
           if counter3 < 250000 then
           pwm(5) <= '1';
           counter3 <= counter3 + 1;
           elsif counter3 < 2000000 then 
           pwm(5) <= '0';
           counter3 <= counter3 + 1;
                if counter3 = 1999999 then
                counter3 <= 0;
                end if;
           else
                counter3 <= 0;
           end if;
           
      elsif fingers(5) = '0' then
        
           if counter3 < 50000 then
           pwm(5) <= '1';
           counter3 <= counter3 + 1;
           elsif counter3 < 2000000 then 
           pwm(5) <= '0';
           counter3 <= counter3 + 1;
                if counter3 = 1999999 then
                counter3 <= 0;
                end if;
           else
                counter3 <= 0;
           end if;
     end if;
              
     if fingers(4) = '1' then
        
           if counter4 < 250000 then
           pwm(4) <= '1';
           counter4 <= counter4 + 1;
           elsif counter4 < 2000000 then 
           pwm(4) <= '0';
           counter4 <= counter4 + 1;
                if counter4 = 1999999 then
                counter4 <= 0;
                end if;
           else
                counter4 <= 0;
           end if;
           
      elsif fingers(4) = '0' then
        
           if counter4 < 50000 then
           pwm(4)<= '1';
           counter4 <= counter4 + 1;
           elsif counter4 < 2000000 then 
           pwm(4) <= '0';
           counter4 <= counter4 + 1;
                if counter4 = 1999999 then
                counter4 <= 0;
                end if;
           else
                counter4 <= 0;
           end if;
     end if;    
             
     if fingers(3) = '1' then
        
           if counter5 < 250000 then
           pwm(3) <= '1';
           counter5 <= counter5 + 1;
           elsif counter5 < 2000000 then 
           pwm(3) <= '0';
           counter5 <= counter5 + 1;
                if counter5 = 1999999 then
                counter5 <= 0;
                end if;
           else
                counter5 <= 0;
           end if;
           
      elsif fingers(3) = '0' then
        
           if counter5 < 50000 then
           pwm(3) <= '1';
           counter5 <= counter5 + 1;
           elsif counter5 < 2000000 then 
           pwm(3) <= '0';
           counter5 <= counter5 + 1;
                if counter5 = 1999999 then
                counter5 <= 0;
                end if;
           else
                counter5 <= 0;
           end if;
       
      end if;
    end if;
   end if;
end process;            

  o_RX_Byte <= fingers;

end Behavioral;
