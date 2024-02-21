class refmod extends uvm_component;
   `uvm_component_utils(refmod)

   uvm_get_port #(a_tr) in; 
   uvm_blocking_put_port #(a_tr) out; 

   function new(string name, uvm_component parent=null);
      super.new(name,parent);
      in  = new("in",  this);
      out = new("out", this);
   endfunction : new
   task sorted_bubble(logic [7:0] vector [7:0], a_tr tr_in);
     logic [7:0] varTemp;
	vector[0] = tr_in.a;
	vector[1] = tr_in.a1;
	vector[2] = tr_in.a2;
	vector[3] = tr_in.a3;
	vector[4] = tr_in.a4;
	vector[5] = tr_in.a5;
	vector[6] = tr_in.a6;
	vector[7] = tr_in.a7;
	for(int i = 1; i < 8; i++)begin
		if(vector[i] > vector[i-1])begin
			varTemp = vector[i];
			vector[i] = vector[i-1];
			vector[i-1] = varTemp;
		end	
			
	end

   endtask
   task run_phase (uvm_phase phase);

     a_tr tr_in, tr_out;
     logic [7:0] vector [7:0];
     logic [7:0] varTemp;
 
     forever begin
        in.get(tr_in);
	vector[0] = tr_in.a;

	vector[1] = tr_in.a1;
	vector[2] = tr_in.a2;
	vector[3] = tr_in.a3;
	vector[4] = tr_in.a4;
	vector[5] = tr_in.a5;
	vector[6] = tr_in.a6;
	vector[7] = tr_in.a7;
	for(int i = 0; i < 8; i++)begin
		for(int j = i; j < 8; j++)	
		
			if(vector[i] > vector[j])begin
				varTemp = vector[i];
				vector[i] = vector[j];
				vector[j] = varTemp;
			end	
			
	end	
        #10;
        `bvm_end_tr(tr_in);

        tr_out = a_tr::type_id::create("tr_out", this);
        tr_out.a = vector[0];
	tr_out.a1 = vector[1];
        tr_out.a2 = vector[2];
	tr_out.a3 = vector[3];
        tr_out.a4 = vector[4];
	tr_out.a5 = vector[5];
        tr_out.a6 = vector[6];
	tr_out.a7 = vector[7];
        `bvm_begin_tr(tr_out)
        #10;
        out.put(tr_out);
     end

   endtask

endclass

