module genram(clk, addr, rw, data_in, data_out, en);

               //-- Puertos
         input clk;                      //-- Señal de reloj global
         input wire [18: 0] addr;      //-- Direcciones
         input wire rw;                  //-- Modo lectura (0) o escritura (1)
         input wire [7: 0] data_in;   //-- Dato de entrada
         input en;                    // -- Control 
         input cen;                   // -- Contador enable
         output reg [7: 0] data_out; //-- Dato a escribir

//-- Parametro: Nombre del fichero con el contenido de la RAM
parameter ROMFILE = "datos.list";

  //-- Memoria
  reg [7: 0] ram [0: 18];


    //-- Lectura de la memoria
    always @(posedge en) begin

      if (rw == 0)
      data_out <= ram[addr];
    end

    //-- Escritura en la memoria
    always @(posedge en) begin
      if (rw == 1)
       ram[addr] <= data_in;
    end

    //------ Contador
  //-- counter enable: Se pone a 1 cuando haya que acceder a la siguiente posicion de memoria
 

  always @(posedge en)
    if (!en)
      addr <= 0;
    else if (cen)
      addr <= addr + 1;

  //-- Overflow del contador: se pone a uno cuando todos sus bits
  //-- esten a 1
  wire ov = & addr;
   
  //-- Cargar en la memoria el fichero ROMFILE
  //-- Los valores deben estan dados en hexadecimal
initial begin
  $readmemh(ROMFILE, ram);
end

endmodule