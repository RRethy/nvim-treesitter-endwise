config({
  extension: "v",
  overrides: <<~INIT_LUA
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
INIT_LUA
})

test "verilog, module declaration non-ansi", <<~END
-module foo;█
+module foo;
+  
+endmodule
END

test "verilog, module declaration ansi", <<~END
-module foo(input clk, input reset);█
+module foo(input clk, input reset);
+  
+endmodule
END

test "verilog, interface declaration non-ansi", <<~END
-interface foo;█
+interface foo;
+  
+endinterface
END

test "verilog, interface declaration ansi", <<~END
-interface foo(input clk, input reset);█
+interface foo(input clk, input reset);
+  
+endinterface
END

test "verilog, class declaration", <<~END
-class foo;█
+class foo;
+  
+endclass
END

test "verilog, virtual class declaration", <<~END
-virtual class foo;█
+virtual class foo;
+  
+endclass
END

test "verilog, interface class declaration", <<~END
-interface class foo;█
+interface class foo;
+  
+endclass
END

test "verilog, package declaration", <<~END
-package foo;█
+package foo;
+  
+endpackage
END

test "verilog, class constructor declaration", <<~END
-function new;█
+function new;
+  
+endfunction: new
END

test "verilog, class constructor with arguments", <<~END
-function new(int a, int b);█
+function new(int a, int b);
+  
+endfunction: new
END

test "verilog, function declaration", <<~END
-function foo;█
+function foo;
+  
+endfunction
END

test "verilog, function with arguments", <<~END
-function foo(input a, output b);█
+function foo(input a, output b);
+  
+endfunction
END

test "verilog, task declaration", <<~END
-task foo;█
+task foo;
+  
+endtask
END

test "verilog, task with arguments", <<~END
-task foo(input a, output b);█
+task foo(input a, output b);
+  
+endtask
END

test "verilog, property declaration", <<~END
-property foo;█
+property foo;
+  
+endproperty
END

test "verilog, property with arguments", <<~END
-property foo(input a, logic b);█
+property foo(input a, logic b);
+  
+endproperty
END

test "verilog, generate region", <<~END
-generate█
+generate
+  
+endgenerate
END

test "verilog, case generate construct", <<~END
-case(select)█
+case(select)
+  
+endcase
END

test "verilog, generate block", <<~END
-if (condition) begin█
+if (condition) begin
+  
+end
END

test "verilog, generate block with name", <<~END
-if (condition) begin: my_block█
+if (condition) begin: my_block
+  
+end
END

test "verilog, sequential block", <<~END
-begin█
+begin
+  
+end
END

test "verilog, sequential block with name", <<~END
-begin: my_block█
+begin: my_block
+  
+end
END

test "verilog, parallel block", <<~END
-fork█
+fork
+  
+join
END

test "verilog, parallel block with name", <<~END
-fork: my_fork█
+fork: my_fork
+  
+join
END

test "verilog, case statement", <<~END
-case(expr)█
+case(expr)
+  
+endcase
END

test "verilog, case inside statement", <<~END
-case(expr) inside█
+case(expr) inside
+  
+endcase
END

test "verilog, nested module", <<~END
-module outer;
-  module inner;█
-endmodule
+module outer;
+  module inner;
+    
+  endmodule
+endmodule
END

test "verilog, nested function", <<~END
-module foo;
-  function bar;█
-endmodule
+module foo;
+  function bar;
+    
+  endfunction
+endmodule
END

test "verilog, nested task", <<~END
-module foo;
-  task proc;█
-endmodule
+module foo;
+  task proc;
+    
+  endtask
+endmodule
END

test "verilog, nested case statements", <<~END
-module foo;
-  initial begin
-    case(x)█
-  end
-endmodule
+module foo;
+  initial begin
+    case(x)
+      
+    endcase
+  end
+endmodule
END

test "verilog, begin in task", <<~END
-task foo;
-  begin█
-endtask
+task foo;
+  begin
+    
+  end
+endtask
END

test "verilog, fork in function", <<~END
-function foo;
-  fork█
-endfunction
+function foo;
+  fork
+    
+  join
+endfunction
END
