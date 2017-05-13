module genram_TB;

reg clk;
reg [18: 0] addr;
reg rw;
reg [7: 0] data_in;
wire [7: 0] data_out;
reg en;
   

genram uut(.clk(clk), .en(en), .addr(addr), .rw(rw), .data_in(data_in), .data_out(data_out));

	initial begin 

	clk=1;
	
	en=0; #2;
	data_in=8'b00000000;
	addr=19'b0000000000000000001;
	rw=1;
    en=1;
    #10;
    en=0; #2;

    data_in=8'b00000001;
	addr=19'b000000000000000011;
	rw=1;
    en=1;
    #10;
    en=0; #2;

    addr=19'b0000000000000000001;
    rw=0;
    en=1;
    #10;
    en=0; #2;


	end

	//-- Generador de reloj. Periodo 2 unidades
	always #1 clk = ~clk;

	initial begin: TEST_CASE
			$dumpfile("genram_TB.vcd");

			$dumpvars(-1,uut);
			#(200) $finish;
	end	

endmodule
