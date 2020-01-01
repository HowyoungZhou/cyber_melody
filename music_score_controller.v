`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:19:59 01/01/2020 
// Design Name: 
// Module Name:    music_score_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module music_score_controller(
    input clk_1ms,
    input en,
    input rst,
    output reg [7:0] note_pointer = 0,
    output reg [15:0] cur_length = 0,
    output [3:0] cur_note,
    output [3:0] cur_octave
    );

    wire [23:0] lenoc;
    wire [15:0] orig_length;

    assign orig_length = lenoc[23:8];
    assign cur_note = lenoc[7:4];
    assign cur_octave = lenoc[3:0];

    initial begin
        #10 cur_length <= orig_length;
    end
    
    always@(posedge clk_1ms)begin
        if(rst)begin
            note_pointer <= 0;
            cur_length <= orig_length;
        end
        else begin
            if(en)begin
                if (cur_length == 1)begin
                    note_pointer <= note_pointer + 1;
                    #10 cur_length <= orig_length;
                end 
                else begin
                    cur_length <= cur_length - 1;
                end
            end 
        end
    end

    music_score music_score (
        .a(note_pointer), // input [7 : 0] a
        .spo(lenoc) // output [23 : 0] spo
    );
endmodule