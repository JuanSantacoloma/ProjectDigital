module config_cam;

reg p_clock;  //Pulso  // Variables capture_cam
reg vsync;   //Posición
reg href;	//Posiciòn
reg enable;	
reg [7:0] p_data; 	//Información byte
wire [7:0] pixel_data =0; //Byte de salida
wire pixel_valid = 0;
wire frame_done = 0;

 reg clk;                      // Variables genram
 reg [18: 0] addr;      //-- Direcciones
 reg rw;                  //-- Modo lectura (0) o escritura (1)
 reg [7: 0] data_in;   //-- Dato de entrada
 reg en;                    // -- Control 
 reg cen;                   // -- Contador enable
 wire [7: 0] data_out;

 wire rst=0;          // Varaible auxiliar divisor



  capture_cam #(.p_clock(p_clock),
  				.vsync(vsync), 
  				.href(href), 
  				.enable(enable), 
  				.p_data(p_data),
  				.pixel_valid(pixel_valid), 
  				.pixel_data(pixel_data), 
  				.frame_done(frame_done)
  				);

  genram #(.clk(p_clock),
  		   .addr(addr),
  		   .rw(rw),.cen(cen),
         
  		   .data_in(data_in),
  		   .en(en),
  		   .cen(cen),
  		   .data_out(data_out)
  		   );

  clockDivider #(.p_clock(p_clock),
                 .clk(clk), 
                 .rst(rst)
         );



endmodule