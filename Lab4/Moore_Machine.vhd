library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Moore_Machine IS Port
(
 clkin_50, reset, clK_en, blink_sig			: IN std_logic;
 NSrequest, EWrequest						: IN std_logic;
 Mode                                       : IN std_logic;
 greenns, yellowns, redns				: OUT std_logic;
 greenew, yellowew, redew				: OUT std_logic;
 NS_CROSSINGS, EW_CROSSINGS, NSREGISTER_CLEAR, EWREGISTER_CLEAR : OUT std_logic;
 stateout                           : OUT std_logic_vector (3 downto 0)
 
 );
END ENTITY;
 

 Architecture SM of Moore_Machine is
 
 
 TYPE STATE_NAMES IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15);

 
 SIGNAL current_state, next_state	:  STATE_NAMES;     	-- signals of type STATE_NAMES

 BEGIN

 -------------------------------------------------------------------------------
 --State Machine:
 -------------------------------------------------------------------------------

 -- REGISTER_LOGIC PROCESS EXAMPLE
 
Register_Section: PROCESS (clkin_50)  -- this process updates with a clock
BEGIN
	IF(rising_edge(clkin_50)) THEN
		IF (reset = '1') THEN
			current_state <= S0;
		ELSIF (reset = '0' AND clk_en = '1') THEN
			current_state <= next_State;
		END IF;
	END IF;
END PROCESS;	



-- TRANSITION LOGIC PROCESS EXAMPLE

Transition_Section: PROCESS (EWrequest, NSrequest, current_state) 

BEGIN
  CASE current_state IS
        WHEN S0 =>
		     IF (NSrequest = '0' AND EWrequest = '1') then
			      next_state <= S6;
			  else
					next_state <= S1;
				end if;
         WHEN S1 =>		
		     IF (NSrequest = '0' AND EWrequest = '1') then
			  next_state <= S6;
			  else
			  next_state <= S2;
			  end if;
         WHEN S2 =>		
					next_state <= S3;		
         WHEN S3 =>		
					next_state <= S4;
         WHEN S4 =>		
					next_state <= S5;
         WHEN S5 =>		
					next_state <= S6;			
         WHEN S6 =>		
					next_state <= S7;
         WHEN S7 =>		
					next_state <= S8;
			WHEN S8 =>		
			  IF (NSrequest = '1' AND EWrequest = '0') then
			  next_state <= S14;
			  else
			  next_state <= S9;
			  end if;
			WHEN S9 =>		
			  IF (NSrequest = '1' AND EWrequest = '0') then
			    next_state <= S14;
			  else
			    next_state <= S10;
			  end if;
			WHEN S10 =>		
					next_state <= S11;
			WHEN S11 =>		
					next_state <= S12;
			WHEN S12 =>		
					next_state <= S13;
			WHEN S13 =>		
					next_state <= S14;
			WHEN S14 =>		
					next_state <= S15;
			WHEN S15 =>
			    IF (Mode = '1') then
					next_state <= S15;
				else	
					next_state <= S0;
				end if;					
	  END CASE;
 END PROCESS;
 

-- DECODER SECTION PROCESS EXAMPLE (MOORE FORM SHOWN)

Decoder_Section: PROCESS (current_state) 

BEGIN

   NS_CROSSINGS <= '0';
	EW_CROSSINGS <= '0';
	NSREGISTER_CLEAR <= '0';
	EWREGISTER_CLEAR <= '0';


     CASE current_state IS
	  
         WHEN S0 =>		
			greenns <= blink_sig;
			redns <= '0';
			yellowns <= '0';
			
			greenew <= '0';
			redew <= '1';
			yellowew <= '0';
			
			stateout <= "0000";
			
			WHEN S1 =>		
			greenns <= blink_sig;
			redns <= '0';
			yellowns <= '0';
			
			greenew <= '0';
			redew <= '1';
			yellowew <= '0';
			
			stateout <= "0001";
			
         WHEN S2 =>		
			greenns <= '1';
			redns <= '0';
			yellowns <= '0';
			
			greenew <= '0';
			redew <= '1';
			yellowew <= '0';
			
			NS_CROSSINGS <= '1';
			EW_CROSSINGS <= '0';
			
			stateout <= "0010";
			
			WHEN S3 =>		
			greenns <= '1';
			redns <= '0';
			yellowns <= '0';
			
			greenew <= '0';
			redew <= '1';
			yellowew <= '0';
			
			NS_CROSSINGS <= '1';
			EW_CROSSINGS <= '0';
			
			stateout <= "0011";
			
			WHEN S4 =>		
			greenns <= '1';
			redns <= '0';
			yellowns <= '0';
			
			greenew <= '0';
			redew <= '1';
			yellowew <= '0';
			
			NS_CROSSINGS <= '1';
			EW_CROSSINGS <= '0';
			
			stateout <= "0100";
			
			WHEN S5 =>		
			greenns <= '1';
			redns <= '0';
			yellowns <= '0';
			
			greenew <= '0';
			redew <= '1';
			yellowew <= '0';
			
			NS_CROSSINGS <= '1';
			EW_CROSSINGS <= '0';
			
			stateout <= "0101";
			
         WHEN S6 =>		
			greenns <= '0';
			redns <= '0';
			yellowns <= '1';
			
			greenew <= '0';
			redew <= '1';
			yellowew <= '0';
			
			NSREGISTER_CLEAR <= '1';
			
			stateout <= "0110";
			
			WHEN S7 =>		
			greenns <= '0';
			redns <= '0';
			yellowns <= '1';
			
			greenew <= '0';
			redew <= '1';
			yellowew <= '0';
			
			stateout <= "0111";
			
			WHEN S8 =>
			greenns <= '0';
			redns <= '1';
			yellowns <= '0';
			
			greenew <= blink_sig;
			redew <= '0';
			yellowew <= '0';
			
			stateout <= "1000";
			
			WHEN S9 =>
			greenns <= '0';
			redns <= '1';
			yellowns <= '0';
			
			greenew <= blink_sig;
			redew <= '0';
			yellowew <= '0';
			
			stateout <= "1001";
			
			WHEN S10 =>
			greenns <= '0';
			redns <= '1';
			yellowns <= '0';
			
			greenew <= '1';
			redew <= '0';
			yellowew <= '0';
			
			NS_CROSSINGS <= '0';
			EW_CROSSINGS <= '1';
			
			stateout <= "1010";
			
		   WHEN S11 =>
			greenns <= '0';
			redns <= '1';
			yellowns <= '0';
			
			greenew <= '1';
			redew <= '0';
			yellowew <= '0';
			
			NS_CROSSINGS <= '0';
			EW_CROSSINGS <= '1';
			
			stateout <= "1011";
			
			WHEN S12 =>
			greenns <= '0';
			redns <= '1';
			yellowns <= '0';
			
			greenew <= '1';
			redew <= '0';
			yellowew <= '0';
			
			NS_CROSSINGS <= '0';
			EW_CROSSINGS <= '1';
			
			stateout <= "1100";
			
			WHEN S13 =>
			greenns <= '0';
			redns <= '1';
			yellowns <= '0';
			
			greenew <= '1';
			redew <= '0';
			yellowew <= '0';
			
			NS_CROSSINGS <= '0';
			EW_CROSSINGS <= '1';
			
			stateout <= "1101";
			
			WHEN S14 =>
			greenns <= '0';
			redns <= '1';
			yellowns <= '0';
			
			greenew <= '0';
			redew <= '0';
			yellowew <= '1';
			
			EWREGISTER_CLEAR <= '1';
			
			stateout <= "1110";
			
			WHEN S15 =>
			IF (Mode = '1') then
			  greenns <= '0';
			  redns <= blink_sig;
			  yellowns <= '0';
			
			  greenew <= '0';
			  redew <= '0';
			  yellowew <= blink_sig;
			
			else
			
			  greenns <= '0';
			  redns <= '1';
			  yellowns <= '0';
			
			  greenew <= '0';
			  redew <= '0';
			  yellowew <= '1';
			
			end if;
			
			stateout <= "1111";
				
         WHEN others =>			
	      greenns <= '0';
			redns <= '0';
			yellowns <= '0';
			
			greenew <= '0';
			redew <= '0';
			yellowew <= '0';
		
			NS_CROSSINGS <= '0';
			EW_CROSSINGS <= '0';	
	    
	  END CASE;
 END PROCESS;

 END ARCHITECTURE SM;