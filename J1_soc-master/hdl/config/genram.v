module genram(clk, address, rd, wr, data_in, data_out, en);

               //-- Puertos
         input clk;                      //-- Señal de reloj global
         input [16: 0] address;      //-- Direcciones
         input wr;
         input rd;                  //-- Modo lectura (0) o escritura (1)
         input [23: 0] data_in;   //-- Dato de entrada
         input en;                    // -- Control 
         output reg [23: 0] data_out; //-- Dato a escribir
          

//-- Parametro: Nombre del fichero con el contenido de la RAM
parameter ROMFILE = "datos.list";

  //-- Memoria
  reg [7:0] ramR [0:102399];
  reg [7:0] ramG [0:102399];
  reg [7:0] ramB [0:102399]; 

    //-- Lectura de la memoria
    always @(posedge en) begin

      if (rd == 1)
      data_out[7:0] <= ramR[address];
      data_out[15:8] <= ramG[address];
      data_out[23:16] <= ramB[address];
     // adresss = address + 1;
    end

    //-- Escritura en la memoria
    always @(posedge en) begin
      if (wr == 1) begin
        
          ramR[address] <= data_in [7:0];
          ramG[address] <= data_in [15:8];
          ramB[address] <= data_in [23:16];

          //if (address <= 16)) 
          // adresss = address + 1;
      end
    end

endmodule