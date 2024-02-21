class a_tr extends uvm_sequence_item;

  rand int a, a1, a2, a3, a4, a5, a6, a7;

  constraint a_positive { a > 0; }
  constraint a_positive1 { a1 > 0; }
  constraint a_positive2 { a2 > 0; }
  constraint a_positive3 { a3 > 0; }
  constraint a_positive4 { a4 > 0; }
  constraint a_positive5 { a5 > 0; }
  constraint a_positive6 { a6 > 0; }
  constraint a_positive7 { a7 > 0; }
  constraint a_small { a < 256; }
  constraint a_small1 { a1 < 256; }
  constraint a_small2 { a2 < 256; }
  constraint a_small3 { a3 < 256; }
  constraint a_small4 { a4 < 256; }
  constraint a_small5 { a5 < 256; }
  constraint a_small6 { a6 < 256; }
  constraint a_small7 { a7 < 256; }

  `uvm_object_utils_begin(a_tr)  // needed for transaction recording
     `uvm_field_int(a, UVM_ALL_ON | UVM_DEC)
     `uvm_field_int(a1, UVM_ALL_ON | UVM_DEC)
     `uvm_field_int(a2, UVM_ALL_ON | UVM_DEC)
     `uvm_field_int(a3, UVM_ALL_ON | UVM_DEC)
     `uvm_field_int(a4, UVM_ALL_ON | UVM_DEC)
     `uvm_field_int(a5, UVM_ALL_ON | UVM_DEC)
     `uvm_field_int(a6, UVM_ALL_ON | UVM_DEC)
     `uvm_field_int(a7, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

endclass

