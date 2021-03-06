	component present_core is
		port (
			clk_clk                               : in  std_logic                     := 'X'; -- clk
			pio_avail_external_connection_export  : out std_logic_vector(31 downto 0);        -- export
			pio_height_external_connection_export : out std_logic_vector(31 downto 0);        -- export
			pio_width_external_connection_export  : out std_logic_vector(31 downto 0);        -- export
			reset_reset_n                         : in  std_logic                     := 'X'  -- reset_n
		);
	end component present_core;

	u0 : component present_core
		port map (
			clk_clk                               => CONNECTED_TO_clk_clk,                               --                            clk.clk
			pio_avail_external_connection_export  => CONNECTED_TO_pio_avail_external_connection_export,  --  pio_avail_external_connection.export
			pio_height_external_connection_export => CONNECTED_TO_pio_height_external_connection_export, -- pio_height_external_connection.export
			pio_width_external_connection_export  => CONNECTED_TO_pio_width_external_connection_export,  --  pio_width_external_connection.export
			reset_reset_n                         => CONNECTED_TO_reset_reset_n                          --                          reset.reset_n
		);

