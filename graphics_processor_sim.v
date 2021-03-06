`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:41:49 01/03/2020
// Design Name:   graphics_processor
// Module Name:   F:/Coding/cyber_melody/graphics_processor_sim.v
// Project Name:  cyber_melody
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: graphics_processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module graphics_processor_sim;

	// Inputs
	reg clk;
	reg en;
	reg opcode;
	reg [9:0] tl_x;
	reg [8:0] tl_y;
	reg [9:0] br_x;
	reg [8:0] br_y;
	reg [11:0] arg;

	// Outputs
	wire vram_we;
	wire [18:0] vram_addr;
	wire [11:0] vram_data;
	wire [17:0] rom_addr;
	wire [11:0] rom_data;
	wire finish;

	// Instantiate the Unit Under Test (UUT)
	graphics_processor uut (
		.clk(clk), 
		.en(en), 
		.opcode(opcode), 
		.tl_x(tl_x), 
		.tl_y(tl_y), 
		.br_x(br_x), 
		.br_y(br_y), 
		.arg(arg), 
		.rom_data(rom_data), 
		.vram_we(vram_we), 
		.vram_addr(vram_addr), 
		.vram_data(vram_data), 
		.rom_addr(rom_addr), 
		.finish(finish)
	);

	vram ram (
        .clka(clk), // input clka
        .wea(vram_we), // input [0 : 0] wea
        .addra(vram_addr), // input [18 : 0] addra
        .dina(vram_data), // input [11 : 0] dina
        .clkb(clk), // input clkb
        .addrb(), // input [18 : 0] addrb
        .doutb() // output [11 : 0] doutb
        );

	image_rom img_rom (
        .clka(clk), // input clka
        .addra(rom_addr), // input [17 : 0] addra
        .douta(rom_data) // output [11 : 0] douta
        );

	initial begin
		// Initialize Inputs
		clk = 0;
		en = 0;
		opcode = 0;
		tl_x = 0;
		tl_y = 0;
		br_x = 0;
		br_y = 0;
		arg = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		fork
			forever #10 clk <= ~clk;
			begin
				opcode = 0;
				tl_x = 10;
				tl_y = 10;
				br_x = 30;
				br_y = 30;
				arg = 12'h555;
				#100
				en = 1;
				#18000
				en = 0;
				#100
				opcode = 1;
				en = 1;
			end
		join
	end
      
endmodule

