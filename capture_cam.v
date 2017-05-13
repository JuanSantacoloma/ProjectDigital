module capture_cam ( p_clock, vsync, href, enable, p_data);

	input wire p_clock;  //Pulso
	input wire vsync;   //Posición
	input wire href;	//Posiciòn
	input enable;	
	input wire [7:0] p_data; 	//Información byte
	output reg [7:0] pixel_data =0; //Byte de salida
	output reg pixel_valid = 0,
	output reg frame_done = 0


	reg [1:0] FSM = 0  //Maquina de Estados
	localparam WAIT=0; 	//Esperar
	localparam SAVE=1;	//Capturar

	case(FSM)

		WAIT: begin

			always @(posedge enable) begin
				
					if (vsync==0) begin
					FSM <= 0;
						
					else begin
						FSM <= SAVE; 
					end
					
				end
				
			end
				
		end


		SAVE: begin	

			always @(posedge enable) begin
					if(vsync==1)begin
					FSM<= vsync ? WAIT : SAVE;
		   			frame_done <= vsync ? 1 : 0;
		   		 	pixel_valid <= (href) ? 1 : 0; 

					if(href) begin
						pixel_data <= p_data;
					end
				 
				end
			end
		end

	end

endmodule