; SMT-LIBv2 description generated by Yosys 0.45+139 (git sha1 4d581a97d, clang++ 14.0.0-1ubuntu1.1 -fPIC -O3)
; yosys-smt2-module fifo_buffer
(declare-sort |fifo_buffer_s| 0)
(declare-fun |fifo_buffer_is| (|fifo_buffer_s|) Bool)
; yosys-smt2-witness {"offset": 0, "path": ["\\write_addr"], "smtname": 0, "smtoffset": 0, "type": "reg", "width": 3}
(declare-fun |fifo_buffer#0| (|fifo_buffer_s|) (_ BitVec 3)) ; \write_addr
; yosys-smt2-register write_addr 3
; yosys-smt2-wire write_addr 3
(define-fun |fifo_buffer_n write_addr| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#0| state))
(declare-fun |fifo_buffer#1| (|fifo_buffer_s|) Bool) ; \we
; yosys-smt2-input we 1
; yosys-smt2-wire we 1
; yosys-smt2-witness {"offset": 0, "path": ["\\we"], "smtname": "we", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |fifo_buffer_n we| ((state |fifo_buffer_s|)) Bool (|fifo_buffer#1| state))
(declare-fun |fifo_buffer#2| (|fifo_buffer_s|) (_ BitVec 1)) ; \rst
(define-fun |fifo_buffer#3| ((state |fifo_buffer_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|fifo_buffer#2| state)) #b1) #b0 #b1)) ; \count_bound_EN
; yosys-smt2-wire w_addr_bound_EN 1
(define-fun |fifo_buffer_n w_addr_bound_EN| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#3| state)) #b1))
; yosys-smt2-input rst 1
; yosys-smt2-wire rst 1
; yosys-smt2-witness {"offset": 0, "path": ["\\rst"], "smtname": "rst", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |fifo_buffer_n rst| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#2| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["\\read_addr"], "smtname": 4, "smtoffset": 0, "type": "reg", "width": 3}
(declare-fun |fifo_buffer#4| (|fifo_buffer_s|) (_ BitVec 3)) ; \read_addr
; yosys-smt2-register read_addr 3
; yosys-smt2-wire read_addr 3
(define-fun |fifo_buffer_n read_addr| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#4| state))
; yosys-smt2-wire r_addr_bound_EN 1
(define-fun |fifo_buffer_n r_addr_bound_EN| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#3| state)) #b1))
; yosys-smt2-output full 1
; yosys-smt2-wire full 1
(define-fun |fifo_buffer_n full| ((state |fifo_buffer_s|)) Bool false)
; yosys-smt2-memory FIFO 3 32 1 1 sync
; yosys-smt2-witness {"path": ["\\FIFO"], "rom": false, "size": 8, "smtname": "FIFO", "statebv": false, "type": "mem", "uninitialized": [{"offset": 0, "width": 256}], "width": 32}
(declare-fun |fifo_buffer#5#0| (|fifo_buffer_s|) (Array (_ BitVec 3) (_ BitVec 32))) ; FIFO
(define-fun |fifo_buffer_m FIFO| ((state |fifo_buffer_s|)) (Array (_ BitVec 3) (_ BitVec 32)) (|fifo_buffer#5#0| state))
(define-fun |fifo_buffer_m:R0A FIFO| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#4| state)) ; \read_addr
(define-fun |fifo_buffer#6| ((state |fifo_buffer_s|)) (_ BitVec 32) (select (|fifo_buffer#5#0| state) (|fifo_buffer_m:R0A FIFO| state))) ; $memrd$\FIFO$input_fifo.sv:19$7_DATA
(define-fun |fifo_buffer_m:R0D FIFO| ((state |fifo_buffer_s|)) (_ BitVec 32) (|fifo_buffer#6| state))
(declare-fun |fifo_buffer#7| (|fifo_buffer_s|) (_ BitVec 1)) ; \ce
(define-fun |fifo_buffer#8| ((state |fifo_buffer_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|fifo_buffer#7| state)) #b1) (|fifo_buffer#6| state) #b00000000000000000000000000000000)) ; \data_o
; yosys-smt2-output data_o 32
; yosys-smt2-wire data_o 32
(define-fun |fifo_buffer_n data_o| ((state |fifo_buffer_s|)) (_ BitVec 32) (|fifo_buffer#8| state))
(declare-fun |fifo_buffer#9| (|fifo_buffer_s|) (_ BitVec 32)) ; \data_i
; yosys-smt2-input data_i 32
; yosys-smt2-wire data_i 32
; yosys-smt2-witness {"offset": 0, "path": ["\\data_i"], "smtname": "data_i", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |fifo_buffer_n data_i| ((state |fifo_buffer_s|)) (_ BitVec 32) (|fifo_buffer#9| state))
; yosys-smt2-wire count_change_EN 1
(define-fun |fifo_buffer_n count_change_EN| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#3| state)) #b1))
; yosys-smt2-wire count_bound_EN 1
(define-fun |fifo_buffer_n count_bound_EN| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#3| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["\\count"], "smtname": 10, "smtoffset": 0, "type": "reg", "width": 3}
(declare-fun |fifo_buffer#10| (|fifo_buffer_s|) (_ BitVec 3)) ; \count
; yosys-smt2-register count 3
; yosys-smt2-wire count 3
(define-fun |fifo_buffer_n count| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#10| state))
(declare-fun |fifo_buffer#11| (|fifo_buffer_s|) Bool) ; \clk
; yosys-smt2-input clk 1
; yosys-smt2-wire clk 1
; yosys-smt2-clock clk posedge
; yosys-smt2-witness {"offset": 0, "path": ["\\clk"], "smtname": "clk", "smtoffset": 0, "type": "posedge", "width": 1}
; yosys-smt2-witness {"offset": 0, "path": ["\\clk"], "smtname": "clk", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |fifo_buffer_n clk| ((state |fifo_buffer_s|)) Bool (|fifo_buffer#11| state))
; yosys-smt2-input ce 1
; yosys-smt2-wire ce 1
; yosys-smt2-witness {"offset": 0, "path": ["\\ce"], "smtname": "ce", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |fifo_buffer_n ce| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#7| state)) #b1))
; yosys-smt2-anyseq fifo_buffer#12 3 $auto$setundef.cc:533:execute$317
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_317"], "smtname": 12, "smtoffset": 0, "type": "seq", "width": 3}
(declare-fun |fifo_buffer#12| (|fifo_buffer_s|) (_ BitVec 3)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_317
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_317 3
(define-fun |fifo_buffer_n _witness_.anyseq_auto_setundef_cc_533_execute_317| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#12| state))
; yosys-smt2-anyseq fifo_buffer#13 32 $auto$setundef.cc:533:execute$315
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_315"], "smtname": 13, "smtoffset": 0, "type": "seq", "width": 32}
(declare-fun |fifo_buffer#13| (|fifo_buffer_s|) (_ BitVec 32)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_315
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_315 32
(define-fun |fifo_buffer_n _witness_.anyseq_auto_setundef_cc_533_execute_315| ((state |fifo_buffer_s|)) (_ BitVec 32) (|fifo_buffer#13| state))
; yosys-smt2-anyseq fifo_buffer#14 3 $auto$setundef.cc:533:execute$313
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_313"], "smtname": 14, "smtoffset": 0, "type": "seq", "width": 3}
(declare-fun |fifo_buffer#14| (|fifo_buffer_s|) (_ BitVec 3)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_313
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_313 3
(define-fun |fifo_buffer_n _witness_.anyseq_auto_setundef_cc_533_execute_313| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#14| state))
; yosys-smt2-anyseq fifo_buffer#15 32 $auto$setundef.cc:533:execute$311
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_311"], "smtname": 15, "smtoffset": 0, "type": "seq", "width": 32}
(declare-fun |fifo_buffer#15| (|fifo_buffer_s|) (_ BitVec 32)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_311
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_311 32
(define-fun |fifo_buffer_n _witness_.anyseq_auto_setundef_cc_533_execute_311| ((state |fifo_buffer_s|)) (_ BitVec 32) (|fifo_buffer#15| state))
; yosys-smt2-anyseq fifo_buffer#16 3 $auto$setundef.cc:533:execute$309
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_309"], "smtname": 16, "smtoffset": 0, "type": "seq", "width": 3}
(declare-fun |fifo_buffer#16| (|fifo_buffer_s|) (_ BitVec 3)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_309
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_309 3
(define-fun |fifo_buffer_n _witness_.anyseq_auto_setundef_cc_533_execute_309| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#16| state))
; yosys-smt2-anyseq fifo_buffer#17 32 $auto$setundef.cc:533:execute$307
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_307"], "smtname": 17, "smtoffset": 0, "type": "seq", "width": 32}
(declare-fun |fifo_buffer#17| (|fifo_buffer_s|) (_ BitVec 32)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_307
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_307 32
(define-fun |fifo_buffer_n _witness_.anyseq_auto_setundef_cc_533_execute_307| ((state |fifo_buffer_s|)) (_ BitVec 32) (|fifo_buffer#17| state))
; yosys-smt2-anyinit fifo_buffer#18 3 input_fifo.sv:52.5-60.8
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_158"], "smtname": 18, "smtoffset": 0, "type": "init", "width": 3}
(declare-fun |fifo_buffer#18| (|fifo_buffer_s|) (_ BitVec 3)) ; \_witness_.anyinit_procdff_158
; yosys-smt2-register _witness_.anyinit_procdff_158 3
; yosys-smt2-wire _witness_.anyinit_procdff_158 3
(define-fun |fifo_buffer_n _witness_.anyinit_procdff_158| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#18| state))
; yosys-smt2-anyinit fifo_buffer#19 3 input_fifo.sv:52.5-60.8
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_157"], "smtname": 19, "smtoffset": 0, "type": "init", "width": 3}
(declare-fun |fifo_buffer#19| (|fifo_buffer_s|) (_ BitVec 3)) ; \_witness_.anyinit_procdff_157
; yosys-smt2-register _witness_.anyinit_procdff_157 3
; yosys-smt2-wire _witness_.anyinit_procdff_157 3
(define-fun |fifo_buffer_n _witness_.anyinit_procdff_157| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#19| state))
; yosys-smt2-anyinit fifo_buffer#20 3 input_fifo.sv:52.5-60.8
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_156"], "smtname": 20, "smtoffset": 0, "type": "init", "width": 3}
(declare-fun |fifo_buffer#20| (|fifo_buffer_s|) (_ BitVec 3)) ; \_witness_.anyinit_procdff_156
; yosys-smt2-register _witness_.anyinit_procdff_156 3
; yosys-smt2-wire _witness_.anyinit_procdff_156 3
(define-fun |fifo_buffer_n _witness_.anyinit_procdff_156| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#20| state))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:110:execute$191"], "smtname": 21, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |fifo_buffer#21| (|fifo_buffer_s|) (_ BitVec 1)) ; $auto$async2sync.cc:110:execute$191
; yosys-smt2-register $auto$async2sync.cc:110:execute$191 1
(define-fun |fifo_buffer_n $auto$async2sync.cc:110:execute$191| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#21| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:110:execute$185"], "smtname": 22, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |fifo_buffer#22| (|fifo_buffer_s|) (_ BitVec 1)) ; $auto$async2sync.cc:110:execute$185
; yosys-smt2-register $auto$async2sync.cc:110:execute$185 1
(define-fun |fifo_buffer_n $auto$async2sync.cc:110:execute$185| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#22| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:110:execute$179"], "smtname": 23, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |fifo_buffer#23| (|fifo_buffer_s|) (_ BitVec 1)) ; $auto$async2sync.cc:110:execute$179
; yosys-smt2-register $auto$async2sync.cc:110:execute$179 1
(define-fun |fifo_buffer_n $auto$async2sync.cc:110:execute$179| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#23| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:110:execute$173"], "smtname": 24, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |fifo_buffer#24| (|fifo_buffer_s|) (_ BitVec 1)) ; $auto$async2sync.cc:110:execute$173
; yosys-smt2-register $auto$async2sync.cc:110:execute$173 1
(define-fun |fifo_buffer_n $auto$async2sync.cc:110:execute$173| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#24| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:101:execute$169"], "smtname": 25, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |fifo_buffer#25| (|fifo_buffer_s|) (_ BitVec 1)) ; $auto$async2sync.cc:101:execute$169
; yosys-smt2-register $auto$async2sync.cc:101:execute$169 1
(define-fun |fifo_buffer_n $auto$async2sync.cc:101:execute$169| ((state |fifo_buffer_s|)) Bool (= ((_ extract 0 0) (|fifo_buffer#25| state)) #b1))
(define-fun |fifo_buffer#26| ((state |fifo_buffer_s|)) (_ BitVec 1) (bvnot (ite (|fifo_buffer#11| state) #b1 #b0))) ; $auto$rtlil.cc:2493:Not$320
; yosys-smt2-assume 0 $auto$formalff.cc:758:execute$321
(define-fun |fifo_buffer_u 0| ((state |fifo_buffer_s|)) Bool (or (= ((_ extract 0 0) (|fifo_buffer#26| state)) #b1) (not true))) ; $auto$formalff.cc:758:execute$321
; yosys-smt2-assert 0 w_addr_bound
(define-fun |fifo_buffer_a 0| ((state |fifo_buffer_s|)) Bool (or (= ((_ extract 0 0) (|fifo_buffer#24| state)) #b1) (not (= ((_ extract 0 0) (|fifo_buffer#25| state)) #b1)))) ; w_addr_bound
; yosys-smt2-assert 1 r_addr_bound
(define-fun |fifo_buffer_a 1| ((state |fifo_buffer_s|)) Bool (or (= ((_ extract 0 0) (|fifo_buffer#23| state)) #b1) (not (= ((_ extract 0 0) (|fifo_buffer#25| state)) #b1)))) ; r_addr_bound
; yosys-smt2-assert 2 count_change
(define-fun |fifo_buffer_a 2| ((state |fifo_buffer_s|)) Bool (or (= ((_ extract 0 0) (|fifo_buffer#22| state)) #b1) (not (= ((_ extract 0 0) (|fifo_buffer#25| state)) #b1)))) ; count_change
; yosys-smt2-assert 3 count_bound
(define-fun |fifo_buffer_a 3| ((state |fifo_buffer_s|)) Bool (or (= ((_ extract 0 0) (|fifo_buffer#21| state)) #b1) (not (= ((_ extract 0 0) (|fifo_buffer#25| state)) #b1)))) ; count_bound
(define-fun |fifo_buffer#27| ((state |fifo_buffer_s|)) Bool (bvuge (|fifo_buffer#0| state) #b000)) ; $ge$input_fifo.sv:56$44_Y
(define-fun |fifo_buffer#28| ((state |fifo_buffer_s|)) Bool (bvule (|fifo_buffer#0| state) #b111)) ; $le$input_fifo.sv:56$45_Y
(define-fun |fifo_buffer#29| ((state |fifo_buffer_s|)) Bool (and (or  (|fifo_buffer#27| state) false) (or  (|fifo_buffer#28| state) false))) ; $logic_and$input_fifo.sv:56$46_Y
(define-fun |fifo_buffer#30| ((state |fifo_buffer_s|)) Bool (bvuge (|fifo_buffer#4| state) #b000)) ; $ge$input_fifo.sv:55$41_Y
(define-fun |fifo_buffer#31| ((state |fifo_buffer_s|)) Bool (bvule (|fifo_buffer#4| state) #b111)) ; $le$input_fifo.sv:55$42_Y
(define-fun |fifo_buffer#32| ((state |fifo_buffer_s|)) Bool (and (or  (|fifo_buffer#30| state) false) (or  (|fifo_buffer#31| state) false))) ; $logic_and$input_fifo.sv:55$43_Y
(define-fun |fifo_buffer#33| ((state |fifo_buffer_s|)) Bool (not (or  (= ((_ extract 0 0) (|fifo_buffer#10| state)) #b1) (= ((_ extract 1 1) (|fifo_buffer#10| state)) #b1) (= ((_ extract 2 2) (|fifo_buffer#10| state)) #b1)))) ; $eq$input_fifo.sv:58$47_Y
(define-fun |fifo_buffer#34| ((state |fifo_buffer_s|)) Bool (= (|fifo_buffer#10| state) (|fifo_buffer#20| state))) ; $eq$input_fifo.sv:58$48_Y
(define-fun |fifo_buffer#35| ((state |fifo_buffer_s|)) Bool (or  (|fifo_buffer#33| state) false  (|fifo_buffer#34| state) false)) ; $logic_or$input_fifo.sv:58$49_Y
(define-fun |fifo_buffer#36| ((state |fifo_buffer_s|)) (_ BitVec 4) (bvadd (concat #b0 (|fifo_buffer#19| state)) #b0001)) ; $add$input_fifo.sv:58$50_Y
(define-fun |fifo_buffer#37| ((state |fifo_buffer_s|)) Bool (= (concat #b0 (|fifo_buffer#10| state)) (|fifo_buffer#36| state))) ; $eq$input_fifo.sv:58$51_Y
(define-fun |fifo_buffer#38| ((state |fifo_buffer_s|)) Bool (or  (|fifo_buffer#35| state) false  (|fifo_buffer#37| state) false)) ; $logic_or$input_fifo.sv:58$52_Y
(define-fun |fifo_buffer#39| ((state |fifo_buffer_s|)) (_ BitVec 4) (bvsub (concat #b0 (|fifo_buffer#18| state)) #b0001)) ; { $sub$input_fifo.sv:58$53_Y [31] $sub$input_fifo.sv:58$53_Y [2:0] }
(define-fun |fifo_buffer#40| ((state |fifo_buffer_s|)) Bool (= (concat #b00000000000000000000000000000 (|fifo_buffer#10| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (concat ((_ extract 3 3) (|fifo_buffer#39| state)) (|fifo_buffer#39| state))))))))))))))))))))))))))))))) ; $eq$input_fifo.sv:58$54_Y
(define-fun |fifo_buffer#41| ((state |fifo_buffer_s|)) Bool (or  (|fifo_buffer#38| state) false  (|fifo_buffer#40| state) false)) ; $logic_or$input_fifo.sv:58$55_Y
(define-fun |fifo_buffer#42| ((state |fifo_buffer_s|)) Bool (bvule (concat #b0 (|fifo_buffer#10| state)) #b1000)) ; $le$input_fifo.sv:30$19_Y
(define-fun |fifo_buffer#43| ((state |fifo_buffer_s|)) Bool (bvuge (|fifo_buffer#10| state) #b000)) ; $ge$input_fifo.sv:54$39_Y
(define-fun |fifo_buffer#44| ((state |fifo_buffer_s|)) Bool (and (or  (|fifo_buffer#42| state) false) (or  (|fifo_buffer#43| state) false))) ; $logic_and$input_fifo.sv:54$40_Y
(define-fun |fifo_buffer#45| ((state |fifo_buffer_s|)) (_ BitVec 3) (bvsub (|fifo_buffer#10| state) #b001)) ; $sub$input_fifo.sv:37$30_Y [2:0]
(define-fun |fifo_buffer#46| ((state |fifo_buffer_s|)) Bool (not (or  (|fifo_buffer#1| state) false))) ; $logic_not$input_fifo.sv:35$26_Y
(define-fun |fifo_buffer#47| ((state |fifo_buffer_s|)) Bool (bvugt (|fifo_buffer#10| state) #b000)) ; $gt$input_fifo.sv:35$27_Y
(define-fun |fifo_buffer#48| ((state |fifo_buffer_s|)) Bool (and (or  (|fifo_buffer#46| state) false) (or  (|fifo_buffer#47| state) false))) ; $logic_and$input_fifo.sv:35$28_Y
(define-fun |fifo_buffer#49| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (|fifo_buffer#48| state) (|fifo_buffer#45| state) (|fifo_buffer#10| state))) ; $procmux$146_Y
(define-fun |fifo_buffer#50| ((state |fifo_buffer_s|)) (_ BitVec 3) (bvadd (|fifo_buffer#10| state) #b001)) ; $add$input_fifo.sv:33$25_Y [2:0]
(define-fun |fifo_buffer#51| ((state |fifo_buffer_s|)) Bool (and (or  (|fifo_buffer#1| state) false) (or  (|fifo_buffer#42| state) false))) ; $logic_and$input_fifo.sv:30$20_Y
(define-fun |fifo_buffer#52| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (|fifo_buffer#51| state) (|fifo_buffer#50| state) (|fifo_buffer#49| state))) ; $procmux$149_Y
(define-fun |fifo_buffer#53| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|fifo_buffer#7| state)) #b1) (|fifo_buffer#52| state) (|fifo_buffer#10| state))) ; $procmux$151_Y
(define-fun |fifo_buffer#54| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|fifo_buffer#2| state)) #b1) #b000 (|fifo_buffer#53| state))) ; $0\count[2:0]
(define-fun |fifo_buffer#55| ((state |fifo_buffer_s|)) (_ BitVec 3) (bvadd (|fifo_buffer#4| state) #b001)) ; $add$input_fifo.sv:36$29_Y
(define-fun |fifo_buffer#56| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (|fifo_buffer#48| state) (|fifo_buffer#55| state) (|fifo_buffer#4| state))) ; $procmux$122_Y
(define-fun |fifo_buffer#57| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (|fifo_buffer#51| state) (|fifo_buffer#4| state) (|fifo_buffer#56| state))) ; $procmux$125_Y
(define-fun |fifo_buffer#58| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|fifo_buffer#7| state)) #b1) (|fifo_buffer#57| state) (|fifo_buffer#4| state))) ; $procmux$127_Y
(define-fun |fifo_buffer#59| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|fifo_buffer#2| state)) #b1) #b000 (|fifo_buffer#58| state))) ; $0\read_addr[2:0]
(define-fun |fifo_buffer#60| ((state |fifo_buffer_s|)) (_ BitVec 3) (bvadd (|fifo_buffer#0| state) #b001)) ; $add$input_fifo.sv:32$24_Y
(define-fun |fifo_buffer#61| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (|fifo_buffer#51| state) (|fifo_buffer#60| state) (|fifo_buffer#0| state))) ; $procmux$136_Y
(define-fun |fifo_buffer#62| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|fifo_buffer#7| state)) #b1) (|fifo_buffer#61| state) (|fifo_buffer#0| state))) ; $procmux$138_Y
(define-fun |fifo_buffer#63| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|fifo_buffer#2| state)) #b1) #b000 (|fifo_buffer#62| state))) ; $0\write_addr[2:0]
(define-fun |fifo_buffer#64| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (|fifo_buffer#51| state) (|fifo_buffer#0| state) (|fifo_buffer#12| state))) ; $3$memwr$\FIFO$input_fifo.sv:31$4_ADDR[2:0]$21
(define-fun |fifo_buffer#65| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|fifo_buffer#7| state)) #b1) (|fifo_buffer#64| state) (|fifo_buffer#16| state))) ; $2$memwr$\FIFO$input_fifo.sv:31$4_ADDR[2:0]$16
(define-fun |fifo_buffer#66| ((state |fifo_buffer_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|fifo_buffer#2| state)) #b1) (|fifo_buffer#14| state) (|fifo_buffer#65| state))) ; $0$memwr$\FIFO$input_fifo.sv:31$4_ADDR[2:0]$10
(define-fun |fifo_buffer#67| ((state |fifo_buffer_s|)) (_ BitVec 32) (ite (|fifo_buffer#51| state) (|fifo_buffer#9| state) (|fifo_buffer#13| state))) ; $3$memwr$\FIFO$input_fifo.sv:31$4_DATA[31:0]$22
(define-fun |fifo_buffer#68| ((state |fifo_buffer_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|fifo_buffer#7| state)) #b1) (|fifo_buffer#67| state) (|fifo_buffer#17| state))) ; $2$memwr$\FIFO$input_fifo.sv:31$4_DATA[31:0]$17
(define-fun |fifo_buffer#69| ((state |fifo_buffer_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|fifo_buffer#2| state)) #b1) (|fifo_buffer#15| state) (|fifo_buffer#68| state))) ; $0$memwr$\FIFO$input_fifo.sv:31$4_DATA[31:0]$11
(define-fun |fifo_buffer#70| ((state |fifo_buffer_s|)) (_ BitVec 1) (ite (|fifo_buffer#51| state) #b1 #b0)) ; $3$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$23 [31]
(define-fun |fifo_buffer#71| ((state |fifo_buffer_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|fifo_buffer#7| state)) #b1) (|fifo_buffer#70| state) #b0)) ; $2$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$18 [31]
(define-fun |fifo_buffer#72| ((state |fifo_buffer_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|fifo_buffer#2| state)) #b1) #b0 (|fifo_buffer#71| state))) ; $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31]
(define-fun |fifo_buffer_m:W0A FIFO| ((state |fifo_buffer_s|)) (_ BitVec 3) (|fifo_buffer#66| state)) ; $0$memwr$\FIFO$input_fifo.sv:31$4_ADDR[2:0]$10
(define-fun |fifo_buffer_m:W0D FIFO| ((state |fifo_buffer_s|)) (_ BitVec 32) (|fifo_buffer#69| state)) ; $0$memwr$\FIFO$input_fifo.sv:31$4_DATA[31:0]$11
(define-fun |fifo_buffer_m:W0M FIFO| ((state |fifo_buffer_s|)) (_ BitVec 32) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (concat (|fifo_buffer#72| state) (|fifo_buffer#72| state))))))))))))))))))))))))))))))))) ; { $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] $0$memwr$\FIFO$input_fifo.sv:31$4_EN[31:0]$12 [31] }
(define-fun |fifo_buffer#5#1| ((state |fifo_buffer_s|)) (Array (_ BitVec 3) (_ BitVec 32)) (ite (= (|fifo_buffer_m:W0M FIFO| state) #b00000000000000000000000000000000) (|fifo_buffer#5#0| state) (store (|fifo_buffer#5#0| state) (|fifo_buffer_m:W0A FIFO| state) (bvor (bvand (|fifo_buffer_m:W0D FIFO| state) (|fifo_buffer_m:W0M FIFO| state)) (bvand (select (|fifo_buffer#5#0| state) (|fifo_buffer_m:W0A FIFO| state)) (bvnot (|fifo_buffer_m:W0M FIFO| state))))))) ; FIFO
(define-fun |fifo_buffer_a| ((state |fifo_buffer_s|)) Bool (and
  (|fifo_buffer_a 0| state)
  (|fifo_buffer_a 1| state)
  (|fifo_buffer_a 2| state)
  (|fifo_buffer_a 3| state)
))
(define-fun |fifo_buffer_u| ((state |fifo_buffer_s|)) Bool 
  (|fifo_buffer_u 0| state)
)
(define-fun |fifo_buffer_i| ((state |fifo_buffer_s|)) Bool (and
  (= (|fifo_buffer#0| state) #b000) ; write_addr
  (= (|fifo_buffer#4| state) #b000) ; read_addr
  (= (|fifo_buffer#10| state) #b000) ; count
  (= (= ((_ extract 0 0) (|fifo_buffer#21| state)) #b1) true) ; $auto$async2sync.cc:110:execute$191
  (= (= ((_ extract 0 0) (|fifo_buffer#22| state)) #b1) true) ; $auto$async2sync.cc:110:execute$185
  (= (= ((_ extract 0 0) (|fifo_buffer#23| state)) #b1) true) ; $auto$async2sync.cc:110:execute$179
  (= (= ((_ extract 0 0) (|fifo_buffer#24| state)) #b1) true) ; $auto$async2sync.cc:110:execute$173
  (= (= ((_ extract 0 0) (|fifo_buffer#25| state)) #b1) false) ; $auto$async2sync.cc:101:execute$169
))
(define-fun |fifo_buffer_h| ((state |fifo_buffer_s|)) Bool true)
(define-fun |fifo_buffer_t| ((state |fifo_buffer_s|) (next_state |fifo_buffer_s|)) Bool (and
  (= (|fifo_buffer#3| state) (|fifo_buffer#25| next_state)) ; $auto$async2sync.cc:104:execute$171 $auto$async2sync.cc:101:execute$169
  (= (ite (|fifo_buffer#29| state) #b1 #b0) (|fifo_buffer#24| next_state)) ; $auto$async2sync.cc:112:execute$174 $auto$async2sync.cc:110:execute$173
  (= (ite (|fifo_buffer#32| state) #b1 #b0) (|fifo_buffer#23| next_state)) ; $auto$async2sync.cc:112:execute$180 $auto$async2sync.cc:110:execute$179
  (= (ite (|fifo_buffer#41| state) #b1 #b0) (|fifo_buffer#22| next_state)) ; $auto$async2sync.cc:112:execute$186 $auto$async2sync.cc:110:execute$185
  (= (ite (|fifo_buffer#44| state) #b1 #b0) (|fifo_buffer#21| next_state)) ; $auto$async2sync.cc:112:execute$192 $auto$async2sync.cc:110:execute$191
  (= (|fifo_buffer#10| state) (|fifo_buffer#20| next_state)) ; $procdff$156 \_witness_.anyinit_procdff_156
  (= (|fifo_buffer#10| state) (|fifo_buffer#19| next_state)) ; $procdff$157 \_witness_.anyinit_procdff_157
  (= (|fifo_buffer#10| state) (|fifo_buffer#18| next_state)) ; $procdff$158 \_witness_.anyinit_procdff_158
  (= (|fifo_buffer#54| state) (|fifo_buffer#10| next_state)) ; $procdff$159 \count
  (= (|fifo_buffer#59| state) (|fifo_buffer#4| next_state)) ; $procdff$161 \read_addr
  (= (|fifo_buffer#63| state) (|fifo_buffer#0| next_state)) ; $procdff$160 \write_addr
  (= (|fifo_buffer#5#1| state) (|fifo_buffer#5#0| next_state)) ; FIFO
)) ; end of module fifo_buffer
; yosys-smt2-topmod fifo_buffer
; end of yosys output
