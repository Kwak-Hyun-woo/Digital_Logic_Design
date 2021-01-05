library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity calculator_top is
  port (
    SYS_RESET_B           : in std_logic;
    SYS_CLK               : in std_Logic;

    START                 : in std_logic;
    OP_CODE               : in std_logic_vector(2 downto 0);

    DATA_A                : in std_logic_vector(7 downto 0);
    DATA_B                : in std_logic_vector(7 downto 0);

    DATA_C                : out std_logic_vector(15 downto 0);
    END_OP                : out std_logic
);
end calculator_top;

architecture Behavioral of calculator_top is
   component Binary_Adder_Substractor_8bit
        port(
        a, b: in std_logic_vector ;
        oper: in std_logic ;
        result: out std_logic_vector);
    end component ;

signal a_1 : std_logic_vector(15 downto 0);   
signal b_1 : std_logic_vector(15 downto 0);  

signal temp_a : std_logic_vector(15 downto 0) ;   
signal temp_b : std_logic_vector(15 downto 0) ;  

signal add_sub : std_logic;

signal temp_end_op: std_logic;

signal alu_result : std_logic_vector(15 downto 0);

signal shifted_a: std_logic_vector(15 downto 0);
signal shifted_b: std_logic_vector(15 downto 0);





signal none : std_logic_vector(15 downto 0);

type STATE_TYPE is ( STATE_ON, MUL2, MUL3, MUL4, MUL5, MUL6, MUL7, MUL8, MUL9, MUL10, MUL11, MUL12, MUL13, MUL14, MUL15, MUL16);
signal STATE : STATE_TYPE;

begin
a_1(7 downto 0) <= DATA_A;
a_1(15 downto 8) <= (others => DATA_A(7));
b_1(7 downto 0) <= DATA_B;
b_1(15 downto 8) <= (others => DATA_B(7));
none <= (others => '0');
--초기값 설정


process (SYS_CLK, SYS_RESET_B)
   begin
      if SYS_RESET_B = '0' then
       temp_a <= (others => '0');
       temp_b <= (others => '0');
       temp_end_op <= '0';

       shifted_a <=  (others => '0');
       shifted_b <=  (others => '0');
       add_sub <= '0';

       
       STATE <= STATE_ON;
      elsif (rising_edge (SYS_CLK)) then
         case STATE is 
              when STATE_ON =>
                 temp_end_op <= '0';
                 if start = '1' then
                     if OP_CODE = "001" then
                         temp_a <= a_1;
                         temp_b <= b_1;
                         add_sub <= '0';
                         temp_end_op <= '1';
                         
                         STATE <= STATE_ON;  
                         
                     elsif OP_CODE = "010" then
                         temp_a <= a_1;
                         temp_b <= b_1;
                         add_sub <= '1';
                         temp_end_op <= '1';
                         
                         STATE <= STATE_ON; 
                         
                     elsif OP_CODE = "100" then
                     -- initialize
                         if b_1(0) = '0' then
                        --shift
                            shifted_a(15 downto 1) <= a_1(14 downto 0);
                            shifted_a(0) <= '0';
                            shifted_b(15) <= '0';
                            shifted_b(14 downto 0) <= b_1(15 downto 1);
                            
                            
  
                            
                            temp_a <= (others => '0');
                            temp_b <= (others => '0');
                            add_sub <= '0';

                        
                        else
                        --add and shift
                            temp_a <= a_1;
                            temp_b <= (others => '0');
                            add_sub <= '0';
                
                            shifted_a(15 downto 1) <= a_1(14 downto 0);
                            shifted_a(0) <= '0';
                            shifted_b(15) <= '0';
                            shifted_b(14 downto 0) <= b_1(15 downto 1);
                            
                        end if;
                        STATE <= MUL2;
                     else  -- reserved
                        temp_a <= none;
                        temp_b <= none;
                        add_sub <= '0';
                        STATE <= STATE_ON;
                        end if;
                        
                  else -- when START = '0'
                       STATE <= STATE_ON;
                  end if;     
                  
                 when MUL2 =>
                    if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                                           
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';
     
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);

                    end if; 

                    STATE <= MUL3;
                   
                   
                 when MUL3 =>
                  if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 

                    STATE <= MUL4;
                    
                    
                 when MUL4 =>
                 if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 

                    STATE <= MUL5;
                    
                    
                 when MUL5 =>
                    if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                    STATE <= MUL6;
                    
                    
                 when MUL6 =>
                    if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
              
                    STATE <= MUL7;
                    
                    
                 when MUL7 =>
                   if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                    STATE <= MUL8;
                    
                    
                 when MUL8 =>
                  if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                
                    STATE <= MUL9;
                 when MUL9 =>
                   if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                    STATE <= MUL10;
                 when MUL10 =>
                   if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                    STATE <= MUL11;
                 when MUL11 =>
                  if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                    STATE <= MUL12;
                    
                 when MUL12 =>
                  if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                    STATE <= MUL13;
                 when MUL13 =>
                   if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                    STATE <= MUL14;
                 when MUL14 =>
                  if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
         
                    STATE <= MUL15;
                 when MUL15 =>
                   if shifted_b(0) = '0' then
                        --shift
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
                        
        
                        
                        temp_a <= alu_result; -- 결과 그대로 보존
                        temp_b <= none;
                        add_sub <= '0';

                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';

                        
                        shifted_a(15 downto 1) <= shifted_a(14 downto 0);
                        shifted_a(0) <= '0';
                        shifted_b(15) <= '0';
                        shifted_b(14 downto 0) <= shifted_b(15 downto 1);
       
                       
                    end if; 
                    
                    STATE <= MUL16;
                 when MUL16 =>
                       if shifted_b(0) = '0' then
                        temp_a <= alu_result;
                        temp_b <= none;
                        add_sub <= '0';
 
                    else
                        --add and shift
                        temp_a <= shifted_a;
                        temp_b <= alu_result;
                        add_sub <= '0';
                        
                    end if;
                    
                    temp_end_op <= '1';
                    STATE <= STATE_ON; 
                 end case;
             end if;
    end process;
 
 DATA_C <= alu_result;
 END_OP <= temp_end_op;
 
 ALU: Binary_Adder_Substractor_8bit port map( a => temp_a,
                                              b => temp_b, 
                                              oper => add_sub, 
                                              result => alu_result);

end Behavioral; 
