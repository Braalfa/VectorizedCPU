module testControlUnit();
	parameter OPCODE_WIDTH = 5;
	logic [OPCODE_WIDTH-1:0] opcodeD;
	
	logic useScalarAluED, isScalarOutputED, isScalarReg1ED, isScalarReg2ED;
	logic resultSelectorWBD;
	logic writeEnableScalarWBD;
	logic writeEnableVectorWBD; 
	logic writeToMemoryEnableMD;
	logic useInmediateED;
	logic [2:0] aluControlED;
	logic outFlagMD;
	logic resetMaskVectorDD;
	logic writeToMaskVectorED;
	
	logic expected_useScalarAluED, expected_isScalarOutputED, expected_isScalarReg1ED, expected_isScalarReg2ED;
	logic expected_resultSelectorWBD;
	logic expected_writeEnableScalarWBD;
	logic expected_writeEnableVectorWBD; 
	logic expected_writeToMemoryEnableMD;
	logic expected_useInmediateED;
	logic [2:0] expected_aluControlED;
	logic expected_outFlagMD;
	logic expected_resetMaskVectorDD;
	logic expected_writeToMaskVectorED;
	
	controlUnit #(.OPCODE_WIDTH(OPCODE_WIDTH)) controlUnit
	(	.opcodeD(opcodeD),
		.useScalarAluED(useScalarAluED),
		.isScalarOutputED(isScalarOutputED), 
		.isScalarReg1ED(isScalarReg1ED), 
		.isScalarReg2ED(isScalarReg2ED),
	   .resultSelectorWBD(resultSelectorWBD),
	   .writeEnableScalarWBD(writeEnableScalarWBD),
	   .writeEnableVectorWBD(writeEnableVectorWBD), 
	   .writeToMemoryEnableMD(writeToMemoryEnableMD),
	   .useInmediateED(useInmediateED),
	   .aluControlED(aluControlED),
	   .outFlagMD(outFlagMD),
		.resetMaskVectorDD(resetMaskVectorDD),
		.writeToMaskVectorED(writeToMaskVectorED)
		);
		
	initial begin
	
		$display ("=============CONTROL UNIT TEST=============");
		
		$display ("=============0=============");
		opcodeD = 5'b0;
		
		expected_useScalarAluED = 1'b0;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b0;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0; 
		
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 0 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 0 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============1=============");
		opcodeD = 5'b1;
		
		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b1;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b1;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b110;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;
		
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 1 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 1 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============2=============");
		opcodeD = 5'b10;
		
		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b1;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b1;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b1;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b110;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;
		
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 2 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 2 FAIL -!=!=!=!=!=!=!"));
		
				
		$display ("=============3=============");
		opcodeD = 5'b11;
		
		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b1;
		expected_isScalarReg1ED = 1'b1;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b1;
		expected_writeEnableScalarWBD = 1'b1;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b110;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;
	
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 3 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 3 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============4=============");
		opcodeD = 5'b100;
		
		expected_useScalarAluED = 1'b0;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b1;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b000;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;
	
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 4 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 4 FAIL -!=!=!=!=!=!=!"));
	
		$display ("=============5=============");
		opcodeD = 5'b101;
		
      expected_useScalarAluED = 1'b0;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b1;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b001;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;
	
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 5 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 5 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============6=============");
		opcodeD = 5'b110;
		
	   expected_useScalarAluED = 1'b0;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b1;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b1;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b010;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;
	
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 6 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 6 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============7=============");
		opcodeD = 5'b111;
		
		expected_useScalarAluED = 1'b0;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b1;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b111;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;
	
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 7 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 7 FAIL -!=!=!=!=!=!=!"));
		
		
		$display ("=============8=============");
		opcodeD = 5'b1000;
		
		expected_useScalarAluED = 1'b0;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b1;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b1;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b1;
		expected_aluControlED = 3'b111;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 8 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 8 FAIL -!=!=!=!=!=!=!"));
		
		
		$display ("=============9=============");
		opcodeD = 5'b1001;
		
		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b1;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b1;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b110;
		expected_outFlagMD = 1'b1;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 9 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 9 FAIL -!=!=!=!=!=!=!"));
		
				
		$display ("=============10=============");
		opcodeD = 5'b1010;
		
		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b1;
		expected_isScalarReg1ED = 1'b1;
		expected_isScalarReg2ED = 1'b1;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b1;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b000;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 10 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 10 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============11=============");
		opcodeD = 5'b1011;
	
		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b1;
		expected_isScalarReg1ED = 1'b1;
		expected_isScalarReg2ED = 1'b1;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b1;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b001;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 11 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 11 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============12=============");
		opcodeD = 5'b1100;
	
		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b1;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b1;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b1;
		expected_aluControlED = 3'b111;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 12 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 12 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============13=============");
		opcodeD = 5'b1101;

		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b1;
		expected_isScalarReg1ED = 1'b1;
		expected_isScalarReg2ED = 1'b1;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b001;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 13 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 13 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============14=============");
		opcodeD = 5'b1110;

		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b1;
		expected_aluControlED = 3'b111;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 14 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 14 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============15=============");
		opcodeD = 5'b1111;

		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b1;
		expected_aluControlED = 3'b111;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 15 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 15 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============16=============");
		opcodeD = 5'b10000;

		expected_useScalarAluED = 1'b1;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b1;
		expected_aluControlED = 3'b111;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b0;

		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 16 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 16 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============17=============");
		opcodeD = 5'b10001;

      expected_useScalarAluED = 1'b0;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b011;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b0;
		expected_writeToMaskVectorED = 1'b1;
		
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 17 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 17 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============18=============");
		opcodeD = 5'b10010;

		expected_useScalarAluED = 1'b0;
		expected_isScalarOutputED = 1'b0;
		expected_isScalarReg1ED = 1'b0;
		expected_isScalarReg2ED = 1'b0;
		expected_resultSelectorWBD = 1'b0;
		expected_writeEnableScalarWBD = 1'b0;
		expected_writeEnableVectorWBD = 1'b0;
		expected_writeToMemoryEnableMD = 1'b0;
		expected_useInmediateED = 1'b0;
		expected_aluControlED = 3'b0;
		expected_outFlagMD = 1'b0;
		expected_resetMaskVectorDD = 1'b1;
		expected_writeToMaskVectorED = 1'b0;
		
		#10
		
		assert (useScalarAluED == expected_useScalarAluED && isScalarOutputED == expected_isScalarOutputED && isScalarReg1ED == expected_isScalarReg1ED &&
				  isScalarReg2ED == expected_isScalarReg2ED && resultSelectorWBD == expected_resultSelectorWBD && writeEnableScalarWBD == expected_writeEnableScalarWBD &&
				  writeEnableVectorWBD == expected_writeEnableVectorWBD && writeToMemoryEnableMD == expected_writeToMemoryEnableMD && useInmediateED == expected_useInmediateED && 
				  aluControlED == expected_aluControlED && outFlagMD == expected_outFlagMD && resetMaskVectorDD == expected_resetMaskVectorDD && writeToMaskVectorED == expected_writeToMaskVectorED)
			begin
				$display ("=============TEST 18 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST 18 FAIL -!=!=!=!=!=!=!"));
		
		
	end


endmodule