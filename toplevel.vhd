LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity toplevel is 
port(
clk : in std_logic;
reset : IN std_logic;
SSG : out std_logic_vector(6 downto 0)
);
end toplevel;

--inputs 


architecture structural of toplevel is
	component d_ff is
	port(
		clk : in std_logic;
		reset: in std_logic;
		d :in std_logic;
		q : out std_logic
);
end component;

component bcd is
port(
Number_In : In STD_LOGIC_VECTOR(3 downto 0);
Number_Out : OUT STD_LOGIC_vector(6 downto 0)
);
end component;


component Clock is
port(
clk_in : in std_logic;
Clk_out : out std_logic
);
end component;

signal q0 : std_logic;
signal q1 : std_logic;
signal q2 : std_logic;
signal q3 : std_logic;

signal D0 : std_logic; --this is D0
signal D1 : std_logic;
signal D2 : std_logic;
signal D3 : std_logic;

signal int_clk: std_logic;

SIGNAL NUMBER_IN_TEMP : STD_LOGIC_vector(3 downto 0);
SIGNAL NUMBER_OUT_TEMP : STD_LOGIC_VECTOR(6 downto 0);

Begin

Clock_inst:Clock PORT MAP(clk_in => clk, clk_out => int_clk);

dff1 : d_ff --first dff
	port map(
		clk => int_clk,
		reset => reset,
		d => D0,
		q => q0
);

	dff2 : d_ff
		port map(
		clk => int_clk,
		reset => reset,
		d => D1,
		q => q1
); 


dff3 : d_ff
		port map(
		clk => int_clk,
		reset => reset,
		d => D2,
		q => q2
); 

dff4 : d_ff
		port map(
		clk => int_clk,
		reset => reset,
		d => D3,
		q => q3
); 




bcd_INST:bcd PORT MAP(number_in => number_in_temp,  number_out => number_out_temp);
--number_in_temp <= dff4_output & dff3_output & dff2_output & dff1_output;
number_in_temp(0) <= q0;
number_in_temp(1) <= q1;
number_in_temp(2) <= q2;
number_in_temp(3) <= q3;



ssg(0) <= number_out_temp(0);
ssg(1) <= number_out_temp(1);
ssg(2) <= number_out_temp(2);
ssg(3) <= number_out_temp(3);	
ssg(4) <= number_out_temp(4);
ssg(5) <= number_out_temp(5);
ssg(6) <= number_out_temp(6);


Comb:process(q0,q1,q2,q3)
Begin
if((q3 = '0') and (q2 = '0') and (q1 = '0') AND (q0 = '0')) then
		D3 <= '0';--change these to data
		D2 <= '1';--5,2,1,4,3,6,9,8,7,0
		D1 <= '0';
		D0 <= '1';
	
		elsif((q3 = '0') AND (q2 = '1') AND (q1= '0')AND  (q0 = '1')) THEN
		D3 <= '0';--2
		D2 <= '0';
		D1 <= '1';
		D0 <= '0';
		
		
		elsif((q3 = '0') AND (q2 = '0') AND (q1 = '1') AND  (q0 = '0')) THEN
		D3 <= '0';
		D2 <= '0';--1
		D1 <= '0';
		D0 <= '1';
		
		
		elsif((q3 = '0') AND (q2= '0') AND (q1 =  '0') AND  (q0 = '1')) THEN
		D3 <= '0';--4
		D2 <= '1';
		D1 <= '0'; 
		D0 <= '0';
		
		elsif((q3 = '0') AND (q2 = '1') AND (q1 = '0') AND  (q0 = '0')) THEN
		D3 <= '0'; 
		D2 <= '0'; --3
		D1 <= '1';
		D0 <= '1';
		elsif((q3 = '0') AND (q2 = '0') AND (q1 = '1') AND  (q0 = '1')) THEN
		D3 <= '0'; 
		D2 <= '1'; --6
		D1 <= '1';
		D0 <= '0';
		elsif((q3 = '0') AND (q2 = '1') AND (q1 = '1') AND  (q0 = '0')) THEN
		D3 <= '1'; 
		D2 <= '0'; --9
		D1 <= '0';
		D0 <= '1';
		elsif((q3 = '1') AND (q2 = '0') AND (q1 = '0') AND  (q0 = '1')) THEN
		D3 <= '1'; 
		D2 <= '0'; --8
		D1 <= '0';
		D0 <= '0';
		elsif((q3 = '1') AND (q2 = '0') AND (q1 = '0') AND  (q0 = '0')) THEN
		D3 <= '0'; 
		D2 <= '1'; --7
		D1 <= '1';
		D0 <= '1';
		elsif((q3 = '0') AND (q2 = '1') AND (q1 = '1') AND  (q0 = '1')) THEN
		D3 <= '0'; 
		D2 <= '0'; --0
		D1 <= '0';
		D0 <= '0';
		
		else
		D3 <= '0';
		D2 <= '0';
		D1 <= '0';
		D0 <= '0';
		END IF;
end process;
end;
