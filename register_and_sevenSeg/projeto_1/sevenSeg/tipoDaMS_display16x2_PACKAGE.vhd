PACKAGE tipoDaMS_display16x2_PACKAGE IS
	TYPE state_menu IS (mainMenu ,menuLevel_1, menuLevel_2, menuLevel_3);
	TYPE state_display IS (
		FunctionSet1, FunctionSet2, FunctionSet3, FunctionSet4, 
		ClearDisplay, DisplayControl, EntryMode,
		
		WriteData1_1, WriteData1_2, WriteData1_3, WriteData1_4, WriteData1_5, WriteData1_6, WriteData1_7, WriteData1_8, 
		WriteData1_9, WriteData1_10, WriteData1_11, WriteData1_12, WriteData1_13, WriteData1_14, WriteData1_15, WriteData1_16,
		
		WriteData2_1, WriteData2_2, WriteData2_3, WriteData2_4, WriteData2_5, WriteData2_6, WriteData2_7, WriteData2_8, 
		WriteData2_9, WriteData2_10, WriteData2_11, WriteData2_12, WriteData2_13, WriteData2_14, WriteData2_15, WriteData2_16, 
				
		ReturnHome, SetAddress);
	TYPE state_HCSR04 IS (StandBy, echoSet, echoHeard);
	TYPE lcdMAT_8bits_8STRING IS ARRAY (0 TO 7) OF BIT_VECTOR (7 DOWNTO 0);
	TYPE lcdMAT_8bits_15STRING IS ARRAY (0 TO 14) OF BIT_VECTOR (7 DOWNTO 0);
	TYPE lcdMATFULL_8bits_93STRING IS ARRAY (0 TO 95) OF BIT_VECTOR (7 DOWNTO 0);
	
	TYPE hashTable_15STRING IS ARRAY (0 TO 14) OF INTEGER RANGE 0 TO 1000000;
	TYPE hashTable_FULL IS ARRAY (0 TO 31) OF INTEGER RANGE 0 TO 95;  
END;