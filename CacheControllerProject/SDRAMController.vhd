library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SDRAMController is
    Port ( clk				: in STD_LOGIC;
			  ADDR 			: in  STD_LOGIC_VECTOR (15 downto 0);
			  
           WR_RD 			: in  STD_LOGIC;
           MEMSTRB 		: in  STD_LOGIC;
           
			  DIN 			: in  STD_LOGIC_VECTOR (7 downto 0);
           DOUT 			: out  STD_LOGIC_VECTOR (7 downto 0));
end SDRAMController;

architecture Behavioral of SDRAMController is
    type ramemory is array (7 downto 0, 31 downto 0) of std_logic_vector(7 downto 0);
    signal RAM_SIG: ramemory;	 
	 signal counter : integer := 0;
begin

process (CLK)
    begin
        if CLK'event and CLK = '1' then	
				-- If the counter is 0, initialize the RAM by writing "11110000" to every location in the RAM_SIG.		  
				if counter = 0 then
					for I in 0 to 7 loop
						for J in 0 to 31 loop
							RAM_SIG(i,j) <= "11110000"; --Initialize memory location
						end loop;
					end loop;
					counter <= 1;	
				end if;
				if MEMSTRB = '1' then -- If 'WR_RD' is 1, perform a write operation to the specified address.
					if WR_RD = '1' then
						RAM_SIG(to_integer(unsigned(ADDR(7 downto 5))),to_integer(unsigned(ADDR(4 downto 0)))) <= DIN;    
               else -- Otherwise, perform a read operation and output data to 'DOUT'
						DOUT <= RAM_SIG(to_integer(unsigned(ADDR(7 downto 5))),to_integer(unsigned(ADDR(4 downto 0))));
					end if;
				end if;
        end if;
    end process;
end Behavioral;